//
//  GoodsDetilViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/11.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsDetilViewController.h"

@interface GoodsDetilViewController ()

@end

@implementation GoodsDetilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self getNavigationBarWithTitle:@"详情"]];
    [self.view setBackgroundColor:COLOR__RED];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
