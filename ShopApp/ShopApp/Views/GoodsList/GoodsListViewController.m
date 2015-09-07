//
//  GoodsListViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/31.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsListViewController.h"

@interface GoodsListViewController ()


@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UIView *tableView;

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor=COLOR_BG;
}

#pragma mark- Delegate
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

-(UIView *)tableView
{
    if(!_tableView){
        _tableView=[UIView new];
        _tableView.backgroundColor=[UIColor redColor];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.with.mas_equalTo(self.view);
            make.size.with.mas_equalTo(self.view);
        }];
    }
    return _tableView;
}

@end
