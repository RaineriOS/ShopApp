//
//  UIView+Helper.h
//  zhs_app
//
//  Created by shikee_app03 on 14-7-17.
//  Copyright (c) 2014年 zhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)
-(double)getHeight;
-(double)getWidth;
-(double)getPointX;
-(double)getPointY;
/**
 
 @description 获取末尾的x轴坐标
 
 @return 返回该控件末尾的x轴坐标
 
 */
-(double)getEndPointX;

/**
 
 @description 获取末尾的y轴坐标
 
 @return 返回该控件末尾的y轴坐标
 
 */
-(double)getEndPointY;


-(void)setPointX:(double)x;

-(void)setPointY:(double)y;

-(void)setWidth:(CGFloat)width;

-(void)setHeight:(CGFloat)height;
@end
