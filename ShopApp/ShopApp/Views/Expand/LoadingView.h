//
//  LoadingView.h
//  ShopApp
//
//  Created by shikee_app03 on 15/8/24.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
+(LoadingView *)shared;
-(void)startWithView:(UIView *)view;
-(void)start;//默认加载方式 ，加载在window层面上
-(void)stop;//停止
@end
