//
//  JKRInlandCityCell.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRInlandCityCell.h"

@interface JKRInlandCityCell ()

@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) CALayer *line;

@end

@implementation JKRInlandCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.cityNameLabel.frame = CGRectMake(10, 0, kScreenWidth - 20, 44);
    self.line.frame = CGRectMake(10, 43, kScreenWidth - 10, 1);
    [self.contentView addSubview:self.cityNameLabel];
    [self.contentView.layer addSublayer:self.line];
    return self;
}

- (void)setCity:(JKRCity *)city {
    _city = city;
    self.cityNameLabel.text = city.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backgroundColor = selected ? JKRColor(247, 246, 247, 1.0) : JKRColor(255, 255, 255, 1.0);
}

- (UILabel *)cityNameLabel {
    if (!_cityNameLabel) {
        _cityNameLabel = [[UILabel alloc] init];
    }
    return _cityNameLabel;
}

- (CALayer *)line {
    if (!_line) {
        _line = [[CALayer alloc] init];
        _line.backgroundColor = JKRColor(237, 236, 238, 1.0).CGColor;
    }
    return _line;
}

@end
