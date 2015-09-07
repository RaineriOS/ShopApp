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


+(CGSize)getAutoSizeWithFontSize:(double)fontSize andText:(NSString *)text andWeight:(double)weight
{
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, weight, 0)];
    tempLabel.font=[UIFont systemFontOfSize:fontSize];
    tempLabel.text=text;
    
    return [self getLabelAutoWeightByLabel:tempLabel].size;
//    CGSize size=CGSizeMake(weight, MAXFLOAT);
//    size=[text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//    return CGSizeMake(size.width, size.height);
}


+(CGRect)getLabelAutoWeightByLabel:(UILabel*)label
{
    if(!label){
        BKLog(@"传来的label为空!");
        return CGRectZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:label.text];
//    NSRange allRange = [label.text rangeOfString:label.text];
//    [attrStr addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:label.font.pointSize]
//                    range:allRange];
//    [attrStr addAttribute:NSForegroundColorAttributeName
//                    value:[UIColor blackColor]
//                    range:allRange];
//    
    CGSize size=CGSizeMake(label.getWidth,MAXFLOAT);
    size=[label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
//    size=[label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return CGRectMake(label.frame.origin.x,label.frame.origin.y,size.width,size.height);
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

+(UIViewController*)getViewCtrollerByView:(UIView*)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+(NSString *)formatRequestParamToString:(NSDictionary *)params
{
    NSString *newParamsStr=@"";
    for (NSString *key in params.allKeys) {
        newParamsStr=[NSString stringWithFormat:@"%@&%@=%@",newParamsStr,key,[params objectForKey:key]];
        //action=xx&name=xxx   ""&name=xxx
    }
    newParamsStr=[newParamsStr substringFromIndex:1];
    return newParamsStr;
}

@end
