//
//  MJMember.m
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJMember.h"
#import "MJExtension.h"
#import "MJFoundation.h"
#import "MJConst.h"

@implementation MJMember


/**
 *  初始化
 *
 *  @param srcObject 来源于哪个对象
 *
 *  @return 初始化好的对象
 */
- (instancetype)initWithSrcObject:(id)srcObject
{
    if (self = [super init]) {
        _srcObject = srcObject;
    }
    return self;
}

- (void)setSrcClass:(Class)srcClass
{
    _srcClass = srcClass;
    
    MJAssertParamNotNil(srcClass);
    
    _srcClassFromFoundation = [MJFoundation isClassFromFoundation:srcClass];
}

MJLogAllIvrs
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com