//
//  MenuCell.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "MenuCell.h"
#import "UIImageView+WebCache.h"

@interface MenuCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 步骤标题 */
@property (weak, nonatomic) IBOutlet UILabel *stepView;

@end

@implementation MenuCell

- (void)setStep:(MakeStep *)step {
    _step = step;
    self.iconView.image = nil;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:step.img]];
    self.stepView.text = step.step;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
