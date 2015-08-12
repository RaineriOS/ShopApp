//
//  GoodsDetilViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/11.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsDetilViewController.h"

@interface GoodsDetilViewController ()


@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UIScrollView *imagesScrollView;
@property(nonatomic,strong) UIView *goodsNameView;

@property(nonatomic,strong) NSMutableArray *imagesData;
@end

@implementation GoodsDetilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.imagesScrollView];
    UILabel *goodsNameLabel=(UILabel*)[self.goodsNameView viewWithTag:1001];
    goodsNameLabel.text=@"三黄鸡 南宁正宗三黄鸡 现在购买全额返现 全区最低价，错过了就没了";
    [self.view addSubview:self.goodsNameView];
    [self.view setBackgroundColor:COLOR_BG];
    [self setImages:self.imagesData];
}


#pragma mark privateMethod

/**
 
 设置ImagesScrollView 的图片集
 @param images 图片URL集合
 
 */
-(void)setImages:(NSArray*)images
{
    [self.imagesScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int i=0;
    for (NSString *imageUrl in images) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.imagesScrollView.getWidth*i, 0, self.imagesScrollView.getWidth, self.imagesScrollView.getHeight)];
        [self.imagesScrollView addSubview:imageView];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:LoadingIMG options:SDIMGOption];
        i++;
    }
    [self.imagesScrollView setContentSize:CGSizeMake(self.imagesScrollView.getWidth*i, 0)];
}



#pragma mark systemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark InitVar
-(BKNavigationBar *)titleBar
{
    if(_titleBar==nil){
        _titleBar=[self getNavigationBarWithTitle:@"详情"];
    }
    return _titleBar;
}

-(UIScrollView *)imagesScrollView
{
    if(_imagesScrollView==nil){
        _imagesScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY, self.view.getWidth, 170)];
        _imagesScrollView.backgroundColor=[UIColor clearColor];
        _imagesScrollView.pagingEnabled=YES;
    }
    return _imagesScrollView;
}

-(UIView *)goodsNameView
{
    if(!_goodsNameView){
        _goodsNameView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.getWidth,40)];
        [_goodsNameView setPointY:(self.titleBar.getEndPointY+self.imagesScrollView.getHeight-_goodsNameView.getHeight)];
        UIView *bgView=[[UIView alloc]initWithFrame:_goodsNameView.bounds];
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.6;
        [_goodsNameView addSubview:bgView];
        UILabel *goodsNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, _goodsNameView.getWidth-20, _goodsNameView.getHeight)];
        goodsNameLabel.backgroundColor=[UIColor clearColor];
        goodsNameLabel.font=[UIFont systemFontOfSize:16];
        goodsNameLabel.textColor=[UIColor whiteColor];
        goodsNameLabel.tag=1001;
        goodsNameLabel.numberOfLines=2;
        [_goodsNameView addSubview:goodsNameLabel];
        
    }
    return _goodsNameView;
}


-(NSMutableArray *)imagesData
{
    if(!_imagesData){
        _imagesData=[[NSMutableArray alloc]init];
        [_imagesData addObject:@"https://www.baidu.com/img/bdlogo.png"];
        [_imagesData addObject:@"http://s0.hao123img.com/res/img/logo/logonew1.png"];
        [_imagesData addObject:@"http://p0.jmstatic.com/templates/jumei/images/logo_new_v1.jpg"];
        [_imagesData addObject:@"http://images2.jyimg.com/msn/index_pic/logo_1395045365.png"];
        
    }
    return _imagesData;
}

@end
