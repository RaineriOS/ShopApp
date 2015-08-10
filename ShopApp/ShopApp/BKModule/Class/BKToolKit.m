//
//  BKToolKit.m
//  OCModule
//
//  Created by shikee_app03 on 15-5-4.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "BKToolKit.h"

@implementation BKToolKit
+(BOOL)isEmptyWithStr:(NSString *)str{
    if([str isKindOfClass:NSNull.class])
        return YES;
    if(str==nil)
        return YES;
    if(![str isKindOfClass:[NSString class]]){
        BKLog(@"传来的值不属于NSString类型");
        return YES;
    }
    if([str isEqualToString:@"(null)"]){
        return YES;
    }
    if(str.length<=0)
        return YES;
    
    return NO;
}


+(BOOL)isEmptyWithArray:(NSArray *)ar{
    if([ar isKindOfClass:NSNull.class])
        return YES;
    if(ar==nil)
        return YES;
    if(ar.count<=0)
        return YES;
    return NO;
}


+(BOOL)isEmptyWithDict:(NSDictionary *)dict{
    if([dict isKindOfClass:NSNull.class])
        return YES;
    if(dict==nil)
        return YES;
    if(![dict isKindOfClass:NSDictionary.class])
    {
        BKLog(@"调用isEmptyWithDict:方法的时候，传来的值不是NSDictionary类型");
        return YES;
    }
    if(dict.count<=0)
        return YES;
    return NO;
}

+(BOOL)saveToSandbox:(NSData *)data fileName:(NSString *)fileName
{
    NSString *saveSandBoxPath=[[self getSandBoxPath]stringByAppendingPathComponent:fileName];
    NSLog(@"%@",saveSandBoxPath);
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:saveSandBoxPath];
    if(blHave){
        
    }
   return [data writeToFile:saveSandBoxPath atomically:YES];
}

+(NSString *)getSandBoxPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
}

+(NSString*)formatterTime:(long)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(long)getNowTime
{
    return time(NULL);
}

@end
