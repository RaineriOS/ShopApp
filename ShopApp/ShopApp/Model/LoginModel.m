//
//  LoginModel.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/17.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
static LoginModel * shared;

+(LoginModel *)shared
{
    if(!shared){
        shared=[LoginModel new];
    }
    return shared;
}


-(BOOL)isLogin
{
    return NO;
}
@end
