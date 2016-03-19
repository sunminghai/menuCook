//
//  ListTabBar.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "ListTabBar.h"
#import "SMHNetworkTool.h"
#import "MJExtension.h"
#import "MenuCategory.h"
#import "UIView+Extension.h"


@interface ListTabBar ()

/** 显示菜类别的滚动栏 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 当前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

static CGFloat margin = 10;

@implementation ListTabBar

#pragma mark - 懒加载
- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

// 为模型数组中赋值,刷新数据
- (void)setMenuList:(NSArray *)menuList {
    _menuList = menuList;
    
     [self addButtons];
}

/** 初始化view */
- (instancetype)initWithFrame:(CGRect)frame{
    ListTabBar *view = [super initWithFrame:frame];
    
    [self addScrollView];
  
    return view;
}
/** 添加scrollView */
- (void)addScrollView {
    CGRect rect = CGRectMake(0, 0, self.width - self.height, self.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
   
}
/** 向scrollView上添加按钮 */
- (void)addButtons {
    CGFloat buttonX = 0;
    CGFloat buttonW = 0;
    
    for (int i = 0; i < self.menuList.count; i++) {
        MenuCategory *category = self.menuList[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:btn];
        
        [self.buttons addObject:btn];
        
        CGSize size = [category.name boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
        buttonW = size.width;
        buttonX += margin;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:category.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(buttonX, 0, buttonW, self.height);
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonX += buttonW;
        
        if (i == 0) {
            [self buttonClick:btn];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(buttonX, 0);
}
/** 点击按钮,设置为选中状态 */
- (void)buttonClick:(UIButton *)button {
    [self.selectedButton setSelected:NO];
    [button setSelected:YES];
    self.selectedButton = button;
    
    if ([self.delegate respondsToSelector:@selector(listTabBar:didSelectedCategory:)]) {
        [self.delegate listTabBar:self didSelectedCategory:self.menuList[button.tag]];
    }
    CGFloat offX = button.x - self.scrollView.contentOffset.x;
    if (offX < 0) {
        [self.scrollView setContentOffset:CGPointMake(button.x - margin, 0) animated:YES];
    } else if (offX >= self.scrollView.width - button.width) {
        [self.scrollView setContentOffset:CGPointMake(button.x + margin + button.width - self.scrollView.width, 0) animated:YES];
    }
}

- (void)selectIndexPath:(NSIndexPath *)indexPath {
    [self buttonClick:self.buttons[indexPath.row]];
}

@end
