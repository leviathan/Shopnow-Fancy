//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

@class SNFTweet;

typedef NS_ENUM(NSUInteger, SNFTableViewCellType) {
    // cell type, which adds a map view to the cell
    SNFTableViewCellTypeMap,
    // cell type, which adds an image view to the cell
    SNFTableViewCellTypeView
};

/**
* A custom table cell, which can display a MapView or ImageView (default) on its left side.
* The right side is filled with two labels.
*
* Note: once created the cell type is not mutable.
*/
@interface SNFTableViewCell : UIView;

/**
* the cell's identifier, which makes it identifiable when used in a collection view.
*/
@property(nonatomic, readonly) NSString *reuseIdentifier;

@property(nonatomic, assign, readonly) SNFTableViewCellType cellType;

/**
* The tweet which is assigned to this cell and whose values are displayed by the cell.
*/
@property(nonatomic, strong) SNFTweet *tweet;

/**
* Creates a new cell with the identifier and cell type.
*/
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(SNFTableViewCellType)cellType;

@end
