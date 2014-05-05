//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFTableViewCell.h"
#import "SNFTweet.h"

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFTableViewCell ()

@property(nonatomic, readwrite) NSString *reuseIdentifier;

@property(nonatomic, assign, readwrite) SNFTableViewCellType cellType;

/**
* The map view on the cell's left side. Whether this is available or not, depends on the cell type.
*/
@property(nonatomic) MKMapView *mapView;

/**
* The image view on the cell's left side. Whether this is available or not, depends on the cell type.
*/
@property(nonatomic) UIImageView *imageView;

@property(nonatomic) UILabel *labelOne;
@property(nonatomic) UILabel *labelTwo;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFTableViewCell

#pragma mark - Lifecycle

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(SNFTableViewCellType)cellType {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setReuseIdentifier:reuseIdentifier];
        [self setCellType:cellType];

        self.backgroundColor = [UIColor darkGrayColor];

        // cell's left side
        if (cellType == SNFTableViewCellTypeMap) {
            self.mapView = [[MKMapView alloc] initWithFrame:CGRectNull];
            self.mapView.backgroundColor = [UIColor purpleColor]; // todo dummy color to keep the map view distinguishable to the image view
            [self addSubview:self.mapView];
        }
        else { // Default: SNFTableViewCellTypeView
            self.imageView = [[UIImageView alloc] initWithFrame:CGRectNull];
            self.imageView.backgroundColor = [UIColor orangeColor]; // todo dummy color to keep the image view distinguishable to the map view
            [self addSubview:self.imageView];
        }

        // cell's right side (2 labels)
        self.labelOne = [[UILabel alloc] initWithFrame:CGRectNull];
        self.labelOne.numberOfLines = 0; // multiline label
        self.labelOne.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.labelOne];

        self.labelTwo = [[UILabel alloc] initWithFrame:CGRectNull];
        self.labelTwo.numberOfLines = 0; // multiline label
        self.labelTwo.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.labelTwo];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // layout left side
    CGFloat leftWidth = 200.0f;
    CGRect leftFrame = CGRectMake(0, 0, leftWidth, CGRectGetHeight(self.frame));
    if (self.cellType == SNFTableViewCellTypeMap) {
        self.mapView.frame = leftFrame;
    }
    else { // Default: SNFTableViewCellTypeView
        self.imageView.frame = leftFrame;
    }

    // layout right side
    self.labelOne.frame = CGRectMake(leftWidth, 0, CGRectGetWidth(self.frame) - leftWidth, CGRectGetHeight(self.frame) / 2);
    self.labelTwo.frame = CGRectMake(leftWidth, CGRectGetMaxY(self.labelOne.frame), CGRectGetWidth(self.frame) - leftWidth,
            CGRectGetHeight(self.frame) / 2);
}

#pragma mark - public methods

- (void)setTweet:(SNFTweet *)tweet {
    _tweet = tweet;

    self.labelOne.text = tweet.tweetText;
    self.labelTwo.text = tweet.tweetText;

    [self setNeedsDisplay];
}

@end
