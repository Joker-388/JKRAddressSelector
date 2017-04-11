//
//  JKRSelectHeader.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRSelectHeader.h"

@interface JKRSelectHeader ()

@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation JKRSelectHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.headerLabel.frame = CGRectMake(10, 0, 300, 44);
    [self.contentView addSubview:self.headerLabel];
    self.selectAreaButton.frame = CGRectMake(kScreenWidth - 100.f, 0.f, 80.f, 44.f);
    [self.contentView addSubview:self.selectAreaButton];
    return self;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.textColor = [UIColor blackColor];
        _headerLabel.font = [UIFont systemFontOfSize:16.f];
    }
    return _headerLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.headerLabel.text = _title;
}

- (JKRSelectAreaButton *)selectAreaButton {
    if (!_selectAreaButton) {
        _selectAreaButton = [JKRSelectAreaButton buttonWithType:UIButtonTypeCustom];
        [_selectAreaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectAreaButton setTitle:@"选择区县" forState:UIControlStateNormal];
        [_selectAreaButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_selectAreaButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        _selectAreaButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _selectAreaButton;
}

@end
