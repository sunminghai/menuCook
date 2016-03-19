//
//  MenuIist.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuList : NSObject

/** 菜的 id */
@property (nonatomic, copy) NSString *id;
/** 菜名 */
@property (nonatomic, copy) NSString *title;
/** 菜的信息 */
@property (nonatomic, copy) NSString *imtro;
/** 制作的菜的步骤 */
@property (nonatomic, strong) NSArray *steps;
/** 菜的图片 */
@property (nonatomic, strong) NSArray *albums;
/** 作料 */
@property (nonatomic, copy) NSString *burden;
/** 材料 */
@property (nonatomic, copy) NSString *ingredients;

@end
