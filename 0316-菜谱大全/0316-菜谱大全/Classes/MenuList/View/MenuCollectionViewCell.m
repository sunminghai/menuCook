//
//  MenuCollectionViewCell.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "SMHNetworkTool.h"
#import "MenuCollectionViewCell.h"
#import "MenuTableViewCell.h"
#import "MenuTableViewController.h"
#import "SMHImageRunLoop.h"
#import "UIView+Extension.h"
#import "MJRefresh.h"
#import "MJExtension.h"


@interface MenuCollectionViewCell () <UITableViewDataSource, UITableViewDelegate>

/** 展示菜品列表 */
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, assign) int pn;

@end

static NSString *ID = @"tableViewCell";

@implementation MenuCollectionViewCell

- (void)setMenuArray:(NSMutableArray *)menuArray {
    _menuArray = menuArray;
    
    [self.tableView reloadData];
}

+ (instancetype)menuCollectionViewCellWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)ID indexPath:(NSIndexPath *)indexPath {
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell setupUI];
    return cell;
}

/** 设置cell */
- (void)setupUI {
    
    self.pn = 1;
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    SMHImageRunLoop *view = [[SMHImageRunLoop alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 200)];
    self.tableView.tableHeaderView = view;
    view.images = @[[UIImage imageNamed:@"cai1"],[UIImage imageNamed:@"cai2"],[UIImage imageNamed:@"cai3"]];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSDictionary *dict = @{@"cid": self.category.id};
        [[SMHNetworkTool manager] loadWithURL:@"http://apis.juhe.cn/cook/index" parameters:dict complete:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            if (error) {
                return ;
            }

            NSArray *data = responseObject[@"result"][@"data"];
            
            self.menuArray = [NSMutableArray arrayWithArray:[MenuList objectArrayWithKeyValuesArray:data]];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    // 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSDictionary *dict = @{@"cid": self.category.id, @"pn": [NSString stringWithFormat:@"%zd", self.pn], @"rn": @"10"};
        
        [[SMHNetworkTool manager] loadWithURL:@"http://apis.juhe.cn/cook/index" parameters:dict complete:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
                return ;
            }
            NSArray *data = responseObject[@"result"][@"data"];
            
            [self.menuArray addObjectsFromArray:[MenuList objectArrayWithKeyValuesArray:data]];
            [self.tableView.mj_footer endRefreshing];
            
            [data writeToFile:@"/Users/sunminghai/Desktop/a.plist" atomically:YES];
            [self.tableView reloadData];
            self.pn++;
        }];
    }];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    MenuList *model = self.menuArray[indexPath.row];
    
    cell.menu = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewController *vc = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.menu = self.menuArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(pushViewController:)]) {
        [self.delegate pushViewController:vc];
    }
}

@end
