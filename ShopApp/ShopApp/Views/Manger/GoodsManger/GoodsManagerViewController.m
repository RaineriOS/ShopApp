//
//  GoodsManagerViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/27.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsManagerViewController.h"

@interface GoodsManagerViewController ()

@property(nonatomic,strong) BKNavigationBar *titleBar;

@end

@implementation GoodsManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark- InitVar

-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"商品管理"];
    }
    return _titleBar;
}

@end
