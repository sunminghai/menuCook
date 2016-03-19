//
//  MenuTableViewCell.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface MenuTableViewCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 菜名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 菜的描述信息 */
@property (weak, nonatomic) IBOutlet UILabel *imtroLabel;

@end

@implementation MenuTableViewCell

- (void)setMenu:(MenuList *)menu {
    _menu = menu;
    
    self.iconView.image = nil;
    self.nameLabel.text = nil;
    self.imtroLabel.text = nil;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[menu.albums firstObject]]];
    self.nameLabel.text = menu.title;
    self.imtroLabel.text = menu.imtro;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
