//
//  BKBaseViewController.m
//  OCModule
//
//  Created by shikee_app03 on 15-4-14.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "BKBaseViewController.h"

@interface BKBaseViewController ()<UIGestureRecognizerDelegate>


@end

@implementation BKBaseViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
#endif
    
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;//关闭自动布局
    /**
     设置为NO之后，没有添加隐含constraint，而代码添加的constraint又不足以确定self.view的位置和大小，所以self.view无法显示;
     
     
     */

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

-(void)registerFrameworkNotification
{
}

+(id)initWithXib
{
    NSString *objName=[self getClassName];
    id obj=[[NSClassFromString(objName) alloc]initWithNibName:objName bundle:nil];
    return obj;
}

-(id)getNavigationBarWithTitle:(NSString *)title
{
    BKNavigationBar *navBar=[[BKNavigationBar alloc]initWithNavTitle:title];
    UIButton *backButton=navBar.getBackButton;
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [navBar.rightBtn addTarget:self action:@selector(shopingCartAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return navBar;
}

#pragma mark- InitVar

-(IBAction)clickBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shopingCartAction:(UIButton *)sender
{
    if([LoginModel shared].isLogin)
    {
        ALERT_SHOW(@"请先登录");
    }else {
        [self push:@"ShopingCartViewController"];
    }
}

-(void)push:(NSString *)className
{
    Class tempClass = NSClassFromString(className);
    if(!tempClass) return;
    UIViewController * tempObj = [[tempClass alloc] init];
    [self.navigationController pushViewController:tempObj animated:YES];
}

-(IBAction)backView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
