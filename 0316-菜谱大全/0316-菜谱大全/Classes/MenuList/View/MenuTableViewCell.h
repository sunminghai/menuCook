//
//  MenuTableViewCell.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuList.h"

@interface MenuTableViewCell : UITableViewCell
/** 菜的模型 */
@property (nonatomic, strong) MenuList *menu;

@end
