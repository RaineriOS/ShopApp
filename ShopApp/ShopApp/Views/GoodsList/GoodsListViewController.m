//
//  GoodsListViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/31.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsListCell.h"
#import "GoodsDetilViewController.h"

@interface GoodsListViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_BG;
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.tableView];
    [self ConstraintsInit];
}


#pragma mark -PrivateMethod
-(void)ConstraintsInit
{
    WS(ws);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ws.view.getWidth, ws.view.getHeight-ws.titleBar.getEndPointY));
        make.top.mas_equalTo(ws.titleBar.mas_bottom);
    }];
}

#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GOODSLISTCELLID"];
    if(!cell)
    {
        cell=[[GoodsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GOODSLISTCELLID"];
    }
    [cell setGoodsTitleText:@"是噶进口量嘎哈 工行卡里 阿斯顿顾客；拉规划局卡拉就快了； 说说"];
    [cell setPriceText:@"10.02"];
    [cell setSurplusNumberText:@"20"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetilViewController *vc=[[GoodsDetilViewController alloc]init];
    vc.goodsId=@"1";
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}



#pragma mark Delegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - InitVar

-(BKNavigationBar *)titleBar
{
    if(!_titleBar){
        _titleBar= [self getNavigationBarWithTitle:@"商品列表"];
    }
    return _titleBar;
}

-(UITableView *)tableView
{
    if(!_tableView){
        _tableView=[UITableView new];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
    }
    return _tableView;
}


@end
