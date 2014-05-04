//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

@interface SNFTwitterApiClient : NSObject

+ (SNFTwitterApiClient *)sharedClient;

- (BOOL)userHasAccessToTwitter;

/**
* Returns tweets for the specified search term.
*/
- (AFHTTPRequestOperation *)getTweetsForSearchTerm:(NSString *)search
                                   completionBlock:(void (^)(NSArray *tweets, NSError *error))block;

@end
