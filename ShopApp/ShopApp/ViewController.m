//
//  ViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/10.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "ViewController.h"

#import "BKConfig.h"

@interface ViewController ()

@property(nonatomic,strong) BKNavigationBar *titleBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    
    
}


#pragma mark SystemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitVar
-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"首页"];
        _titleBar.getBackButton.hidden=YES;
    }
    return _titleBar;
}



@end
