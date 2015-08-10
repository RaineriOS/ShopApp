//
//  CustomNavigationViewController.h
//  HotNewsApp
//
//  Created by shikee_app03 on 14-12-3.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanViewController.h"
#

//typedef enum
//{
//    PanStateNone=1,
//    PanStateRight,
//}PanState;

@interface CustomNavigationViewController : UINavigationController<UIGestureRecognizerDelegate>
{
    PanState _currPanState;
    UIView *_maskView;
    UIView *_currCtrView;
    UIView *_lastView;
    UIViewController *_leftViewCtr;
}

-(void)moveView:(UIPanGestureRecognizer*)sender;
@end
