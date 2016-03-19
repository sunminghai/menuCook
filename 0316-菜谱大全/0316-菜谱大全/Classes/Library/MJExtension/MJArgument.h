//
//  MJArgument.h
//  ItcastWeibo
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  包装一个方法参数

#import <Foundation/Foundation.h>
/**
 *  包装一个方法参数
 */
@interface MJArgument : NSObject
/** 参数的索引 */
@property (nonatomic, assign) int index;
/** 参数类型 */
@property (nonatomic, copy) NSString *type;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com