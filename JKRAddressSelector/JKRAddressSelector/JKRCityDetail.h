//
//  JKRCityDetail.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRCityArea.h"

@interface JKRCityDetail : NSObject

@property (nonatomic, strong) NSArray<JKRCityArea *> *arealist;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityID;

@end
