
//
//  JKRCitySelectCell.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRCitySelectCell.h"

@implementation JKRCitySelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = JKRColor(247, 246, 247, 1.0);
    return self;
}

- (void)setCitySection:(JKRCitySection *)citySection {
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _citySection = citySection;
    CGFloat marginH = 10;
    CGFloat marginV = 8;
    CGFloat buttonW = ((kScreenWidth - 10) - (marginH * 4)) / 3.0;
    CGFloat buttonH = buttonW * 0.34;
    for (NSInteger i = 0; i < citySection.cityArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:citySection.cityArray[i].name forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:JKRColor(95, 93, 96, 1.0) forState:UIControlStateNormal];
        button.layer.borderColor = JKRColor(227, 226, 228, 1.0).CGColor;
        button.layer.cornerRadius = 5;
        button.layer.cornerRadius = YES;
        button.layer.borderWidth = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(marginH + (marginH + buttonW) * (i % 3), (marginV + buttonH) * (i / 3), buttonW, buttonH);
        button.accessibilityValue = [NSString stringWithFormat:@"%zd", i];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(cityClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)cityClickWithButton:(UIButton *)sender {
    NSInteger index = [sender.accessibilityValue integerValue];
    [JKRAddressStore sharedJKRAddressStore].currentCity.headerTitle = [NSString stringWithFormat:@"当前：%@全城", self.citySection.cityArray[index].name];
    [[JKRAddressStore sharedJKRAddressStore].currentCity.cityArray removeAllObjects];
    [[JKRAddressStore sharedJKRAddressStore].currentCity.cityArray addObject:self.citySection.cityArray[index]];
    JKRCity *addedCity = self.citySection.cityArray[index];
    if ([[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray containsObject:self.citySection.cityArray[index]]) {
        [[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray removeObject:self.citySection.cityArray[index]];
    }
    [[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray addObject:addedCity];
    if ([JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray.firstObject == [JKRAddressStore sharedJKRAddressStore].defaultCity || [JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray.count > 3) {
        [[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray removeObjectAtIndex:0];
    }
    [self.jkr_viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
