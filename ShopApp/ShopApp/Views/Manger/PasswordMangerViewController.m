//
//  PasswordMangerViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/9/14.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "PasswordMangerViewController.h"

@interface PasswordMangerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property(nonatomic,strong) BKNavigationBar *navBar;
@property(nonatomic,strong) UITableView     *tableView;


//data
@property(nonatomic,assign) NSInteger tablePreOffsetY;//上一个
@property(nonatomic,assign) NSInteger tableCurrOffsetY;//当前

@end

@implementation PasswordMangerViewController
{
    UIScrollView *s;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:COLOR_BG];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navBar];
}


#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HAHA"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HAHA"];
    }
    if(indexPath.row%2==0){
        cell.backgroundColor=[UIColor blueColor];
    }else{
        cell.backgroundColor=[UIColor greenColor];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}

#pragma mark uiscrollViewDelegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//{
//    if(!scrollView.isDragging){
//        double offsetY=scrollView.contentOffset.y;
//        self.tablePreOffsetY = offsetY;
//        BKLog(@"end");
//    }
//    
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    double offsetY=scrollView.contentOffset.y;
//    self.tablePreOffsetY = offsetY;
//    BKLog(@"end");
//}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"~~");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double offsetY=scrollView.contentOffset.y;
    NSLog(@"offsetY:%f",offsetY);
    if (offsetY > 0-self.navBar.getHeight) {        //这个地方加上 currentPostion > 0 即可）
        double moveSize=offsetY - self.tablePreOffsetY+self.navBar.getHeight;
        [self.navBar setPointY:0-moveSize];
        if(offsetY>=0-20){
            [self.navBar setPointY:0-(self.navBar.getHeight-20)];
        }
    }
    
    else if ((offsetY  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) ) //这个地方加上后边那个即可，也不知道为什么，再减20才行
        
    {
        double moveSize=self.tablePreOffsetY - offsetY;
        [self.navBar setPointY:moveSize];
        if(offsetY<=0){
            [self.navBar setPointY:0];
        }
    }
    self.tableView.contentInset=UIEdgeInsetsMake(self.navBar.getEndPointY, 0, 0, 0);
//     BKLog(@"HAHA  %f",offsetY);
}


#pragma mark systemDelegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- InitVar


-(BKNavigationBar *)navBar
{
    if(!_navBar)
    {
        _navBar=[self getNavigationBarWithTitle:@"密码管理"];
    }
    return _navBar;
}

-(UITableView *)tableView
{
    bif(_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, BKDeviceWidth,self.view.getHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset=UIEdgeInsetsMake(self.navBar.getHeight, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.navBar.getHeight, 0, 0, 0);

    }
    return _tableView;
}


@end
