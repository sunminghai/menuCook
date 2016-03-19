//
//  UIColor+Extension.m
//  CHANGJIAGNNEWS
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (instancetype)randomColor {
    CGFloat r = arc4random_uniform(256) * 1.0 / 256.0;
    CGFloat g = arc4random_uniform(256) * 1.0 / 256.0;
    CGFloat b = arc4random_uniform(256) * 1.0 / 256.0;
    return [self colorWithRed:r green:g blue:b alpha:1.0];
}

@end
