//
//  NSString+Helper.h
//  zhs_app
//
//  Created by shikee_app03 on 14-8-14.
//  Copyright (c) 2014年 zhs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
-(BOOL)isContainStr:(NSString *)str;

-(id)JSONValue;

-(id) md5HexDigest;

@end
