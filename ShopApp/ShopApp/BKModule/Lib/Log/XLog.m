
//  XLog.m
//  OCModule
//
//  Created by shikee_app03 on 15-5-5.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "XLog.h"


@implementation XLog
{
    NSInteger logCount;//日志累计数量
    
}


static XLog *_shared;
+(id)shared
{
    @synchronized(self){
        if(!_shared){
            _shared=[[XLog alloc]init];
        }
        return _shared;
    }

}

-(void)error:(NSString *)msg
{
    [self addMsg:msg andType:nil];
}


-(void)info:(NSString *)msg
{
     [self addMsg:msg andType:nil];
}

-(NSData *)getXLogData
{
    NSData *data=[NSData dataWithContentsOfFile:XLogPath];
    return data;
}
-(NSString *)getXLogContent
{
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:XLogPath];
    if(!blHave){
        [[NSFileManager defaultManager] createFileAtPath:XLogPath contents:nil attributes:nil];
    }
    NSError *error;
    NSString *content=[NSString stringWithContentsOfFile:XLogPath encoding:NSUTF8StringEncoding error:&error];
    if(error){
        BKLog(@"读取日志内容的时候产生一个错误:%@",[error description]);
    }
    return content;
}
-(NSInteger )getXLogCount
{
    NSString *content=[self getXLogContent];
    NSArray *ar=[content componentsSeparatedByString:@"\n"];
    return ar.count;
}

-(void)addMsg:(NSString *)msg andType:(NSString *)type
{
    if([self getXLogCount]>XLogMaxCount){
        [self uploadLog];
    }
    NSString* content=[[[[[self getXLogContent]
    stringByAppendingString:@"\n"]
    stringByAppendingString:[BKToolKit formatterTime:[BKToolKit getNowTime]]]
    stringByAppendingString:@":"]
    stringByAppendingString:msg];
    NSError *error;
    [content writeToFile:XLogPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error){
        BKLog(@"写日志内容的时候产生一个错误:%@",[error description]);
        NSLog(@"");
    }
}

/**
 @des 上传成功后自动清空原日志
 
 */
-(void)uploadLog
{
    [[BKHttpRequest shared]uploadWithFilePath:XLogPath url:XLogUploadUrl param:@{@"bk_flieKey": @"file"} success:^(NSDictionary *response) {
        [self cleanLog];
        BKLog(@"上传成功");
    }];
}

-(void)cleanLog
{
    NSString *content=@"";
    NSError *error;
    [content writeToFile:XLogPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error){
        BKLog(@"清空日志内容的时候产生一个错误:%@",[error description]);
    }

}


@end
