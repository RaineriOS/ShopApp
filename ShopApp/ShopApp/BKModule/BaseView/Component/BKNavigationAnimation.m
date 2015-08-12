//
//  CustomAnima.m
//  IOS7Anima
//
//  Created by shikee_app03 on 14-12-8.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import "BKNavigationAnimation.h"
#import "UIView+Helper.h"

@implementation BKNavigationAnimation

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return .4;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    
    if(_animationType==AnimationTypePush){
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
//        toViewController.view.alpha = 0;
        
        toViewController.view.transform=CGAffineTransformMakeScale(0.8, 0.8);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toViewController.view.transform=CGAffineTransformMakeScale(1, 1);
                [fromViewController.view setPointX:-fromViewController.view.getWidth];
//                toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            toViewController.view.transform=CGAffineTransformMakeScale(1, 1);
//            [fromViewController.view setPointX:-fromViewController.view.getWidth];
//            toViewController.view.alpha = 1;
//        } completion:^(BOOL finished) {
//            toViewController.view.transform = CGAffineTransformIdentity;
//            fromViewController.view.transform = CGAffineTransformIdentity;
//            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//        }];
        
    }else {
        [container insertSubview:toViewController.view atIndex:999];
//        fromViewController.view.alpha = 1;
        fromViewController.view.transform = CGAffineTransformIdentity;
        [toViewController.view setPointX:-toViewController.view.getWidth];
        
       [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//               fromViewController.view.alpha=0;
               fromViewController.view.transform=CGAffineTransformMakeScale(0.8, 0.8);
               [toViewController.view setPointX:0];
//               toViewController.view.alpha = 1;
       } completion:^(BOOL finished) {
           [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
       }];
        
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            fromViewController.view.alpha=0;
//            fromViewController.view.transform=CGAffineTransformMakeScale(0.8, 0.8);
//            [toViewController.view setPointX:0];
//            toViewController.view.alpha = 1;
//        } completion:^(BOOL finished) {
//            toViewController.view.transform = CGAffineTransformIdentity;
//            fromViewController.view.transform = CGAffineTransformIdentity;
//            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//            NSLog(@"__执行完毕");
//        }];
        
    }

}
@end
