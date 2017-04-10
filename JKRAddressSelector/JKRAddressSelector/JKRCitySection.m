//
//  JKRCitySection.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRCitySection.h"

@implementation JKRCitySection

- (instancetype)initWithTitle:(NSString *)title cities:(nullable NSArray<JKRCity *> *)cities {
    self = [super init];
    self.headerTitle = title;
    if(cities) self.cityArray = [NSMutableArray arrayWithArray:cities];
    return self;
}

@end
