//
//  JKRSelectHeader.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKRSelectAreaButton.h"

@interface JKRSelectHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) JKRSelectAreaButton *selectAreaButton;

@end
