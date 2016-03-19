//
//  ListTabBar.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCategory.h"

@class ListTabBar;
@protocol ListTabBarDelegate <NSObject>

@optional

- (void)listTabBar:(ListTabBar *)listTabBar didSelectedCategory:(MenuCategory *)category;

@end


@interface ListTabBar : UIView

/** 设置选中的indexPath */
- (void)selectIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) id <ListTabBarDelegate> delegate;

/** 菜的类别数组 */
@property (nonatomic, strong) NSArray *menuList;



@end
