//
//  JKRAddressStore.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRAddressStore.h"

@implementation JKRAddressStore

singleton_implementation(JKRAddressStore)

- (NSArray *)cityArray {
    if (!_cityArray) {
        NSMutableArray<JKRCityDetail *> *cityDetailArray = [NSMutableArray array];
        [self.cityDataArray enumerateObjectsUsingBlock:^(JKRCityData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.citylist) [cityDetailArray addObjectsFromArray:obj.citylist];
        }];
        
        NSMutableArray *result = [NSMutableArray array];
        NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:cityPath];
        for (NSDictionary *dict in array) {
            JKRCity *city = [[JKRCity alloc] init];
            [city setValuesForKeysWithDictionary:dict];
            for (JKRCityDetail *cityDetail in cityDetailArray) {
                if ([cityDetail.cityName isEqualToString:city.name]) {
                    city.arealist = cityDetail.arealist;
                    break;
                }
            }
            [result addObject:city];
        }
        _cityArray = [NSArray arrayWithArray:result];
    }
    return _cityArray;
}

- (NSArray *)cityDataArray {
    if (!_cityDataArray) {
        NSMutableArray *result = [NSMutableArray array];
        NSString *cityDataPath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:cityDataPath];
        for (NSDictionary *dict in array) {
            JKRCityData *cityData = [[JKRCityData alloc] init];
            [cityData setValuesForKeysWithDictionary:dict];
            [result addObject:cityData];
        }
        _cityDataArray = [NSArray arrayWithArray:result];
    }
    return _cityDataArray;
}

- (NSArray<JKRCitySection *> *)cityList {
    if (!_cityList) {
        NSMutableDictionary<NSString *, NSMutableArray<JKRCity *> *> *result = [NSMutableDictionary dictionary];
        for (JKRCity *city in self.cityArray) {
            NSString *cityPiniyin = city.pinyin;
            NSString *firstWord = [[cityPiniyin substringToIndex:1] uppercaseString];
            if ([[result allKeys] containsObject:firstWord]) {
                [result[firstWord] addObject:city];
            } else {
                result[firstWord] = [NSMutableArray arrayWithObject:city];
            }
        }
        NSArray *keys = [result allKeys];
        keys = [keys sortedArrayUsingSelector:@selector(compare:)];
        
        NSMutableArray *list = [NSMutableArray array];
        for (NSString *key in keys) {
            JKRCitySection *secion = [[JKRCitySection alloc] init];
            secion.headerTitle = key;
            secion.cityArray = result[key];
            [list addObject:secion];
        }
        _cityList = [NSArray arrayWithArray:list];
    }
    return _cityList;
}

- (JKRCitySection *)currentCity {
    if (!_currentCity) {
        _currentCity = [[JKRCitySection alloc] initWithTitle:[NSString stringWithFormat:@"当前: %@", self.defaultCity.name] cities:@[self.defaultCity]];
    }
    return _currentCity;
}

- (JKRCitySection *)locationCity {
    if (!_locationCity) {
        _locationCity = [[JKRCitySection alloc] initWithTitle:@"定位城市" cities:@[]];
    }
    return _locationCity;
}

- (JKRCitySection *)searchHistoryCity {
    if (!_searchHistoryCity) {
        _searchHistoryCity = [[JKRCitySection alloc] initWithTitle:@"最近访问城市" cities:@[]];
    }
    return _searchHistoryCity;
}

- (JKRCitySection *)hotCity {
    if (!_hotCity) {
        NSMutableArray *hotArray = [NSMutableArray array];
        for (JKRCity *city in self.cityArray) {
            if ([self isHotCityName:city.name]) [hotArray addObject:city];
        }
        _hotCity = [[JKRCitySection alloc] initWithTitle:@"热门城市" cities:hotArray.count ? hotArray : @[self.defaultCity]];
    }
    return _hotCity;
}

- (BOOL)isHotCityName:(NSString *)cityName {
    NSArray *hotCityNames = @[@"上海", @"北京", @"广州", @"深圳", @"武汉", @"天津", @"西安", @"南京", @"杭州", @"成都", @"重庆"];
    for (NSString *name in hotCityNames) {
        if ([cityName isEqualToString:name]) return YES;
    }
    return NO;
}

- (JKRCity *)defaultCity {
    if (!_defaultCity) {
        _defaultCity = [[JKRCity alloc] init];
        _defaultCity.name = @"未选择";
    }
    return _defaultCity;
}

@end
