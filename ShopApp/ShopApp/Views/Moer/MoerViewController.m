//
//  MoerViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/17.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "MoerViewController.h"
#import "ManagerViewController.h"

@interface MoerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) BKNavigationBar *titleBar;

@end

@implementation MoerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor=COLOR_BG;
}

-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"更多"];
    }
    return _titleBar;
}


#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MoreCellID"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreCellID"];
    }
    cell.textLabel.text=@"管理员界面";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerViewController *vc=[[ManagerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


//SystemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- InitVar
-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY, self.view.getWidth,self.view.getHeight-self.titleBar.getEndPointY) style:UITableViewStylePlain];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
