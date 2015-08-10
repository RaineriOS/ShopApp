//
//  BKNavigationBar.h
//  OCModule
//
//  Created by shikee_app03 on 15-4-13.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKNavigationBar : UIView
{
    UIButton *_backBtn;
}

-(UIView*)initWithNavTitle:(NSString *)title;
-(UIButton *)getBackButton;

@end
