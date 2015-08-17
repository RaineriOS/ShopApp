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
        titleLabel.tag=1001;
        
        [self addSubview:titleLabel];
        
        _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(8,20-StatusBarHeight, 60, 44)];
        _backBtn.backgroundColor=[UIColor clearColor];
        _backBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        _backBtn.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _backBtn.tag=10086;//要隐藏这个按钮直接搜这个tag来隐藏
//        [_backBtn addTarget:self action:@selector(clickBackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *img=[UIImage imageNamed:@"Back.png"];
        [_backBtn setImage:img forState:UIControlStateNormal];
        
        [self addSubview:_backBtn];
        
        [self addSubview:self.rightBtn];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.getHeight-0.5, self.getWidth, 0.5)];
        lineView.backgroundColor=COLOR_LINE;
        [self addSubview:lineView];
        return self;
    }
    return self;
    
}


/**
 
 设置标题
 
 */
-(void)setTitleWithStr:(NSString *)title
{
   UILabel *textLabel=(UILabel*)[self viewWithTag:1001];
   textLabel.text=title;
}

-(UIButton *)getBackButton
{
    if(!_backBtn){
        BKLog(@"返回按钮为空");
        return nil;
    }
    return _backBtn;
}

#pragma mark- EventMethod

-(void)clickBackBtnAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BKNavigationBarBackButtonDidSelectedNotification object:nil];
}


#pragma mark- InitVar

-(UIButton *)rightBtn
{
    if(!_rightBtn)
    {
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 20-StatusBarHeight, 60, 44)];
        [_rightBtn setPointX:self.getWidth-8-_rightBtn.getWidth];
        _rightBtn.backgroundColor=[UIColor clearColor];
        _rightBtn.tag=10087;
        _rightBtn.hidden=YES;
        [_rightBtn setImage:[UIImage imageNamed:@"ShoppingCart"] forState:0];
    }
    return _rightBtn;
}

@end
