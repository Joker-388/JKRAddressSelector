//
//  JKRNavigationViewController.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRNavigationViewController.h"

@interface JKRNavigationViewController ()

@end

@implementation JKRNavigationViewController

+ (void)load {
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[JKRNavigationViewController class]]];
    navigationBar.barTintColor = [UIColor whiteColor]; // 设置顶栏背景色，不会被模糊，最直接有效的设置顶栏背景色方法
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
