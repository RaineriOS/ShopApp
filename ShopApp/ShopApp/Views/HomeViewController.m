//
//  HomeViewController.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/10.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "HomeViewController.h"
#import "PSCollectionView.h"

@interface HomeViewController ()<PSCollectionViewDataSource,PSCollectionViewDelegate>
{
}

@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) PSCollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *collectionData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.collectionView];
    
    self.view.backgroundColor=COLOR_BG;
}


#pragma makr - Delegate

#pragma mark PSCollectionDelegate
- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return self.collectionData.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    PSCollectionViewCell *cell=[collectionView dequeueReusableViewForClass:[PSCollectionViewCell class]];
    if(cell==nil){
        cell=[[PSCollectionViewCell alloc]initWithFrame:CGRectZero];
        cell.backgroundColor=COLOR_MAIN;
    }
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 110;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - InitVar
-(BKNavigationBar *)titleBar
{
    if(!_titleBar){
        _titleBar=[[BKNavigationBar alloc]initWithNavTitle:@"首页"];
        _titleBar.getBackButton.hidden=YES;
        
    }
    return _titleBar;
}

-(PSCollectionView *)collectionView
{
    if(!_collectionView){
        _collectionView=[[PSCollectionView alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY, BKDeviceWidth, BKDeviceHeight-self.titleBar.getEndPointY)];
        _collectionView.numColsPortrait = 2;
        _collectionView.numColsLandscape = 4;
        _collectionView.kMargin=10.0;
        _collectionView.collectionViewDataSource=self;
        _collectionView.collectionViewDelegate=self;
    }
    
    return _collectionView;
}


-(NSMutableArray *)collectionData
{
    if(_collectionData==nil){
        _collectionData=[[NSMutableArray alloc]init];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
        [_collectionData addObject:@"1"];
    }
    return _collectionData;
}

@end
