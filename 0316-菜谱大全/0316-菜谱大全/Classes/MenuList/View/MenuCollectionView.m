//
//  MenuCollectionView.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "MenuCollectionView.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "MenuCollectionViewCell.h"
#import "SMHNetworkTool.h"
#import "MenuCategory.h"
#import "MenuList.h"
#import "MJExtension.h"

@interface MenuCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, MenuCollectionViewCellDelegate>
/** cell模型数组 */
@property (nonatomic, strong) NSMutableArray *menuArray;

@end

static NSString *ID = @"MenuCollectionViewCell";
@implementation MenuCollectionView

#pragma mark - 懒加载
- (NSMutableArray *)menuArray {
    if (_menuArray == nil) {
        _menuArray = [NSMutableArray arrayWithCapacity:self.menuList.count];
        for (int i = 0; i < self.menuList.count; i++) {
            [_menuArray addObject:[NSNull null]];
        }
    }
    return _menuArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    MenuCollectionView *view = [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    flowLayout.itemSize = view.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    view.pagingEnabled = YES;
    view.bounces = NO;
    view.dataSource = self;
    view.delegate = self;
    [view registerClass:[MenuCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    return view;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCollectionViewCell *cell = [MenuCollectionViewCell menuCollectionViewCellWithCollectionView:collectionView identifier:ID indexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    cell.delegate = self;
    
    if ([self.menuArray[indexPath.row] isKindOfClass:[NSNull class]]) {
        MenuCategory *category = self.menuList[indexPath.row];
        NSDictionary *dict = @{@"cid": category.id};
       [[SMHNetworkTool manager] loadWithURL:@"http://apis.juhe.cn/cook/index" parameters:dict complete:^(NSURLSessionDataTask *task, NSDictionary * responseObject, NSError *error) {
           if (error) {
               return ;
           }
           
//           [responseObject writeToFile:@"/Users/sunminghai/Desktop/a.plist" atomically:YES];
           
           NSArray *data = responseObject[@"result"][@"data"];
           cell.menuArray = [NSMutableArray arrayWithArray:[MenuList objectArrayWithKeyValuesArray:data]];
       }];
    } else {
        cell.menuArray = self.menuArray[indexPath.row];
    }
    
    cell.category = self.menuList[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.width + 0.5;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    if ([self.menuDelegate respondsToSelector:@selector(menuCollectionView:didScrollToIndexPath:)]) {
        [self.menuDelegate menuCollectionView:self didScrollToIndexPath:indexPath];
    }
}

#pragma mark - MenuCollectionViewCellDelegate
- (void)pushViewController:(UIViewController *)viewController {
    if ([self.menuDelegate respondsToSelector:@selector(pushViewController:)]) {
        [self.menuDelegate pushViewController:viewController];
    }
}

@end
