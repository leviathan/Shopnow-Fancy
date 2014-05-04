//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFTwitterApiClient.h"
#import "SNFTweet.h"

// Social
#import <Accounts/Accounts.h>
#import <Social/Social.h>


//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFTwitterApiClient ()

@property(nonatomic) ACAccountStore *accountStore;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFTwitterApiClient

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

+ (SNFTwitterApiClient *)sharedClient {
    static SNFTwitterApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SNFTwitterApiClient alloc] init];
    });
    return _sharedClient;
}

#pragma mark - public methods

- (BOOL)userHasAccessToTwitter {
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

#pragma mark - Tweets

- (AFHTTPRequestOperation *)getTweetsForSearchTerm:(NSString *)search completionBlock:(void (^)(NSArray *tweets, NSError *error))block {

    // todo dummy implementation to return sample tweets, not really hitting the network

    NSMutableArray *tweets = [NSMutableArray array];

    SNFTweet *tweetA = [[SNFTweet alloc] init];
    tweetA.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetA];

    SNFTweet *tweetB = [[SNFTweet alloc] init];
    tweetB.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetB];

    SNFTweet *tweetC = [[SNFTweet alloc] init];
    tweetC.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetC];

    SNFTweet *tweetD = [[SNFTweet alloc] init];
    tweetD.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetD];

    SNFTweet *tweetE = [[SNFTweet alloc] init];
    tweetE.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetE];

    SNFTweet *tweetF = [[SNFTweet alloc] init];
    tweetF.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetF];

    SNFTweet *tweetG = [[SNFTweet alloc] init];
    tweetG.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetG];

    SNFTweet *tweetH = [[SNFTweet alloc] init];
    tweetH.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetH];

    SNFTweet *tweetI = [[SNFTweet alloc] init];
    tweetI.tweetText = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porta fermentum ornare. Quisque aliquam urna magna, eget condimentum elit amet.";
    [tweets addObject:tweetI];

    if (block) {
        block(tweets, nil);
    }

    return nil;
}

@end
