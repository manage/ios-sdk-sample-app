//
//  ASTAppDelegate.m
//  AppSponserTest
//
//  Created by Mike Sergio on 5/31/13.
//  Copyright (c) 2013 AST. All rights reserved.
//

#import "ASTAppDelegate.h"
#import <AppSponserSDK/ASPopupAdController.h>

#define AD_ZONE @"6hPl8LCmW-da3YlWY7uSEQ"

@implementation ASTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    ASPopupAdController *controller = [[ASPopupAdController alloc] initWithZoneId:AD_ZONE];
    controller.testMode = YES;
    [controller presentAd];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
