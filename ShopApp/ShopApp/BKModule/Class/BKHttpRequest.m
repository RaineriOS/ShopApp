//
//  BKHttpRequest.m
//  OCModule
//
//  Created by shikee_app03 on 15-4-14.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "BKHttpRequest.h"

@implementation BKHttpRequest
{
    ASINetworkQueue *_queue;
}

static BKHttpRequest *_shared;
static NSMutableArray* _allRequest;

+(id)shared
{
    @synchronized(self)
    {
        if(!_shared){
            _shared=[[BKHttpRequest alloc]init];
        }
        if(!_allRequest){
            _allRequest=[[NSMutableArray alloc]init];
        }
        return _shared;
    }
}


-(void)sendGetRequest:(NSDictionary *)param url:(NSString *)url success:(void(^)(NSDictionary *))successBlock
{
    [self sendRequest:param url:url method:GET isQueue:NO success:successBlock];
}

-(void)sendPostRequest:(NSDictionary *)param url:(NSString *)url success:(void(^)(NSDictionary *))successBlock
{
    [self sendRequest:param url:url method:POST isQueue:NO success:successBlock];
}


-(void)sendRequest:(NSDictionary *)param url:(NSString *)url method:(BKMethod)method isQueue:(BOOL)isQueue success:(void (^)(NSDictionary *))successBlock
{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSArray *keys=[param allKeys];
    NSMutableString *tmpUrl=[NSMutableString stringWithString:url];
    //额外参数____
    
    if(method!=POST){
        
        for (int i=0; i<keys.count; i++) {
            NSString *key=[keys objectAtIndex:i];
            NSString *values=[param valueForKey:key];
            if(i==0){
                [tmpUrl appendString:@"?"];
            }else{
                [tmpUrl appendString:@"&"];
            }
            [tmpUrl appendFormat:@"%@=%@",key,values];
        }
        [request setRequestMethod:@"GET"];
        
        
    }else {
        for (int i=0; i<keys.count; i++) {
            NSString *key=[keys objectAtIndex:i];
            NSString *values=[param valueForKey:key];
            [request setPostValue:values forKey:key];
        }
        [request setRequestMethod:@"POST"];
    }
    
    
    [request setURL:[NSURL URLWithString:tmpUrl]];
    [request setTimeOutSeconds:10];
    __weak ASIFormDataRequest *requestCopy=requestCopy=request;
    
    [request setCompletionBlock:^{
        NSData *data=[requestCopy responseData];
        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        successBlock(responseDic);
    }];
    
    [request setFailedBlock:^{
        ALERT_SHOW(@"傻逼");
    }];
    if(isQueue){
        if(!_queue){
            _queue=[[ASINetworkQueue alloc]init];
            _queue.maxConcurrentOperationCount=1;
            [_queue cancelAllOperations];
        }
        [_queue addOperation:request];
        [_queue go];
    }else {
        [request startAsynchronous];
    }
    
}

-(void)sendGetQueueRequest:(NSDictionary *)param url:(NSString *)url success:(void (^)(NSDictionary *))successBlock
{
    [self sendRequest:param url:url method:GET isQueue:YES success:successBlock];
}

-(void)sendPostQueueRequest:(NSDictionary *)param url:(NSString *)url success:(void (^)(NSDictionary *))successBlock
{
    [self sendRequest:param url:url method:POST isQueue:url success:successBlock];
}

-(void)uploadWithFilePath:(NSString *)filePath url:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSDictionary *))successBlock
{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSArray *keys=[param allKeys];
    NSMutableString *tmpUrl=[NSMutableString stringWithString:url];
    //额外参数____
    for (int i=0; i<keys.count; i++) {
        NSString *key=[keys objectAtIndex:i];
        NSString *values=[param valueForKey:key];
        if(![key isEqualToString:@"bk_fileKey"]){
            [request setPostValue:values forKey:key];
        }
    }
    [request setRequestMethod:@"POST"];
    [request setURL:[NSURL URLWithString:tmpUrl]];
    NSString *fileKey=[param objectForKey:@"bk_fileKey"];
    if([BKToolKit isEmptyWithStr:fileKey]){
        fileKey=@"not found bk_fileKey!";
    }
    [request setFile:filePath forKey:fileKey];
    __weak ASIFormDataRequest *requestCopy=request;
    
    [request setCompletionBlock:^{
        NSData *data=[requestCopy responseData];
        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        successBlock(responseDic);
    }];
    [request startAsynchronous];
    
}


@end
