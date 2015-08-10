//
//  UIButton+BKStyle.m
//  OCModule
//
//  Created by shikee_app03 on 15-5-4.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "UIButton+BKStyle.h"

@implementation UIButton (BKStyle)


-(void)defaultStyle{
    self.backgroundColor=COLOR_BTN;
    self.layer.cornerRadius=4;
    self.clipsToBounds=YES;
    self.layer.borderColor=[COLOR_LINE CGColor];
    self.layer.borderWidth=0.5;
}


@end
