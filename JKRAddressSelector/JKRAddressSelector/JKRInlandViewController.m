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

@property (nonatomic, strong) NSArray<JKRCitySection *> *cityList;

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
    [self.tableView registerClass:[JKRInlandCityCell class] forCellReuseIdentifier:CELLID];
    [self.tableView registerClass:[JKRCitySelectCell class] forCellReuseIdentifier:SELCELLID];
    [self.tableView registerClass:[JKRNormalHeader class] forHeaderFooterViewReuseIdentifier:HEADID];
    [self.tableView registerClass:[JKRSelectHeader class] forHeaderFooterViewReuseIdentifier:SELHEADID];
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @strongify(self);
        NSMutableArray *cityArray = [NSMutableArray array];
        [cityArray addObject:[JKRAddressStore sharedJKRAddressStore].currentCity];
        [cityArray addObject:[JKRAddressStore sharedJKRAddressStore].locationCity];
        [cityArray addObject:[JKRAddressStore sharedJKRAddressStore].searchHistoryCity];
        [cityArray addObject:[JKRAddressStore sharedJKRAddressStore].hotCity];
        [cityArray addObjectsFromArray:[JKRAddressStore sharedJKRAddressStore].cityList];
        self.cityList = [NSArray arrayWithArray:cityArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section <= 3) {
        return 1;
    } else {
        return self.cityList[section].cityArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <= 3) {
        NSInteger result = (self.cityList[indexPath.section].cityArray.count / 3) * (44 + 8) + (self.cityList[indexPath.section].cityArray.count % 3 ? (44 + 8) : 0) + 5;
        NSLog(@"%zd", result);
        return result;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JKRNormalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADID];
    header.title = self.cityList[section].headerTitle;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 27.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <= 3) {
        JKRCitySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:SELCELLID];
        cell.citySection = self.cityList[indexPath.section];
        return cell;
    } else {
        JKRInlandCityCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        cell.city = self.cityList[indexPath.section].cityArray[indexPath.row];
        return cell;
    }
}

- (NSArray<JKRCitySection *> *)cityList {
    if (!_cityList) {
        _cityList = [NSArray array];
    }
    return _cityList;
}

@end
