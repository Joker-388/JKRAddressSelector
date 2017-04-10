//
//  JKRCitySection.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRCity.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRCitySection : NSObject

@property (nonatomic, strong) NSMutableArray<JKRCity *> *cityArray;
@property (nonatomic, strong) NSString *headerTitle;

- (instancetype)initWithTitle:(NSString *)title cities:(nullable NSArray<JKRCity *> *)cities;

@end

NS_ASSUME_NONNULL_END
