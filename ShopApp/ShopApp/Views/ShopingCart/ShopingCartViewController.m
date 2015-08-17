//
//  ShopingCartViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/17.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "ShopingCartViewController.h"

@interface ShopingCartViewController ()

@property(nonatomic,strong) BKNavigationBar *titleBar;

@end



@implementation ShopingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    self.view.backgroundColor=COLOR_BG;
}

#pragma mark- SystemDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- InitVar

-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"购物车"];
        _titleBar.rightBtn.hidden=YES;
    }
    return _titleBar;
}



@end
