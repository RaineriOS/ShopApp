//
//  LoadingView.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/24.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView()
{
    
}

@property(nonatomic,strong) UIView * animationView;

@end

@implementation LoadingView

static LoadingView * shared;

+(LoadingView *)shared
{
    @synchronized(self) {
        if(!shared)
        {
            shared=[LoadingView new];
            shared.backgroundColor=[UIColor whiteColor];
            [shared style];
        
        }
        return shared;
    }
}


-(void)style
{
    [shared addSubview:self.animationView];
}


-(void)startWithView:(UIView *)view
{
    if(shared.superview!=nil){
        [shared removeFromSuperview];
    }
    shared.frame=view.bounds;
    self.animationView.center=shared.center;
    [view addSubview:shared];
    
    //开启子线程到网络上获取数据
    NSThread* delayCleanThread = [[NSThread alloc]initWithTarget:self selector:@selector(delayClean) object:nil];
    [delayCleanThread setName:@"delayCleanThread"];
    [delayCleanThread start];
    
}

-(void)start
{
    [self startWithView:[[UIApplication sharedApplication]keyWindow]];
}

-(void)stop
{
    [self.animationView removeFromSuperview];
    [shared removeFromSuperview];
}

-(void)delayClean
{
    [NSThread sleepForTimeInterval:3.0f];
    [self stop];
}


#pragma mark- InitVar

-(UIView *)animationView
{
    if(!_animationView)
    {
        _animationView=[[UIView alloc]init];
        [_animationView setHeight:50];
        [_animationView setWidth:50];
        _animationView.backgroundColor=[UIColor redColor];
        
    }
    return _animationView;
}

@end
