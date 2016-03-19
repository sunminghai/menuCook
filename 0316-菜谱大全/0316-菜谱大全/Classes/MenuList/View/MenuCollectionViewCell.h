//
//  MenuCollectionViewCell.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCategory.h"

@class MenuCollectionViewCell;
@protocol MenuCollectionViewCellDelegate <NSObject>

@optional
- (void)pushViewController:(UIViewController *)viewController;

@end

@interface MenuCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <MenuCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) MenuCategory *category;

/** 菜品列表 */
@property (nonatomic, strong) NSMutableArray *menuArray;

/** 创建cell */
+ (instancetype)menuCollectionViewCellWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)ID indexPath:(NSIndexPath *)indexPath;
@end
