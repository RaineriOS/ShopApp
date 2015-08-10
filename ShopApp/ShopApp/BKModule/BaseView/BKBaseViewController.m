//
//  BKBaseViewController.m
//  OCModule
//
//  Created by shikee_app03 on 15-4-14.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "BKBaseViewController.h"

@implementation BKBaseViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
#endif
    self.view.translatesAutoresizingMaskIntoConstraints = NO;//关闭自动布局
    [self registerFrameworkNotification];

}

-(void)registerFrameworkNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickBackBtnAction) name:BKNavigationBarBackButtonDidSelectedNotification object:nil];//导航条返回按钮被点击时会发送该通知s
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
    return navBar;
}

-(IBAction)clickBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)backView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
