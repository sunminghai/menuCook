//
//  Category.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuCategory : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

@end
