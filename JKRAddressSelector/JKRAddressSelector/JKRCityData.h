//
//  JKRCityData.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRCityDetail.h"

@interface JKRCityData : NSObject

@property (nonatomic, strong) NSArray<JKRCityDetail *> *citylist;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *provinceID;

@end
