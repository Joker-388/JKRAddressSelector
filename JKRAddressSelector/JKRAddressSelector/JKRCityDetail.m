//
//  JKRCityDetail.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRCityDetail.h"

@implementation JKRCityDetail

- (void)setArealist:(NSArray<JKRCityArea *> *)arealist {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dict in arealist) {
        JKRCityArea *cityArea = [[JKRCityArea alloc] init];
        [cityArea setValuesForKeysWithDictionary:dict];
        [result addObject:cityArea];
    }
    _arealist = [NSArray arrayWithArray:result];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.cityID = value;
    }
}

@end
