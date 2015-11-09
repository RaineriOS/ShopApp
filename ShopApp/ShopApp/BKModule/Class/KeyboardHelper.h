//
//  KeyboardHelper.h
//  ShopApp
//
//  Created by shikee_app03 on 15/9/8.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardHelper : NSObject
-(instancetype)initWithVC:(UIViewController *)vc;
-(void)addTextField:(UITextField *)textField;
-(void)setMoveView:(UIView *)moveView;
@end
