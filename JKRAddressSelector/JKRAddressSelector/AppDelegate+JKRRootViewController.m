//
//  AppDelegate+JKRRootViewController.m
//  ZHYQ
//
//  Created by Joker on 14/3/15.
//  Copyright © 2014年 Joker. All rights reserved.
//

#import "AppDelegate+JKRRootViewController.h"
#import "JKRRootViewController.h"

@implementation AppDelegate (JKRRootViewController)

- (void)jkr_configRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JKRRootViewController *rootViewController = [JKRRootViewController new];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
}

@end
