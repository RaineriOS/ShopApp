//
//  BaseViewController.h
//  HotNewsApp
//
//  Created by shikee_app03 on 14-12-2.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum
//{
//    MoveStateLeft=1,
//    MoveStateRight,
//}MoveState;

@protocol PanDelegate <NSObject>

-(void)moveWithX:(double)x andMaxMoveX:(double)moveMaxX andAnima:(BOOL)anima;

@end

typedef enum
{
    PanStateNone=1,
    PanStateRight,
}PanState;

@interface PanViewController : UINavigationController<UIGestureRecognizerDelegate>
{
//    MoveState _currMoveState;
    
    
    PanState _currPanState;
    UIView *_maskView;
    UIView *_currCtrView;
    UIViewController *_leftViewCtr;
}
@property(nonatomic,assign) id<PanDelegate> panDelegate;
/**
 
 被划开的界面恢复初始状态
 
 */
-(void)reset;
-(void)setLeftViewController:(UIViewController *)ctr withDelegate:(id)___delegate;
-(UIViewController *)getLeftViewController;
@end
