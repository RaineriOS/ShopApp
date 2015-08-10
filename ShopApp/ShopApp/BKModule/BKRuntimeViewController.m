//
//  BKRuntimeViewController.m
//  OCModule
//
//  Created by shikee_app03 on 15-5-12.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "BKRuntimeViewController.h"

@interface BKRuntimeViewController ()

@end

@implementation BKRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)testMakeText
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor redColor];
    Class clasz=objc_getClass("testMakeText");
    
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
