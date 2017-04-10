//
//  JKRCity.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRCity.h"

@implementation JKRCity

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (nil != self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.cityID = [NSString stringWithFormat:@"%zd", [value integerValue]];
    }
}

@end
