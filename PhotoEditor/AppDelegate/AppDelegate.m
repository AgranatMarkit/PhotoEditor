//
//  AppDelegate.m
//  PhotoEditor
//
//  Created by Марк on 12/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "AppDelegate.h"
#import "MainFlowViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = UIWindow.new;
    self.window.rootViewController = MainFlowViewController.new;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
