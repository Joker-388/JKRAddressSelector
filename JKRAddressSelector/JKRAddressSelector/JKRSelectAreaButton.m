//
//  JKRSelectAreaButton.m
//  JKRAddressSelector
//
//  Created by Lucky on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRSelectAreaButton.h"

@implementation JKRSelectAreaButton

const CGFloat ratio = 5.f/8.f;

- (void)layoutSubviews {
    [super layoutSubviews];
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0.f, 0.f, self.width - 20.f, self.height);
    
    CGFloat imageWidth = 10.f;
    CGFloat imageHeight = 10.f*ratio;
    self.imageView.frame = CGRectMake(self.width - 20.f, (self.height - imageHeight) / 2, imageWidth, imageWidth * ratio);
}

@end
