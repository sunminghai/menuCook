//
//  MenuCell.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeStep.h"

@interface MenuCell : UITableViewCell
/** 制作步骤 */
@property (nonatomic, strong) MakeStep *step;

@end
