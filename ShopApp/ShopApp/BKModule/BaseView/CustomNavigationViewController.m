//
//  CustomNavigationViewController.m
//  HotNewsApp
//
//  Created by shikee_app03 on 14-12-3.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import "CustomNavigationViewController.h"
#define TOP_VIEW  [[UIApplication sharedApplication]keyWindow].rootViewController.view
@interface CustomNavigationViewController ()
{
    UIView *_currView;
    UIView *_backgroundView;
    int maxX;
    UITapGestureRecognizer *tapGesture;
    UIPanGestureRecognizer *panGesture;
    UIWindow *_win;
    NSMutableArray *ctrsCache;
}

@end

@implementation CustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    maxX=self.view.frame.size.width;
    
    _backgroundView=[[UIView alloc]initWithFrame:self.view.frame];
    _backgroundView.backgroundColor=[UIColor blackColor];
    panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveView:)];
    panGesture.delegate=self;
    [self.view addGestureRecognizer:panGesture];
    
    ctrsCache=[[NSMutableArray alloc]init];
    
    _currView=self.view;
   _win=[[UIApplication sharedApplication].delegate window];


    [_win.rootViewController.view insertSubview:_backgroundView atIndex:0];


}


-(void)touchView:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        _currView.transform=CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:0.1 animations:^{
            [_currView setFrame:CGRectMake(0, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
            _currPanState=PanStateNone;
            _maskView.hidden=YES;
        } completion:^(BOOL finished) {
            
        }];
    } completion:^(BOOL finished) {
        
    }];
    
}





-(void)moveView:(UIPanGestureRecognizer*)sender
{
    BKLog(@"sender.state :%i",sender.state);
    CGPoint point2 = [sender translationInView:_currView];
        if(sender.state==UIGestureRecognizerStateEnded){
            double x;
            if(point2.x>maxX/2.0f){
                x=maxX;
                _currPanState=PanStateRight;
                _maskView.hidden=NO;
                
            }else {
                x=0;
                _maskView.hidden=YES;
                _currPanState=PanStateNone;
            }
            
            double zoom=(maxX*.95+x*.05)/maxX;
            double alp=(maxX*.5+x*.5)/maxX;
            
            [UIView animateWithDuration:0.2 animations:^{
                [_currView setFrame:CGRectMake(x, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
                ((UIView*)[_backgroundView.subviews firstObject]).transform=CGAffineTransformMakeScale(zoom, zoom);
                ((UIView*)[_backgroundView.subviews firstObject]).alpha=alp;
            }completion:^(BOOL finished) {
                if(_currPanState==PanStateRight){
                    [self popViewControllerAnimated:NO];
                }
            }];
            
        }else {
            
            double x;
            
            if(point2.x<0){
                x=0;
            }else if(point2.x>maxX){
                x=maxX;
            }else {
                x=point2.x;
            }
            double zoom=(maxX*.95+x*.05)/maxX;
            double alp=(maxX*.5+x*.5)/maxX;
            [_currView setFrame:CGRectMake(x, _currView.frame.origin.y, _currView.frame.size.width, _currView.frame.size.height)];
                ((UIView*)[_backgroundView.subviews firstObject]).transform=CGAffineTransformMakeScale(zoom, zoom);
            ((UIView*)[_backgroundView.subviews firstObject]).alpha=alp;
        }
    
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([self childViewControllers].count==1){
        return NO;
    }
    
    CGPoint point=[gestureRecognizer locationInView:_currView];
    if(point.x>320){
        return NO;
    }
    return YES;
}


-(IBAction)backAction:(id)sender
{
    [self popViewControllerAnimated:YES];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    panGesture.enabled=YES;
    _currView=viewController.view;
    
//    _currView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currView.frame].CGPath;
//    _currView.layer.shadowOffset = CGSizeMake(0, 3); //设置阴影的偏移量
//    _currView.layer.shadowRadius = 10.0;  //设置阴影的半径
//    _currView.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
//    _currView.layer.shadowOpacity = 0.9; //设置阴影的不透明度
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    UIImage *img=[self capture];
    imageView.image=img;
    [_backgroundView addSubview:imageView];
    if(img){
        [ctrsCache addObject:img];
    }
    
    [super pushViewController:viewController animated:animated];

}


- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    unsigned long size=self.childViewControllers.count;
    if(size<=2){
        panGesture.enabled=NO;
    }
    [ctrsCache removeLastObject];
    for (UIView *view in _backgroundView.subviews) {
        [view removeFromSuperview];
    }
    return [super popViewControllerAnimated:animated];
}

-(NSArray*)popToRootViewControllerAnimated:(BOOL)animated
{
    id obj=[ctrsCache firstObject];
    [ctrsCache removeAllObjects];
    for (UIView *view in _backgroundView.subviews) {
        [view removeFromSuperview];
    }
    [ctrsCache addObject:obj];
    return [super popToRootViewControllerAnimated:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
