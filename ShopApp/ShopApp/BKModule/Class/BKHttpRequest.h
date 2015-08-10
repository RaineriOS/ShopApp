//
//  BKHttpRequest.h
//  OCModule
//
//  Created by shikee_app03 on 15-4-14.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

typedef enum {
    GET=0,
    POST,
}BKMethod;

@interface BKHttpRequest : NSObject
{
    
}

+(id)shared;

/**
 @description
 普通异步GET 请求
 @param param<NSDictionary> 请求参数
 @param url<NSString> 完整的请求链接
 @param success<Block> 请求成功执行的操作
 */
-(void)sendGetRequest:(NSDictionary *)param url:(NSString *)url success:(void(^)(NSDictionary *response)) successBlock;

/**
 @description
 普通异步POST 请求
 @param param<NSDictionary> 请求参数
 @param url<NSString> 完整的请求链接
 @param success<Block> 请求成功执行的操作
 */
-(void)sendPostRequest:(NSDictionary *)param url:(NSString *)url success:(void(^)(NSDictionary *response)) successBlock;

/**
 @description
 队列 GET 请求
 @param param<NSDictionary> 请求参数
 @param url<NSString> 完整的请求链接
 @param success<Block> 请求成功执行的操作
 */
-(void)sendGetQueueRequest:(NSDictionary *)param url:(NSString *)url success:(void(^)(NSDictionary *response)) successBlock;


/**
 @description 
 队列 POST 请求
 @param param<NSDictionary> 请求参数
 @param url<NSString> 完整的请求链接
 @param success<Block> 请求成功执行的操作
 */
-(void)sendPostQueueRequest:(NSDictionary *)param url:(NSString *)url success:(void(^)(NSDictionary *response)) successBlock;

/**
 @description
 普通 上传
 @param filePath <NSString> 文件完整路径
 @param url<NSString> 完整的请求链接
 @param param<NSDictionary> 请求参数 必须传入@"keyName":@"bk_fileKey",用于标记文件key
 @param success<Block> 请求成功执行的操作
 */
-(void)uploadWithFilePath:(NSString *)filePath url:(NSString *)url param:(NSDictionary *)param success:(void(^)(NSDictionary *response)) successBlock;
@end
