//
//  JKRInlandViewController.m
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "JKRInlandViewController.h"
#import "JKRCitySelectCell.h"
#import "JKRInlandCityCell.h"
#import "JKRNormalHeader.h"
#import "JKRSelectHeader.h"

@interface JKRInlandViewController ()

@property (nonatomic, strong) NSArray<NSString *> *secionIndexTitles;
@property (nonatomic, assign) BOOL isSelectArea;

@end

@implementation JKRInlandViewController

static NSString *const SELCELLID = @"SELCELLID";
static NSString *const CELLID = @"INLAND_CELL";
static NSString *const SELHEADID = @"SELHEADID";
static NSString *const HEADID = @"HEADID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = JKRColorHex(00bfaf);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexColor = JKRColorHex(00bfaf);
    [self.tableView registerClass:[JKRInlandCityCell class] forCellReuseIdentifier:CELLID];
    [self.tableView registerClass:[JKRCitySelectCell class] forCellReuseIdentifier:SELCELLID];
    [self.tableView registerClass:[JKRNormalHeader class] forHeaderFooterViewReuseIdentifier:HEADID];
    [self.tableView registerClass:[JKRSelectHeader class] forHeaderFooterViewReuseIdentifier:SELHEADID];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [JKRAddressStore sharedJKRAddressStore].cityList.count + 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.isSelectArea ? 1 : 0;
    } else if (section <= 3) {
        return 1;
    } else {
        return [self citySectionWithSection:section].cityArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <= 3) {
        NSInteger result = ([self citySectionWithSection:indexPath.section].cityArray.count / 3) * (44 + 8) + ([self citySectionWithSection:indexPath.section].cityArray.count % 3 ? (44 + 8) : 0);
        return result;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        JKRSelectHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SELHEADID];
        [header.selectAreaButton addTarget:self action:@selector(selectAreaClick:) forControlEvents:UIControlEventTouchUpInside];
        header.title = [self citySectionWithSection:section].headerTitle;
        return header;
    }
    JKRNormalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADID];
    header.title = [self citySectionWithSection:section].headerTitle;
    return header;
}

- (JKRCitySection *)citySectionWithSection:(NSInteger)section {
    if (section == 0) {
        return [JKRAddressStore sharedJKRAddressStore].currentCity;
    }
    if (section == 1) {
        return [JKRAddressStore sharedJKRAddressStore].locationCity;
    }
    if (section == 2) {
        return [JKRAddressStore sharedJKRAddressStore].searchHistoryCity;
    }
    if (section == 3) {
        return [JKRAddressStore sharedJKRAddressStore].hotCity;
    }
    return [JKRAddressStore sharedJKRAddressStore].cityList[section - 4];
}

- (void)selectAreaClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isSelectArea = sender.selected;
    JKRCitySection *citySection = [[JKRCitySection alloc] initWithTitle:[NSString stringWithFormat:@"当前: %@", [JKRAddressStore sharedJKRAddressStore].cityArray.lastObject.name] cities:@[[JKRAddressStore sharedJKRAddressStore].cityArray.lastObject]];
    [JKRAddressStore sharedJKRAddressStore].currentCity = citySection;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section <= 3) {
        return 44.f;
    }
    return 27.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <= 3) {
        JKRCitySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:SELCELLID];
        cell.citySection = [self citySectionWithSection:indexPath.section];
        return cell;
    } else {
        JKRInlandCityCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        cell.city = [self citySectionWithSection:indexPath.section].cityArray[indexPath.row];
        return cell;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.secionIndexTitles;
}

- (NSArray<NSString *> *)secionIndexTitles {
    if (!_secionIndexTitles) {
        NSMutableArray *indexArray = [NSMutableArray arrayWithArray:@[@"!", @"#", @"$", @"*"]];
        [[JKRAddressStore sharedJKRAddressStore].cityList enumerateObjectsUsingBlock:^(JKRCitySection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [indexArray addObject:obj.headerTitle];
        }];
        _secionIndexTitles = [NSArray arrayWithArray:indexArray];
    }
    return _secionIndexTitles;
}

@end
