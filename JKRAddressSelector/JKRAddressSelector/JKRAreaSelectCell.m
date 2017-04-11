//
//  JKRAreaSelectCell.m
//  JKRAddressSelector
//
//  Created by Lucky on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRAreaSelectCell.h"

@implementation JKRAreaSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
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
    for (NSInteger i = 0; i < citySection.cityArray.firstObject.arealist.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:citySection.cityArray.firstObject.arealist[i].areaName forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:JKRColor(95, 93, 96, 1.0) forState:UIControlStateNormal];
        button.layer.borderColor = JKRColor(227, 226, 228, 1.0).CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.layer.cornerRadius = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(marginH + (marginH + buttonW) * (i % 3), (marginV + buttonH) * (i / 3), buttonW, buttonH);
        button.accessibilityValue = [NSString stringWithFormat:@"%zd", i];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(areaClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)areaClickWithButton:(UIButton *)sender {
    NSInteger index = [sender.accessibilityValue integerValue];
    self.citySection.cityArray.firstObject.selectArea = self.citySection.cityArray.firstObject.arealist[index];
    self.citySection.headerTitle = [NSString stringWithFormat:@"当前：%@%@", self.citySection.cityArray.firstObject.name, self.citySection.cityArray.firstObject.selectArea.areaName];
    [JKRAddressStore sharedJKRAddressStore].currentCity = self.citySection;
    [self.jkr_viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
