//
//  JKRAddressStore.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRCity.h"
#import "JKRCityData.h"
#import "JKRCitySection.h"

@interface JKRAddressStore : NSObject

@property (nonatomic, strong) NSArray<JKRCity *> *cityArray;              ///< 城市列表
@property (nonatomic, strong) NSArray *cityDataArray;                     ///< 城市区域列表
@property (nonatomic, strong) JKRCitySection *currentCity;                ///< 当前选择城市
@property (nonatomic, strong) JKRCitySection *locationCity;               ///< 当前定位城市
@property (nonatomic, strong) JKRCitySection *searchHistoryCity;          ///< 搜索历史城市
@property (nonatomic, strong) JKRCitySection *hotCity;                    ///< 热门城市
@property (nonatomic, strong) NSArray<JKRCitySection *> *cityList;        ///< 城市拼音分组列表
@property (nonatomic, strong) JKRCity *defaultCity;                       ///< 占位城市

singleton_interface(JKRAddressStore)

@end
