//
//  LoginModel.h
//  ShopApp
//
//  Created by shikee_app03 on 15/8/17.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

+(LoginModel *)shared;

@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *avatar;
@end
