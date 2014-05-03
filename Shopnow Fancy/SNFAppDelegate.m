//
//  SNFAppDelegate.m
//  Shopnow Fancy
//
//  Created by Jörg Polakowski on 03/05/14.
//  Copyright (c) 2014 Jörg Polakowski. All rights reserved.
//

#import "SNFAppDelegate.h"
#import "SNFViewController.h"

//***************************************************************************************
// private interface declaration
//***************************************************************************************
@interface SNFAppDelegate ()

@property(strong) SNFViewController *mainViewController;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // UI initialization
    self.mainViewController = [[SNFViewController alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
