//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFTableView.h"
#import "SNFRowRecord.h"
#import "SNFTableViewCell.h"
#import "UIGestureRecognizer+BlocksKit.h"


//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFTableView ()

@property(nonatomic) NSMutableArray *rowRecords;
@property(nonatomic) NSMutableSet *reusePool;
@property(nonatomic) NSMutableIndexSet *visibleRows;

- (void)setup;

- (void)layoutTableRows;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFTableView

#pragma mark - Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup]; // called if created via xib file
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup]; // called if created programmatically
    }
    return self;
}

#pragma mark - public methods

- (SNFTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier {

    SNFTableViewCell *poolCell = nil;

    for (SNFTableViewCell *tableViewCell in self.reusePool) {
        if ([tableViewCell.reuseIdentifier isEqualToString:reuseIdentifier]) {
            poolCell = tableViewCell;
            break;
        }
    }

    if (poolCell) {
        [self.reusePool removeObject:poolCell];
    }

    return poolCell;
}

- (void)reloadData {
    [self returnNonVisibleRowsToReusePool:nil];
    [self generateHeightAndOffsetData];
    [self layoutTableRows];
}

- (NSIndexSet *)indexSetOfVisibleRows {
    return self.visibleRows.copy;
}

#pragma mark - UIScrollView overrides

- (void)setContentOffset:(CGPoint)contentOffset {
    // Note: this method is called frequently - needs to be fast
    [super setContentOffset:contentOffset];
    [self layoutTableRows];
}

#pragma mark - private methods

- (void)setup {
    [self setRowHeight:40.0];  // default value for row height
    [self setRowMargin:2.0];
}

- (void)layoutTableRows {
    CGFloat currentStartY = self.contentOffset.y;
    CGFloat currentEndY = currentStartY + CGRectGetHeight(self.frame);

    NSUInteger rowToDisplay = [self findRowForOffsetY:currentStartY inRange:NSMakeRange(0, self.rowRecords.count)];

    NSMutableIndexSet *newVisibleRows = [[NSMutableIndexSet alloc] init];

    if (self.rowRecords.count > 0) {
        CGFloat yOrigin;
        CGFloat rowHeight;
        do {
            [newVisibleRows addIndex:rowToDisplay];

            yOrigin = [self startPositionYForRow:rowToDisplay];
            rowHeight = [self heightForRow:rowToDisplay];

            SNFTableViewCell *cell = [self cachedCellForRow:rowToDisplay];

            // no cached cell found >> request a new one
            if (!cell) {
                cell = [self.dataSource snfTableView:self cellForRow:rowToDisplay];
                [self setCachedCell:cell forRow:rowToDisplay];

                // gesture recognizer handling for the cell
                // todo don't remove all gesture recognizers from the cell, but just the single tap handler, which we've added ourselves
                for (UIGestureRecognizer *gestureRecognizer in cell.gestureRecognizers) {
                    [cell removeGestureRecognizer:gestureRecognizer];
                }
                __weak typeof(self) proxySelf = self;
                UITapGestureRecognizer *singleTap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
                    if ([proxySelf.delegate respondsToSelector:@selector(snfTableView:didSelectRow:)]) {
                        [proxySelf.delegate snfTableView:proxySelf didSelectRow:rowToDisplay];
                    }
                } delay:0.18f];
                [cell addGestureRecognizer:singleTap];

                [cell setFrame:CGRectMake(0.0, yOrigin, CGRectGetWidth(self.bounds), rowHeight - self.rowMargin)];
                [self addSubview:cell];
            }

            rowToDisplay++;
        }
        while (((yOrigin + rowHeight) < currentEndY) && (rowToDisplay < self.rowRecords.count));
    }

    [self returnNonVisibleRowsToReusePool:newVisibleRows];
}

- (void)returnNonVisibleRowsToReusePool:(NSMutableIndexSet *)currentVisibleRows {
    [self.visibleRows removeIndexes:currentVisibleRows];
    [self.visibleRows enumerateIndexesUsingBlock:^(NSUInteger row, BOOL *stop) {
        SNFTableViewCell *tableViewCell = [self cachedCellForRow:row];
        if (tableViewCell) {
            [self.reusePool addObject:tableViewCell];
            [tableViewCell removeFromSuperview];
            [self setCachedCell:nil forRow:row];
        }
    }];
    [self setVisibleRows:currentVisibleRows];
}

- (void)generateHeightAndOffsetData {
    CGFloat currentOffsetY = 0.0;

    BOOL checkHeightForEachRow = [self.delegate respondsToSelector:@selector(snfTableView:heightForRow:)];
    NSUInteger numberOfRows = [self.dataSource numberOfRowsInSnfTableView:self];
    NSMutableArray *newRowRecords = [NSMutableArray array];

    for (NSUInteger row = 0; row < numberOfRows; row++) {
        SNFRowRecord *rowRecord = [[SNFRowRecord alloc] init];

        CGFloat rowHeight = checkHeightForEachRow ? [self.delegate snfTableView:self heightForRow:row] : [self rowHeight];

        [rowRecord setHeight:rowHeight + self.rowMargin];
        [rowRecord setStartPositionY:currentOffsetY + self.rowMargin];

        [newRowRecords insertObject:rowRecord atIndex:row];

        currentOffsetY = currentOffsetY + rowHeight + self.rowMargin;
    }

    [self setRowRecords:newRowRecords];
    [self setContentSize:CGSizeMake(CGRectGetWidth(self.bounds), currentOffsetY)];
}

- (NSUInteger)findRowForOffsetY:(CGFloat)yPosition inRange:(NSRange)range {
    if (self.rowRecords.count == 0) {
        return 0;
    }

    SNFRowRecord *rowRecord = [[SNFRowRecord alloc] init];
    [rowRecord setStartPositionY:yPosition];

    NSUInteger returnValue = [self.rowRecords indexOfObject:rowRecord
                                              inSortedRange:NSMakeRange(0, self.rowRecords.count)
                                                    options:NSBinarySearchingInsertionIndex
                                            usingComparator:^NSComparisonResult(SNFRowRecord *rowRecord1, SNFRowRecord *rowRecord2) {
                if ([rowRecord1 startPositionY] < [rowRecord2 startPositionY]) {
                    return NSOrderedAscending;
                }
                return NSOrderedDescending;
            }];
    if (returnValue == 0) {
        return 0;
    }
    else {
        return returnValue - 1;
    }
}

#pragma mark - convenience methods for accessing row records

- (CGFloat)startPositionYForRow:(NSUInteger)row {
    return ((SNFRowRecord *) self.rowRecords[row]).startPositionY;
}

- (CGFloat)heightForRow:(NSUInteger)row {
    return ((SNFRowRecord *) self.rowRecords[row]).height;
}

- (SNFTableViewCell *)cachedCellForRow:(NSUInteger)row {
    return ((SNFRowRecord *) self.rowRecords[row]).cachedCell;
}

- (void)setCachedCell:(SNFTableViewCell *)cell forRow:(NSUInteger)row {
    ((SNFRowRecord *) self.rowRecords[row]).cachedCell = cell;
}

// lazy initialization

- (NSMutableSet *)reusePool {
    if (!_reusePool) {
        _reusePool = [[NSMutableSet alloc] init];
    }
    return _reusePool;
}

- (NSMutableIndexSet *)visibleRows {
    if (!_visibleRows) {
        _visibleRows = [[NSMutableIndexSet alloc] init];
    }
    return _visibleRows;
}

@end
