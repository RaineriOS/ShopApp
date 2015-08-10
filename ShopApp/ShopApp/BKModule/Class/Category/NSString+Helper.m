//
//  NSString+Helper.m
//  zhs_app
//
//  Created by shikee_app03 on 14-8-14.
//  Copyright (c) 2014年 zhs. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helper)
-(BOOL)isContainStr:(NSString *)str
{
    NSRange range=[self rangeOfString:str];
    if(range.location!=NSNotFound){
        return true;
    }else{
        return false;
    }
}

-(id)JSONValue
{
//    NSString *str=self;
    NSData *data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}
-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
