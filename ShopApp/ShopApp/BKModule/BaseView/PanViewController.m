//
//  BaseViewController.m
//  HotNewsApp
//
//  Created by shikee_app03 on 14-12-2.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import "PanViewController.h"



@interface PanViewController ()
{
    UIView *_currView;
}

@end

@implementation PanViewController
int maxX=250;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveView:)];
    panGesture.delegate=self;
    [self.view addGestureRecognizer:panGesture];

    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchView:)];
    [self.view addGestureRecognizer:tapGesture];
    
    _maskView=[[UIView alloc]initWithFrame:self.view.frame];
    _maskView.hidden=YES;
    _maskView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_maskView];
    [_maskView addGestureRecognizer:tapGesture];
    
    
//    _currView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currView.frame].CGPath;
//    _currView.layer.shadowOffset = CGSizeMake(0, 3); //设置阴影的偏移量
//    _currView.layer.shadowRadius = 10.0;  //设置阴影的半径
//    _currView.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
//    _currView.layer.shadowOpacity = 0.9; //设置阴影的不透明度
}


-(void)setLeftViewController:(UIViewController *)ctr withDelegate:(id)___delegate
{
    _currView=[[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    _leftViewCtr=ctr;
    _leftViewCtr.view.tag=999;
    self.panDelegate=___delegate;
    UIWindow *win=[[UIApplication sharedApplication].delegate window];
//    [self.navigationController.view insertSubview:_leftViewCtr.view atIndex:0];
    [win insertSubview:_leftViewCtr.view atIndex:0];
    
}

-(UIViewController *)getLeftViewController
{
    return _leftViewCtr;
}

-(void)reset
{
    [self touchView:nil];
}

-(void)touchView:(UITapGestureRecognizer *)sender
{
    if([self.panDelegate respondsToSelector:@selector(moveWithX:andMaxMoveX:andAnima:)]){
        [self.panDelegate moveWithX:0 andMaxMoveX:maxX andAnima:YES];
    }
        [UIView animateWithDuration:0.1 animations:^{
            _currView.transform=CGAffineTransformMakeScale(1, 1);
            [UIView animateWithDuration:0.1 animations:^{
                [_currView setFrame:CGRectMake(0, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
                _currPanState=PanStateNone;
                _maskView.hidden=YES;
            } completion:^(BOOL finished) {
                
            }];
        } completion:^(BOOL finished) {
            BKLog(@"~");
        }];

}





-(void)moveView:(UIPanGestureRecognizer*)sender
{
    
    CGPoint point2 = [sender translationInView:_currView];
    
    if(_currPanState==PanStateRight){
        double x=point2.x+maxX;
        double zoom=(maxX-x+x*0.8)/maxX;
        if(sender.state==UIGestureRecognizerStateEnded){
            if(point2.x>maxX/2.0f){
                x=maxX;
                zoom=0.8;
                _currPanState=PanStateRight;
                _maskView.hidden=NO;
            }else {
                x=0;
                zoom=1;
                _maskView.hidden=YES;
                _currPanState=PanStateNone;
            }
            if([self.panDelegate respondsToSelector:@selector(moveWithX:andMaxMoveX:andAnima:)]){
                [self.panDelegate moveWithX:x andMaxMoveX:maxX andAnima:YES];
            }
                [UIView animateWithDuration:0.2 animations:^{
                    _currView.transform=CGAffineTransformMakeScale(zoom, zoom);
                    [_currView setFrame:CGRectMake(x, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
                }];
        }else {
            double zoom=(maxX-x+x*0.8)/maxX;
            
            if(x<0){
                x=0;
                zoom=1;
            }else if(x>maxX){
                x=maxX;
                zoom=0.8;
            }
            
            if([self.panDelegate respondsToSelector:@selector(moveWithX:andMaxMoveX:andAnima:)]){
                [self.panDelegate moveWithX:x andMaxMoveX:maxX andAnima:NO];
            }
                 _currView.transform=CGAffineTransformMakeScale(zoom, zoom);
                [_currView setFrame:CGRectMake(x, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
            
            
        }
        
    }else{
    
   
    
        if(sender.state==UIGestureRecognizerStateEnded){
            double x;
            double zoom=(maxX-x+x*0.8)/maxX;
            if(point2.x>maxX/2.0f){
                x=maxX;
                _currPanState=PanStateRight;
                _maskView.hidden=NO;
                zoom=0.8;
            }else {
                x=0;
                zoom=1;
                _maskView.hidden=YES;
                _currPanState=PanStateNone;
            }
            
            if([self.panDelegate respondsToSelector:@selector(moveWithX:andMaxMoveX:andAnima:)]){
                [self.panDelegate moveWithX:x andMaxMoveX:maxX andAnima:YES];
            }
            [UIView animateWithDuration:0.2 animations:^{
                _currView.transform=CGAffineTransformMakeScale(zoom, zoom);
                [_currView setFrame:CGRectMake(x, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
            }completion:^(BOOL finished) {
                _currCtrView.transform=CGAffineTransformIdentity;
            }];
            
        }else {
            
            double zoom=(maxX-point2.x+point2.x*0.8)/maxX;
            double x;
            
            if(point2.x<0){
                x=0;
                
                zoom=1;
            }else if(point2.x>maxX){
                x=maxX;
                zoom=0.8;
            }else {
                x=point2.x;
            }
            
            if([self.panDelegate respondsToSelector:@selector(moveWithX:andMaxMoveX:andAnima:)]){
                [self.panDelegate moveWithX:x andMaxMoveX:maxX andAnima:NO];
            }
            _currView.transform=CGAffineTransformMakeScale(zoom, zoom);
            [_currView setFrame:CGRectMake(x, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
            
            
        }
        
        
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.childViewControllers.count!=1){
        return NO;
    }
    
//    CGPoint point=[gestureRecognizer locationInView:_currView];
//    if(point.x>30){//&&_currPanState!=PanStateRight
//        return NO;
//    }
    return YES;
}

//-(MoveState)getMoveStateWithPoint:(CGPoint)point
//{
//    if(point.x){
//        return MoveStateLeft;
//    }else {
//        return MoveStateRight;
//    }
//}

-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
