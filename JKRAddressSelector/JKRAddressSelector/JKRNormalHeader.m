//
//  JKRNormalHeader.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRNormalHeader.h"

@interface JKRNormalHeader ()

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) CALayer *line;

@end

@implementation JKRNormalHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.headerLabel.frame = CGRectMake(10, 0, kScreenWidth , 27);
    self.headerLabel.font = [UIFont systemFontOfSize:16];
    self.headerLabel.textColor = JKRColor(165, 163, 166, 1.0);
    self.contentView.backgroundColor = JKRColor(247, 246, 247, 1.0);
    [self.contentView addSubview:self.headerLabel];
    self.line.frame = CGRectMake(0, -1, kScreenWidth, 1);
    [self.contentView.layer addSublayer:self.line];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.height == 44.f) {
        self.headerLabel.y = 12;
        self.line.hidden = YES;
    } else {
        self.headerLabel.y = 0;
        self.line.hidden = NO;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.headerLabel.text = title;
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
    }
    return _headerLabel;
}

- (CALayer *)line {
    if (!_line) {
        _line = [[CALayer alloc] init];
        _line.backgroundColor = JKRColor(241, 240, 241, 1.0).CGColor;
    }
    return _line;
}

@end
