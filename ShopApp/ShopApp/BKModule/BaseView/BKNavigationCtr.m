//
//  CustomNavigationCtr.m
//  IOS7Anima
//
//  Created by shikee_app03 on 14-12-8.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import "BKNavigationCtr.h"
#import "BKNavigationAnimation.h"
#import "UIView+Helper.h"

@interface BKNavigationCtr ()
{
    UIPercentDrivenInteractiveTransition *_popInteractionController;
}
@property(nonatomic,strong) UIView *bkctrMaskView;

@end

@implementation BKNavigationCtr
{
    UIScreenEdgePanGestureRecognizer *_panGesutre;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
         [self.interactivePopGestureRecognizer setEnabled:YES];
    }
    self.delegate=weakSelf;
    _panGesutre=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesutre:)];
    _panGesutre.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_panGesutre];
    
}


-(void)handlePanGesutre:(UIPanGestureRecognizer *)sender
{
    double movePoint;
    if(sender.state==UIGestureRecognizerStateBegan){
        _popInteractionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }else if(sender.state==UIGestureRecognizerStateChanged){
        movePoint=[sender translationInView:self.view].x/self.view.getWidth;
        [_popInteractionController updateInteractiveTransition:movePoint];
    }else if(sender.state==UIGestureRecognizerStateCancelled){
        [_popInteractionController cancelInteractiveTransition];
    }else if(sender.state==UIGestureRecognizerStateEnded){
        movePoint=[sender translationInView:self.view].x/self.view.getWidth;
        if(movePoint > 0.3) {
            [_popInteractionController finishInteractiveTransition];
        } else {
            [_popInteractionController cancelInteractiveTransition];
        }
        _popInteractionController=nil;
    }

}




- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    
    if(operation==UINavigationControllerOperationPush){
        [toVC.view addGestureRecognizer:_panGesutre];
        BKNavigationAnimation *animation=[BKNavigationAnimation new];
        animation.animationType=AnimationTypePush;
        return animation;
    }else if(operation==UINavigationControllerOperationPop){
        BKNavigationAnimation *animation=[BKNavigationAnimation new];
        animation.animationType=AnimationTypePop;
        return  animation;
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    NSLog(@"_popInteractionController:   %@",_popInteractionController);
    return _popInteractionController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // fix 'nested pop animation can result in corrupted navigation bar'
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark InitVar
-(UIView *)bkctrMaskView
{
  if(!_bkctrMaskView)
  {
      _bkctrMaskView=[[UIView alloc]initWithFrame:self.view.bounds];
      _bkctrMaskView.backgroundColor=[UIColor blackColor];
  }
    return _bkctrMaskView;
}

@end
