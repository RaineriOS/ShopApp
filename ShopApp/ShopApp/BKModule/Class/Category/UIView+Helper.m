//
//  UIView+Helper.m
//  zhs_app
//
//  Created by shikee_app03 on 14-7-17.
//  Copyright (c) 2014年 zhs. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)
-(double)getHeight
{
    return self.frame.size.height;
}

-(double)getWidth
{
    return self.frame.size.width;
}

-(double)getPointX
{
    return self.frame.origin.x;
}

-(double)getPointY
{
    return  self.frame.origin.y;
}

-(double)getEndPointX
{
    return self.getPointX+self.getWidth;
}

-(double)getEndPointY
{
    return self.getPointY+self.getHeight;
}

-(void)setPointX:(double)x
{
    self.frame=CGRectMake(x, self.getPointY, self.getWidth, self.getHeight);
}

-(void)setPointY:(double)y
{
    self.frame=CGRectMake(self.getPointX, y, self.getWidth, self.getHeight);
}

-(void)setWidth:(CGFloat)width
{
    self.frame=CGRectMake(self.getPointX, self.getPointY, width, self.getHeight);
}

-(void)setHeight:(CGFloat)height
{
    self.frame=CGRectMake(self.getPointX, self.getPointY, self.getWidth, height);
}
@end
