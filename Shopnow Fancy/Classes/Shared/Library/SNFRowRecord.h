//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

@class SNFTableViewCell;

/**
* A cache record, which contains an Y-position and height of a specific table cell.
*/
@interface SNFRowRecord : NSObject

@property(nonatomic) CGFloat startPositionY;
@property(nonatomic) CGFloat height;
@property(nonatomic, strong) SNFTableViewCell *cachedCell;

@end