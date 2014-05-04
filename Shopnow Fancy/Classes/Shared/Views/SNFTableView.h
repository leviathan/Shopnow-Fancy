//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

@class SNFTableView;
@class SNFTableViewCell;

/**
* Custom table view delegate definition.
*/
@protocol SNFTableViewDelegate <NSObject, UIScrollViewDelegate>

@optional

/**
* Asks the delegate for the height to use for a row.
*/
- (CGFloat)snfTableView:(SNFTableView *)snfTableView heightForRow:(NSUInteger)row;

/**
* Tells the delegate that the specified row is now selected.
*/
- (void)snfTableView:(SNFTableView *)snfTableView didSelectRow:(NSUInteger)row;

@end

/**
* Custom table view data source definition.
*/
@protocol SNFTableViewDataSource <NSObject>

@required
- (NSUInteger)numberOfRowsInSnfTableView:(SNFTableView *)tableView;
- (SNFTableViewCell *)snfTableView:(SNFTableView *)snfTableView cellForRow:(NSUInteger)row;

@end


@interface SNFTableView : UIScrollView

@property(nonatomic, assign) id <SNFTableViewDataSource> dataSource;
@property(nonatomic, assign) id <SNFTableViewDelegate> delegate;

/**
* The table's row height.
*
* This is ignored, if the delegate responds to snfTableView:heightForRow:
*
* Default: 40.0
*/
@property(nonatomic) CGFloat rowHeight;

/**
* The row margin between each single row.
*
* Default: 2.0
*/
@property(nonatomic) CGFloat rowMargin;


- (SNFTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;

/**
* Reload the table view's data.
*/
- (void)reloadData;

- (NSIndexSet *)indexSetOfVisibleRows;

// exposed here so we can run test measurements - but not part of public interface
- (NSUInteger)findRowForOffsetY:(CGFloat)yPosition inRange:(NSRange)range;

@end
