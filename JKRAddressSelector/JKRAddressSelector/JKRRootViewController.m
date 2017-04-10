//
//  JKRRootViewController.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRRootViewController.h"
#import "JKRSelectAddressController.h"
#import "JKRNavigationViewController.h"
#import "JKRAddressStore.h"

@interface JKRRootViewController ()

@end

@implementation JKRRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    JKRSelectAddressController *selectAddressController = [[JKRSelectAddressController alloc] init];
    JKRNavigationViewController *navigationViewController = [[JKRNavigationViewController alloc] initWithRootViewController:selectAddressController];
    [self presentViewController:navigationViewController animated:YES completion:nil];
}

@end
