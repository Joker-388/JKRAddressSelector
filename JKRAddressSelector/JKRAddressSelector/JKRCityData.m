
//
//  JKRCityData.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRCityData.h"

@implementation JKRCityData

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.provinceID = value;
    }
}

- (void)setCitylist:(NSArray<JKRCityDetail *> *)citylist {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dict in citylist) {
        JKRCityDetail *cityDetail = [[JKRCityDetail alloc] init];
        [cityDetail setValuesForKeysWithDictionary:dict];
        [result addObject:cityDetail];
    }
    _citylist = [NSArray arrayWithArray:result];
}

@end
