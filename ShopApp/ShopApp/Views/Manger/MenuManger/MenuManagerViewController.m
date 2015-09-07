//
//  MenuManagerViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/27.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "MenuManagerViewController.h"
#import "AddMenuViewController.h"

@interface MenuManagerViewController ()

@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UIView* menusView;
@property(nonatomic,strong) UIButton *addMenuBtn;
@property(nonatomic,strong) UIView *editView;

@property(nonatomic,strong) NSMutableArray *menuData;

@end

@implementation MenuManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.menusView];
    [self.view addSubview:self.addMenuBtn];
    [self.view addSubview:self.editView];
    [self request];
    
    self.view.backgroundColor=COLOR_BG;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self request];
}

#pragma mark- PrivateMehod
-(void)request
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"managerAction" forKey:@"action"];
    [params setValue:@"getMenus" forKey:@"method"];
    NSString *paramsStr=[BKToolKit formatRequestParamToString:params];
    [[BKHttpRequest shared]sendPostQueueRequest:@{@"key":paramsStr} url:BaseUrl success:^(NSDictionary *response) {
        BKLog(@"%@",response);
        [self.menuData removeAllObjects];
        [self.menuData addObjectsFromArray:([response objectForKey:@"data"])];
        [self setMenuItems:self.menuData];
    }];
}


-(void)setMenuItems:(NSArray *)items//
{
    [self.menusView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger maxRowCount=4;
    double padding=10.0f;
    NSInteger rowCount=items.count>=maxRowCount?maxRowCount:items.count;
    NSInteger cellCount=items.count/maxRowCount+(items.count%maxRowCount?1:0);
    double itemWidth=self.menusView.getWidth/rowCount;
    double itemHeight=(self.menusView.getHeight-padding)/cellCount;
    
    int i=0;
    for (NSDictionary *item in items) {
        NSString *title=[item objectForKey:@"title"];
        NSString *imageUrl=[item objectForKey:@"imageUrl"];
        
        NSInteger pointX=i%maxRowCount;
        NSInteger pointY=i/maxRowCount;
        
        UIView *itemView=[[UIView alloc]initWithFrame:CGRectMake(pointX*itemWidth, pointY*itemHeight, itemWidth, itemHeight)];
        [itemView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *iconView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, itemView.getWidth, itemView.getHeight/3.0f*2)];
        iconView.contentMode=UIViewContentModeBottom;
        iconView.backgroundColor=[UIColor clearColor];
        [iconView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:imageUrl] options:SDIMGOption];
        [itemView addSubview:iconView];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, iconView.getEndPointY, itemView.getWidth, itemView.getHeight-iconView.getEndPointY)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [titleLabel setTextColor:COLOR_BTNHS];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [itemView addSubview:titleLabel];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=itemView.bounds;
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag=i;
        [btn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:btn];
        
        [self.menusView addSubview:itemView];
        i++;
    }
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.menusView.getHeight-0.5f-padding, self.menusView.getWidth, 0.5f)];
    lineView.backgroundColor=COLOR_LINE;
    [self.menusView addSubview:lineView];
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0-0.5f, self.menusView.getWidth, 0.5f)];
    lineView2.backgroundColor=COLOR_LINE;
    [self.menusView addSubview:lineView2];
}


#pragma mark- EnvetMehtod
-(void)addMenuAction:(UIButton *)sender
{
    AddMenuViewController *vc=[AddMenuViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)menuAction:(UIButton *)sender
{
    self.editView.hidden=NO;
    NSDictionary *itemDic=[self.menuData objectAtIndex:sender.tag];
    self.editView.tag=[[itemDic objectForKey:@"mid"] integerValue];
}

-(void)submitEditAction:(UIButton *)sender
{
    self.editView.hidden=YES;
}


-(void)deleteMenuAction:(UIButton *)sender
{
    NSString *paramsStr=[BKToolKit formatRequestParamToString:@{@"action":@"managerAction",@"method":@"deleteMenu",@"mId":[NSString stringWithFormat:@"%ld",self.editView.tag]}];
    [[BKHttpRequest shared]sendPostQueueRequest:@{@"key":paramsStr} url:BaseUrl success:^(NSDictionary *response) {
        ALERT_SHOW(@"删除成功");
        self.editView.hidden=YES;
        [self request];
    }];
}

#pragma mark - Delegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma makr- InitVar
-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"菜单管理"];
    }
    return _titleBar;
}

-(UIView *)menusView
{
    if(_menusView==nil){
        _menusView=[[UIView alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY, self.view.getWidth,120)];
        _menusView.backgroundColor=COLOR_HS;
    }
    return _menusView;
}

-(UIButton *)addMenuBtn
{
    if(_addMenuBtn==nil){
        _addMenuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addMenuBtn setTitle:@"添加菜单" forState:0];
        _addMenuBtn.layer.cornerRadius=4;
        _addMenuBtn.frame=CGRectMake(0, self.menusView.getEndPointY, 100, 35);
        _addMenuBtn.backgroundColor=COLOR__RED;
        [_addMenuBtn addTarget:self action:@selector(addMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addMenuBtn;
}

-(UIView *)editView
{
    if(!_editView){
        _editView=[[UIView alloc]initWithFrame:self.view.bounds];
        _editView.backgroundColor=[UIColor clearColor];
        
        UIView *bgView=[[UIView alloc]initWithFrame:_editView.bounds];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.7;
        [_editView addSubview:bgView];
        
        UIView *miniView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 200)];
        [miniView setPointX:(_editView.getWidth-miniView.getWidth)/2.0f];
        [miniView setPointY:(_editView.getHeight-miniView.getHeight)/2.0f];
        miniView.backgroundColor=[UIColor whiteColor];
        miniView.clipsToBounds=YES;
        miniView.layer.cornerRadius=4;
        [_editView addSubview:miniView];
        
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, miniView.getWidth, 30)];
        [nameLabel setPointX:(miniView.getWidth-nameLabel.getWidth)/2.0f];
        nameLabel.text=@"编辑菜单";
        nameLabel.textAlignment=NSTextAlignmentCenter;
        [miniView addSubview:nameLabel];
        
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, nameLabel.getEndPointY-0.5f, miniView.getWidth, 0.5f)];
        line1.backgroundColor=COLOR_LINE;
        [miniView addSubview:line1];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, line1.getEndPointY+15, 100, 20)];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textAlignment=NSTextAlignmentRight;
        titleLabel.text=@"菜单名：";
        [miniView addSubview:titleLabel];
        
        UITextField *titleTextField=[[UITextField alloc]initWithFrame:CGRectMake(titleLabel.getEndPointX, titleLabel.getPointY, miniView.getWidth-titleLabel.getWidth-10, titleLabel.getHeight)];
        UIView *titleLine=[[UIView alloc]initWithFrame:CGRectMake(0, titleTextField.getHeight-0.5f, titleTextField.getWidth, 0.5f)];
        titleLine.backgroundColor=COLOR_LINE;
        [titleTextField addSubview:titleLine];
        [miniView addSubview:titleTextField];
        
        UILabel *iconUrlLabel=[[UILabel alloc]initWithFrame:CGRectMake(titleLabel.getPointX,titleLabel.getEndPointY+5, titleLabel.getWidth, titleLabel.getHeight)];
        iconUrlLabel.backgroundColor=[UIColor clearColor];
        iconUrlLabel.textAlignment=NSTextAlignmentRight;
        iconUrlLabel.text=@"图标URL：";
        [miniView addSubview:iconUrlLabel];
        
        UITextField *iconUrlTextField=[[UITextField alloc]initWithFrame:CGRectMake(titleTextField.getPointX, iconUrlLabel.getPointY, titleTextField.getWidth, titleLabel.getHeight)];
        UIView *iconUrlLine=[[UIView alloc]initWithFrame:CGRectMake(0, titleTextField.getHeight-0.5f, titleTextField.getWidth, 0.5f)];
        iconUrlLine.backgroundColor=COLOR_LINE;
        [iconUrlTextField addSubview:iconUrlLine];
        [miniView addSubview:iconUrlTextField];
        
        UILabel *actionIDLabel=[[UILabel alloc]initWithFrame:CGRectMake(titleLabel.getPointX,iconUrlLabel.getEndPointY+5, titleLabel.getWidth, titleLabel.getHeight)];
        actionIDLabel.backgroundColor=[UIColor clearColor];
        actionIDLabel.textAlignment=NSTextAlignmentRight;
        actionIDLabel.text=@"操作ID：";
        [miniView addSubview:actionIDLabel];
        
        UITextField *actionIDTextField=[[UITextField alloc]initWithFrame:CGRectMake(titleTextField.getPointX, actionIDLabel.getPointY, titleTextField.getWidth, titleLabel.getHeight)];
        UIView *actionIDLine=[[UIView alloc]initWithFrame:CGRectMake(0, titleTextField.getHeight-0.5f, titleTextField.getWidth, 0.5f)];
        actionIDLine.backgroundColor=COLOR_LINE;
        [actionIDTextField addSubview:actionIDLine];
        [miniView addSubview:actionIDTextField];
        
        
        UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        subBtn.frame=CGRectMake(5, 0, (miniView.getWidth-5*4)/3.0f, 30);
        [subBtn setPointY:miniView.getHeight-subBtn.getHeight-5];
        [subBtn setTitle:@"提交" forState:0];
        subBtn.backgroundColor=COLOR__RED;
        subBtn.layer.cornerRadius=4;
        [miniView addSubview:subBtn];
        [subBtn addTarget:self action:@selector(submitEditAction:) forControlEvents:UIControlEventTouchUpInside];
        _editView.hidden=YES;
        
        UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame=CGRectMake( subBtn.getEndPointX+5, subBtn.getPointY, subBtn.getWidth, subBtn.getHeight);
        [deleteBtn setTitle:@"删除" forState:0];
        deleteBtn.backgroundColor=COLOR_BTNHS;
        deleteBtn.layer.cornerRadius=4;
        [miniView addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(deleteMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        _editView.hidden=YES;
        
        
        UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame=CGRectMake(deleteBtn.getEndPointX+5, subBtn.getPointY, subBtn.getWidth, subBtn.getHeight);
        [cancelBtn setTitle:@"取消" forState:0];
        cancelBtn.backgroundColor=COLOR__RED;
        cancelBtn.layer.cornerRadius=4;
        [miniView addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(submitEditAction:) forControlEvents:UIControlEventTouchUpInside];
        _editView.hidden=YES;
    }
    return _editView;
}

-(NSMutableArray *)menuData
{
    if(_menuData==nil){
        _menuData=[[NSMutableArray alloc]init];
    }
    return _menuData;
}

@end
