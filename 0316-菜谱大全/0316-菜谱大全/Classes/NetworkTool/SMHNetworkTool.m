//
//  SMHNetworkTool.m
//  0316-菜谱大全
//
//  Created by 孙明海 on 16/3/16.
//  Copyright © 2016年 孙明海. All rights reserved.
//  AppKey： b45787f61af268922ee67e1219aba227

#import "SMHNetworkTool.h"


static NSString *AppKey = @"b45787f61af268922ee67e1219aba227";

@implementation SMHNetworkTool



- (void)loadWithURL:(NSString *)URLString parameters:(NSDictionary *)params complete:(CompleteBlock)complete {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    [dict setObject:AppKey forKey:@"key"];
    [self POST:URLString parameters:dict complete:complete];
}

/** 发送post请求 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)params complete:(CompleteBlock)complete {
    
    [self POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(task, responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        complete(task, nil, error);
    }];
}

@end
