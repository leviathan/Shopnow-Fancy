//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFDefaultDataSource.h"

@interface SNFTwitterDataSource : SNFDefaultDataSource

/**
* Returns the singleton instance of this data source.
*/
+ (SNFTwitterDataSource *)sharedDataSource;

/**
* Updates the data-source for the specified search term.
*
* Registered delegates will be notified.
*/
- (void)updateTweetsFor:(NSString *)searchTerm;

@end
