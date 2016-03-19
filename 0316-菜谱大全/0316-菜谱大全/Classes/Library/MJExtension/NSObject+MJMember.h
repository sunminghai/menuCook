//
//  NSObject+MJMember.h
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJIvar.h"
#import "MJMethod.h"

/**
 *  遍历所有类的block（父类）
 */
typedef void (^MJClassesBlock)(Class c, BOOL *stop);

@interface NSObject (MJMember)

/**
 *  遍历所有的成员变量
 */
- (void)enumerateIvarsWithBlock:(MJIvarsBlock)block;

/**
 *  遍历所有的方法
 */
- (void)enumerateMethodsWithBlock:(MJMethodsBlock)block;

/**
 *  遍历所有的类
 */
- (void)enumerateClassesWithBlock:(MJClassesBlock)block;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com