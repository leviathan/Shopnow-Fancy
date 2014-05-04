//
// Created by Jörg Polakowski on 04/05/14.
// Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

@interface NSObject (SNFSafeConcurrency)

/**
* Use this to perform a block on the main thread, without worrying about
* what thread the original method was executed on.
* And without risking a deadlock
*
* Usage:
*
* runOnMainQueueWithoutDeadlocking(^{ // Do stuff });
*/
- (void)runOnMainQueueWithoutDeadlocking:(void (^)())block;

@end