//
//  NSObject+Helper.m
//  OCModule
//
//  Created by shikee_app03 on 15-5-4.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)
-(NSString*)toString
{
    NSString *result=[NSString stringWithFormat:@"%@",self];
    return result;
}



-(NSString *)getClassName
{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

@end
