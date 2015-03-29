//
//  NOCSAppDelegate.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NOCSAppDelegate.h"
#import "NOCSExampleViewController.h"

@implementation NOCSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:[[NOCSExampleViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
