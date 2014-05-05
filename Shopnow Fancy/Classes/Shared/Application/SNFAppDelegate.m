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

@property(nonatomic) SNFViewController *mainViewController;

@end


//***************************************************************************************
// public interface implementation
//***************************************************************************************
@implementation SNFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // UI initialization
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Create view controller. Possible override point for iPhone & iPad separation
    self.mainViewController = [[SNFViewController alloc] init];

    UINavigationController *navigationController = [[UINavigationController alloc] init];
    [navigationController pushViewController:self.mainViewController animated:NO];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
