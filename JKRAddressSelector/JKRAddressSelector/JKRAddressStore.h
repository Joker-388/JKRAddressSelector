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

@property (nonatomic, strong) NSArray<JKRCity *> *cityArray;
@property (nonatomic, strong) NSArray *cityDataArray;
@property (nonatomic, strong) JKRCitySection *currentCity;
@property (nonatomic, strong) JKRCitySection *locationCity;
@property (nonatomic, strong) JKRCitySection *searchHistoryCity;
@property (nonatomic, strong) JKRCitySection *hotCity;
@property (nonatomic, strong) NSArray<JKRCitySection *> *cityList;
@property (nonatomic, strong) JKRCity *defaultCity;

singleton_interface(JKRAddressStore)

@end
