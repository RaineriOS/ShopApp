//
//  AddMenuViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/27.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "AddMenuViewController.h"

@interface AddMenuViewController ()

@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UITextField *titleField;
@property(nonatomic,strong) UILabel *iconUrlLabel;
@property(nonatomic,strong) UITextField *iconUrlField;
@property(nonatomic,strong) UILabel *actionIDLabel;
@property(nonatomic,strong) UITextField *actionIDField;
@property(nonatomic,strong) UIButton *submitBtn;

@end

@implementation AddMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleField];
    [self.view addSubview:self.iconUrlLabel];
    [self.view addSubview:self.iconUrlField];
    [self.view addSubview:self.actionIDLabel];
    [self.view addSubview:self.actionIDField];
    [self.view addSubview:self.submitBtn];
    
    [self.view setBackgroundColor:COLOR_BG];
}


#pragma mark- PrivateMehtod
-(void)submitAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self request];
}

-(void)request
{
    NSString *title=self.titleField.text;
    NSString *iconUrl=self.iconUrlField.text;//perfect
    NSString *actionID=self.actionIDField.text;
    
    
    if([BKToolKit isEmptyWithStr:title]){
        ALERT_SHOW(@"请输入正确的菜单名");
        return;
    }
    
    if([BKToolKit isEmptyWithStr:iconUrl]){
        iconUrl=@"perfect";
    }
    
    if([BKToolKit isEmptyWithStr:actionID]){
        actionID=@"";
    }
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"managerAction" forKey:@"action"];
    [params setObject:@"addMenu" forKey:@"method"];
    [params setObject:title forKey:@"title"];
    [params setObject:iconUrl forKey:@"imageUrl"];
    [params setObject:actionID forKey:@"actionID"];
    
//    NSDictionary *subParams=@{@"goodsID":@"655",@"xx":@"yy"};
//    [params setObject:subParams forKey:@"params"];
    
    
    NSString *paramsStr=[BKToolKit formatRequestParamToString:params];
    [[BKHttpRequest shared]sendPostRequest:@{@"key":paramsStr} url:BaseUrl success:^(NSDictionary *response) {
        if([[response objectForKey:@"code"] isEqualToString:@"-1"]){
            ALERT_SHOW([response objectForKey:@"data"]);
        }else {
            ALERT_SHOW(@"添加成功");
        }
    }];
}

#pragma mark- Delegateg
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- InitVar 

-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"添加菜单"];
    }
    return _titleBar;
}


-(UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,self.titleBar.getEndPointY+30, 120, 20)];
        _titleLabel.textAlignment=NSTextAlignmentRight;
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.text=@"菜单名：";
    }
    return _titleLabel;
}

-(UITextField *)titleField
{
    if(!_titleField){
        _titleField=[[UITextField alloc]initWithFrame:CGRectMake(self.titleLabel.getEndPointX+5, self.titleLabel.getPointY, 150, 20)];
    }
    return _titleField;
}


-(UILabel *)iconUrlLabel
{
    if(!_iconUrlLabel)
    {
        _iconUrlLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,self.titleLabel.getEndPointY+20, self.titleLabel.getWidth,self.titleLabel.getHeight)];
        _iconUrlLabel.backgroundColor=[UIColor clearColor];
        _iconUrlLabel.text=@"图标地址：";
        _iconUrlLabel.textAlignment=NSTextAlignmentRight;
    }
    return _iconUrlLabel;
}

-(UITextField *)iconUrlField
{
    if(!_iconUrlField)
    {
        _iconUrlField=[[UITextField alloc]initWithFrame:CGRectMake(self.titleField.getPointX,self.iconUrlLabel.getPointY, self.titleField.getWidth,self.titleField.getHeight)];
    }
    return _iconUrlField;
}

-(UILabel *)actionIDLabel
{
    if(!_actionIDLabel)
    {
        _actionIDLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,self.iconUrlLabel.getEndPointY+20, self.titleLabel.getWidth,self.titleLabel.getHeight)];
        _actionIDLabel.backgroundColor=[UIColor clearColor];
        _actionIDLabel.text=@"菜单动作ID：";
        _actionIDLabel.textAlignment=NSTextAlignmentRight;
    }
    return _actionIDLabel;
}


-(UITextField *)actionIDField
{
    if(!_actionIDField)
    {
        _actionIDField=[[UITextField alloc]initWithFrame:CGRectMake(self.titleField.getPointX,self.actionIDLabel.getPointY,self.titleField.getWidth,self.titleField.getHeight)];
    }
    return _actionIDField;
}

-(UIButton *)submitBtn
{
    if(_submitBtn==nil){
        _submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"添加" forState:0];
        _submitBtn.frame=CGRectMake(0, self.actionIDField.getEndPointY+40, 100, 35);
        [_submitBtn setPointX:(self.view.getWidth-_submitBtn.getWidth)/2.0f];
        _submitBtn.backgroundColor=COLOR__RED;
        _submitBtn.layer.cornerRadius=4;
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
