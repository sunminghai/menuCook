//
//  SMHNetworkTool.h
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^CompleteBlock) (NSURLSessionDataTask *task, id responseObject, NSError *error);

@interface SMHNetworkTool : AFHTTPSessionManager

/** 加载数据 */
- (void)loadWithURL:(NSString *)URLString parameters:(NSDictionary *)params complete:(CompleteBlock)complete;

@end
