
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
        button.frame = CGRectMake(marginH + (marginH + buttonW) * (i % 3), (marginV + buttonH) * (i / 3), buttonW, buttonH);
        [self.contentView addSubview:button];
    }
}

@end
