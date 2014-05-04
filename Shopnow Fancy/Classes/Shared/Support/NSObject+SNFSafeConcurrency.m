//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "NSObject+SNFSafeConcurrency.h"

@implementation NSObject (SNFSafeConcurrency)

- (void)runOnMainQueueWithoutDeadlocking:(void (^)())block {
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@end
