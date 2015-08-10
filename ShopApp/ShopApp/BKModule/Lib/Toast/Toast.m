//
//  Toast.m
//  HotNewsApp
//
//  Created by shikee_app03 on 14-12-10.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//  ============ 新版toast(ARC) =============

#import "Toast.h"
#import "BKToolKit.h"

@implementation Toast

- (id)initWithPoint:(PointType)pointType andMsg:(NSString *)msg
{
    CGPoint point;
    double fontSize=15.0f;
//    CGSize textSize=[ZHSToolKit getAutoSizeWithFontSize:fontSize andText:msg andWeight:270];
    CGSize textSize=CGSizeZero;

    switch (pointType) {
        case PointTypeTop:
        {
            point=CGPointMake((BKDeviceWidth-textSize.width-20)/2.0f, 40+64-StatusBarHeight);
        }
            break;
        case PointTypeCenter:
        {
            point=CGPointMake((BKDeviceWidth-textSize.width-20)/2.0f, (BKDeviceHeight-textSize.height)/2.0f);
        }
            break;
        case PointTypeBottom:
        {
            point=CGPointMake((BKDeviceWidth-textSize.width-20)/2.0f, BKDeviceHeight-textSize.height-40);
        }
            
        default:
            break;
    }
    
    self = [super initWithFrame:CGRectMake(point.x, point.y, textSize.width+20, textSize.height+18)];
    
    if (self) {
        
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.getWidth,self.getHeight)];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=1;
        [self addSubview:bgView];
        self.backgroundColor=[UIColor clearColor];
        UILabel *msgLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.getWidth-textSize.width)/2.0f, (self.getHeight-textSize.height)/2.0f, textSize.width, textSize.height)];
        msgLabel.backgroundColor=[UIColor clearColor];
        msgLabel.textColor=[UIColor whiteColor];
        msgLabel.numberOfLines=0;
        msgLabel.font=[UIFont systemFontOfSize:fontSize];
        msgLabel.text=msg;
        [self addSubview:msgLabel];
        self.alpha=0;
        self.clipsToBounds=YES;
        self.layer.cornerRadius=8;
        
    }
    return self;
}

-(void)show
{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1
                              delay:2
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self setPointY:self.getPointY-40];
                             self.alpha=0;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }];
}


@end
