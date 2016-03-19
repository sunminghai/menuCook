//
//  MenuCollectionView.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCategory.h"

@class MenuCollectionView;
@protocol MenuCollectionViewDelegate <NSObject>

@optional

- (void)menuCollectionView:(MenuCollectionView *)menuCollectionView didScrollToIndexPath:(NSIndexPath *)indexPath;

- (void)pushViewController:(UIViewController *)viewController;

@end

@interface MenuCollectionView : UICollectionView

@property (nonatomic, weak) id <MenuCollectionViewDelegate> menuDelegate;

/** 菜的类别数组 */
@property (nonatomic, strong) NSArray *menuList;


@end
