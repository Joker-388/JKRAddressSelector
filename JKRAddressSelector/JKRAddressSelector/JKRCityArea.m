//
//  JKRCityArea.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRCityArea.h"

@implementation JKRCityArea

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.areaID = value;
    }
}

@end
