//
//  MoerViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/17.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "MoerViewController.h"

@interface MoerViewController ()

@property(nonatomic,strong) BKNavigationBar *titleBar;

@end

@implementation MoerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    
    self.view.backgroundColor=COLOR_BG;
}

-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"更多"];
    }
    return _titleBar;
}


#pragma mark- SystemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
