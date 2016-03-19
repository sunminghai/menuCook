//
//  MenuListViewController.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "MenuListViewController.h"
#import "ListTabBar.h"
#import "UIView+Extension.h"
#import "MenuCollectionView.h"
#import "MJExtension.h"
#import "SMHImageRunLoop.h"

@interface MenuListViewController () <ListTabBarDelegate, MenuCollectionViewDelegate>

/** 菜的类别数组 */
@property (nonatomic, strong) NSArray *menuList;
/** 下面菜的collectionView */
@property (nonatomic, strong) MenuCollectionView *collectionView;
/** tabbar */
@property (nonatomic, strong) ListTabBar *tabBar;

@end

@implementation MenuListViewController

#pragma mark - 懒加载
- (NSArray *)menuList {
    if (_menuList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"category.plist" ofType:nil];
        _menuList = [MenuCategory objectArrayWithFile:path];
    }
    return _menuList;
}

#pragma mark - 声明周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStyle];
    [self addTabBarView];
    [self addCollectionView];
    
}
/** 添加CollectionView */
- (void)addCollectionView {
    MenuCollectionView *collectionView = [[MenuCollectionView alloc] initWithFrame:CGRectMake(0, 108, self.view.width, self.view.height - 108)];
    self.collectionView = collectionView;
    collectionView.menuList = self.menuList;

    
    collectionView.menuDelegate = self;
    
    [self.view addSubview:collectionView];
}

/** 添加tabbarview */
- (void)addTabBarView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect rect = CGRectMake(0, 64, self.view.width, 44);
    ListTabBar *tabBar = [[ListTabBar alloc] initWithFrame:rect];
    self.tabBar = tabBar;
    tabBar.menuList = self.menuList;
    tabBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tabBar];
    tabBar.delegate = self;
    
}

#pragma mark - ListTabBarDelegate
- (void)listTabBar:(ListTabBar *)listTabBar didSelectedCategory:(MenuCategory *)category {
    NSInteger index = [self.menuList indexOfObject:category];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - MenuCollectionViewDelegate
- (void)menuCollectionView:(MenuCollectionView *)menuCollectionView didScrollToIndexPath:(NSIndexPath *)indexPath {
    [self.tabBar selectIndexPath:indexPath];
}

- (void)pushViewController:(UIViewController *)viewController {
    [self.navigationController pushViewController:viewController animated:YES];
}

/** 设置外观 */
- (void)setStyle {
    [self.view setBackgroundColor:[UIColor greenColor]];
    self.title = @"菜谱大全";
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
}

@end
