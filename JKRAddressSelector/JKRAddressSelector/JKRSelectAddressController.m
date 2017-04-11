//
//  JKRSelectAddressController.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRSelectAddressController.h"
#import "JKRInlandViewController.h"
#import "JKRForeignViewController.h"

@interface JKRSelectAddressController ()

@property (nonatomic, strong) JKRInlandViewController *inlandViewController;
@property (nonatomic, strong) JKRForeignViewController *foreignViewController;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation JKRSelectAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentedControl.frame = CGRectMake(0.f, 0.f, 160.f, 30.f);
    self.navigationItem.titleView = self.segmentedControl;
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0.f, 0.f, 20.f, 20.f);
    [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = closeButtonItem;
    
    [self addChildViewController:self.inlandViewController];
    [self addChildViewController:self.foreignViewController];
    
    [self.view addSubview:self.inlandViewController.view];
}

- (void)closeButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeMode {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        [self.foreignViewController.view removeFromSuperview];
        [self.view addSubview:self.inlandViewController.view];
    } else {
        [self.inlandViewController.view removeFromSuperview];
        [self.view addSubview:self.foreignViewController.view];
    }
}

- (JKRInlandViewController *)inlandViewController {
    if (!_inlandViewController) {
        _inlandViewController = [[JKRInlandViewController alloc] init];
        _inlandViewController.view.frame = CGRectMake(0, 64.f, kScreenWidth, kScreenHeight - 64.f);
    }
    return _inlandViewController;
}

- (JKRForeignViewController *)foreignViewController {
    if (!_foreignViewController) {
        _foreignViewController = [[JKRForeignViewController alloc] init];
        _foreignViewController.view.frame = CGRectMake(0, 64.f, kScreenWidth, kScreenHeight - 64.f);
    }
    return _foreignViewController;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"国内", @"海外"]];
        [_segmentedControl addTarget:self action:@selector(changeMode) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.tintColor = JKRColorHex(00bfaf);
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}

- (void)dealloc {
    NSLog(@"Address controller dealloc");
}

@end
