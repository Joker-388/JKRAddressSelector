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
#import "JKRAreaSelectCell.h"
#import "JKRShadowView.h"

@interface JKRInlandViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *secionIndexTitles;
@property (nonatomic, assign) BOOL isSelectArea;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, assign) BOOL isSearching;
@property (nonatomic, strong) JKRShadowView *shadowView;

@end

@implementation JKRInlandViewController

static NSString *const SELCELLID = @"SELCELLID";
static NSString *const CELLID = @"INLAND_CELL";
static NSString *const SELHEADID = @"SELHEADID";
static NSString *const HEADID = @"HEADID";
static NSString *const ARESCELLID = @"ARESCELLID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexColor = JKRColorHex(00bfaf);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.tableView registerClass:[JKRInlandCityCell class] forCellReuseIdentifier:CELLID];
    [self.tableView registerClass:[JKRCitySelectCell class] forCellReuseIdentifier:SELCELLID];
    [self.tableView registerClass:[JKRNormalHeader class] forHeaderFooterViewReuseIdentifier:HEADID];
    [self.tableView registerClass:[JKRSelectHeader class] forHeaderFooterViewReuseIdentifier:SELHEADID];
    [self.tableView registerClass:[JKRAreaSelectCell class] forCellReuseIdentifier:ARESCELLID];
    self.shadowView.frame = CGRectMake(0.f, 108.f, kScreenWidth, kScreenHeight - 108.f);
    @weakify(self);
    [self.shadowView jkr_addTapGestureRecognizerWithBlock:^(UIGestureRecognizer *gestureRecognizer) {
        @strongify(self);
        self.isSearching = NO;
        [self.tableView reloadSectionIndexTitles];
        self.searchController.active = NO;
    }];
}

#pragma mark - Table view data source

- (void)willPresentSearchController:(UISearchController *)searchController {
    

}

- (void)didPresentSearchController:(UISearchController *)searchController {
    self.isSearching = YES;
    [self.tableView reloadSectionIndexTitles];
    [searchController.view.superview addSubview:self.shadowView];
}

- (void)willDismissSearchController:(UISearchController *)searchController {

}

- (void)didDismissSearchController:(UISearchController *)searchController {
    self.isSearching = NO;
    [self.tableView reloadSectionIndexTitles];
}

// 修改searchBar取消按钮的字体大小
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    for (UIView *view in [[searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        }
    }
}

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
    if (indexPath.section == 0) {
        NSInteger result = ([self citySectionWithSection:indexPath.section].cityArray.firstObject.arealist.count / 3) * (44 + 8) + ([self citySectionWithSection:indexPath.section].cityArray.firstObject.arealist.count % 3 ? (44 + 8) : 0);
        return result;
    }
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
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section <= 3) {
        return 44.f;
    }
    return 27.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JKRAreaSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ARESCELLID];
        cell.citySection = [self citySectionWithSection:indexPath.section];
        return cell;
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 3) {
        [JKRAddressStore sharedJKRAddressStore].currentCity.headerTitle = [NSString stringWithFormat:@"当前：%@全城", [self citySectionWithSection:indexPath.section].cityArray[indexPath.row].name];
        [[JKRAddressStore sharedJKRAddressStore].currentCity.cityArray removeAllObjects];
        [[JKRAddressStore sharedJKRAddressStore].currentCity.cityArray addObject:[self citySectionWithSection:indexPath.section].cityArray[indexPath.row]];
        if ([JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray.firstObject == [JKRAddressStore sharedJKRAddressStore].defaultCity || [JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray.count >= 3) {
            [[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray removeObjectAtIndex:0];
        }
        if ([[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray containsObject:[self citySectionWithSection:indexPath.section].cityArray[indexPath.row]]) {
            [[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray removeObject:[self citySectionWithSection:indexPath.section].cityArray[indexPath.row]];
        }
        [[JKRAddressStore sharedJKRAddressStore].searchHistoryCity.cityArray addObject:[self citySectionWithSection:indexPath.section].cityArray[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
           [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.isSearching ? nil : self.secionIndexTitles;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
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

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.tintColor = [UIColor grayColor];
        // 去掉searchBar的背景线条，会导致searhBar的背景失效，searchbar的颜色其实是透明出底层试图的颜色
        NSArray *subViews = _searchController.searchBar.subviews.firstObject.subviews;
        for (id view in subViews) {
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
            }
        }
        UITextField *textField = [_searchController.searchBar valueForKey:@"_searchField"];
        textField.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"输入城市名或拼音查询";
        [_searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    }
    return _searchController;
}

- (JKRShadowView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[JKRShadowView alloc] init];
    }
    return _shadowView;
}

- (void)dealloc {
    NSLog(@"Address childViewController dealloc");
}

@end
