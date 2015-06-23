//
//  ZZRequestManager.h
//  WaterBBS
//
//  Created by zezefamily on 15/6/6.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"


@interface ZZRequestManager : NSObject

/***
 网络数据请求
 @function
 @param  URL      用于请求的HTTP协议
 @param  params   请求需要填入的参数
 @param  getDict  请求成功返回的数据
 @param  getError 请求失败返回的数据
*/
+ (void)ZZPostWithURL:(NSString *)URL params:(NSDictionary *)params success:(void(^)(NSDictionary *dict))getDict failure:(void(^)(NSError *error))getError;

@end
