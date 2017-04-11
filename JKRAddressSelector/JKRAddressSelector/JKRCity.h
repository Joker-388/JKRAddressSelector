//
//  JKRCity.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRCityArea.h"

@interface JKRCity : NSObject

@property (nonatomic, strong) NSString *divisionStr;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *isOpen;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pinyin;
@property (nonatomic, strong) NSArray<JKRCityArea *> *arealist;
@property (nonatomic, strong) JKRCityArea *selectArea;

@end
