//
//  BKNavigationBar.m
//  OCModule
//
//  Created by shikee_app03 on 15-4-13.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "BKNavigationBar.h"

@implementation BKNavigationBar

-(UIView*)initWithNavTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0,BKDeviceWidth,64-StatusBarHeight);
        self.backgroundColor=COLOR_MAIN;
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20-StatusBarHeight, self.getWidth, 44)];
        titleLabel.text=title;
        titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=[UIColor whiteColor];
        
        [self addSubview:titleLabel];
        
        _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(8,20-StatusBarHeight, 60, 44)];
        _backBtn.backgroundColor=[UIColor clearColor];
        _backBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        _backBtn.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _backBtn.tag=10086;//要隐藏这个按钮直接搜这个tag来隐藏
        [_backBtn addTarget:self action:@selector(clickBackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *img=[UIImage imageNamed:@"Back.png"];
        [_backBtn setImage:img forState:UIControlStateNormal];
        
        [self addSubview:_backBtn];
        
        //    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, view.getHeight-0.5, kDeviceWidth, 0.5)];
        //    lineView.backgroundColor=COLOR_LINE;
        //    [view addSubview:lineView];
        return self;
    }
    return nil;
    
}

-(UIButton *)getBackButton
{
    if(!_backBtn){
        BKLog(@"返回按钮为空");
        return nil;
    }
    return _backBtn;
}

-(void)clickBackBtnAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BKNavigationBarBackButtonDidSelectedNotification object:nil];
}

@end
