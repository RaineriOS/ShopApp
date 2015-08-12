//
//  LeftViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/11.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
{
    
}

@property(nonatomic,strong) UIView *menuView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuView];
    
    self.view.backgroundColor=COLOR_BG;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- pan view delegate
-(void)moveWithX:(double)x andMaxMoveX:(double)maxMoveX andAnima:(BOOL)anima
{
//    double zoom=(maxMoveX*.85+x*.15)/maxMoveX;
//    double alp=(maxMoveX*.1+x*.9)/maxMoveX;
//    
//    double moveX=maxMoveX-(maxMoveX*.85+x*.15);
//    moveX=0-moveX;
//    
//    if(anima){
//        [UIView animateWithDuration:0.1 animations:^{
//            _menuView.transform=CGAffineTransformMakeScale(zoom, zoom);
//            _menuView.alpha=alp;
//            [UIView animateWithDuration:0.1 animations:^{
//                [_menuView setPointX:moveX];
//            }];
//        }completion:^(BOOL finished) {
//            _menuView.hidden=NO;
//        }];
//    }else {
//        _menuView.transform=CGAffineTransformMakeScale(zoom, zoom);
//        _menuView.alpha=alp;
//        [_menuView setPointX:moveX];
//        _menuView.hidden=NO;
//    }
//    
    
}

#pragma mark - InitVar 
-(UIView *)menuView
{
    if(!_menuView){
        _menuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, BKDeviceWidth*.9f, self.view.getHeight)];
        _menuView.backgroundColor=COLOR__RED;
    }
    return _menuView;
}

@end
