
//
//  MenuIist.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/17.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "MenuList.h"
#import "MJExtension.h"
#import "MakeStep.h"

@implementation MenuList

- (NSDictionary *)objectClassInArray {
    return @{@"steps": [MakeStep class]};
}

@end
