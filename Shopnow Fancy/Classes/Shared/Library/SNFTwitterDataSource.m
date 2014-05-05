//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFTwitterDataSource.h"
#import "SNFTwitterApiClient.h"

// Categories
#import "NSObject+SNFSafeConcurrency.h"

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFTwitterDataSource ()

/**
* Reference to an already running Twitter network request operation.
*/
@property(nonatomic, weak) AFHTTPRequestOperation *tweetOperation;

@property(nonatomic) NSArray *tweetsStorage;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFTwitterDataSource

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self) {
        self.tweetsStorage = [NSArray array];
    }
    return self;
}

+ (SNFTwitterDataSource *)sharedDataSource {
    static SNFTwitterDataSource *sharedDataSource = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataSource = [[SNFTwitterDataSource alloc] init];
    });
    return sharedDataSource;
}

#pragma mark - public methods

- (NSArray *)dataItems {
    return [NSArray arrayWithArray:self.tweetsStorage];
}

- (void)update:(BOOL)forceUpdate {
    NSAssert(NO, @"Method 'forceUpdate' not implemented by SNFTwitterDataSource - use updateTweetsFor: instead");
}

- (void)updateTweetsFor:(NSString *)searchTerm {
    // cancel any previous twitter network request
    if (self.tweetOperation) {
        [self.tweetOperation cancel];
    }

    // request new EPG data for provided date
    __weak typeof (self) proxySelf = self;
    self.tweetOperation = [[SNFTwitterApiClient sharedClient] getTweetsForSearchTerm:searchTerm completionBlock:^(NSArray *tweets, NSError *error) {
        if (!error) {
            // store the tweets in the in-memory cache
            proxySelf.tweetsStorage = tweets;

            // notify delegates about data changes
            [proxySelf runOnMainQueueWithoutDeadlocking:^{
                SNFDataSourcePackage *package = [[SNFDataSourcePackage alloc] initWith:proxySelf error:nil];
                [proxySelf performSelectorOnDelegates:@selector(didUpdateDataSourceSuccessfully:) object:package];
            }];
        }
        else {
            // notify delegates about data update error
            [proxySelf runOnMainQueueWithoutDeadlocking:^{
                SNFDataSourcePackage *package = [[SNFDataSourcePackage alloc] initWith:proxySelf error:error];
                [proxySelf performSelectorOnDelegates:@selector(updateDidFailWith:) object:package];
            }];
        }
    }];
}

@end
