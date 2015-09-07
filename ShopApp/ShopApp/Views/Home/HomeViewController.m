/**
 ==================================================
 描述:首页
 开发:BigKiang
 时间:2015-08-12 15:59:48
 ==================================================
 */

#import "HomeViewController.h"
#import "PSCollectionView.h"
#import "GoodsPSCell.h"
#import "GoodsDetilViewController.h"
#import "MenuAction.h"
#import "MJRefresh.h"

@interface HomeViewController ()<PSCollectionViewDataSource,PSCollectionViewDelegate,UIScrollViewDelegate>
{
}

@property(nonatomic,strong) BKNavigationBar     *titleBar;
@property(nonatomic,strong) PSCollectionView    *collectionView;
@property(nonatomic,strong) UIView              *bannerView;

@property(nonatomic,strong) NSMutableArray      *collectionData;
@property(nonatomic,strong) NSArray             *menuData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.titleBar];
    [self setMenuItems:@[@{@"title":@"推荐",@"imageUrl":@"business",@"actionID":@"1001"},@{@"title":@"排行",@"imageUrl":@"Favorites",@"actionID":@"1002",@"params":@{@"goodsId":@"0"}},@{@"title":@"折扣",@"imageUrl":@"perfect"},@{@"title":@"全部",@"imageUrl":@"business"}]];
    
    self.view.backgroundColor=COLOR_BG;
    
    [self request];
}


#pragma makr - Delegate

#pragma mark PSCollectionDelegate
- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    GoodsDetilViewController *vc=[[GoodsDetilViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return self.collectionData.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    GoodsPSCell *cell=(GoodsPSCell*)[collectionView dequeueReusableViewForClass:[GoodsPSCell class]];
    if(cell==nil){
        cell=[[GoodsPSCell alloc]initWithFrame:CGRectZero];
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    NSDictionary *goods=[self.collectionData objectAtIndex:index];
    [cell.infoImageView setImageWithURL:[NSURL URLWithString:[goods objectForKey:@"imageUrl"]] placeholderImage:LoadingIMG options:SDIMGOption];
    cell.titleLabel.text=[goods objectForKey:@"title"];
    cell.vipPriceLabel.text=[goods objectForKey:@"vipPrice"];
    cell.priceLabel.text=[goods objectForKey:@"price"];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 210;
}

#pragma mark UIScrollViewDelegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PrivateMethod
#pragma mark 设置Banner图集(图片名称)
-(void)setBannerImages:(NSArray *)images
{
    [self.bannerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    self.pageControl=nil;
    
    UIScrollView *subScrollView=[[UIScrollView alloc]initWithFrame:self.bannerView.bounds];
    [subScrollView setHeight:subScrollView.getHeight-10];
    subScrollView.delegate=self;
    subScrollView.tag=10001;
    subScrollView.backgroundColor=[UIColor clearColor];
    subScrollView.pagingEnabled=YES;
    [self.bannerView addSubview:subScrollView];
    int i=0;
    for (NSString *imageName in images) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(subScrollView.getWidth*i , 0, subScrollView.getWidth,subScrollView.getHeight)];
        [imageView setImage:[UIImage imageNamed:imageName]];
        [subScrollView addSubview:imageView];
        i++;
    }
    [subScrollView setContentSize:CGSizeMake(self.bannerView.getWidth*i, 0)];
    
//    [self.bannerView addSubview:self.pageControl];
//    [self.pageControl setNumberOfPages:images.count];
}

-(void)setMenuItems:(NSArray *)items//
{
    RELEASE(self.menuData);
    self.menuData=items;
    [self.bannerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger maxRowCount=4;
    double padding=10.0f;
    NSInteger rowCount=items.count>=maxRowCount?maxRowCount:items.count;
    NSInteger cellCount=items.count/maxRowCount+(items.count%maxRowCount?1:0);
    double itemWidth=self.bannerView.getWidth/rowCount;
    double itemHeight=(self.bannerView.getHeight-padding)/cellCount;
    
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
        
        [self.bannerView addSubview:itemView];
        i++;
    }
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bannerView.getHeight-0.5f-padding, self.bannerView.getWidth, 0.5f)];
    lineView.backgroundColor=COLOR_LINE;
    [self.bannerView addSubview:lineView];
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0-0.5f, self.bannerView.getWidth, 0.5f)];
    lineView2.backgroundColor=COLOR_LINE;
    [self.bannerView addSubview:lineView2];
}


-(void)request
{
    NSDictionary *param=@{@"action":@"homeAction",@"method":@"goodsList",@"name":@"三黄鸡啊啊"};//action=homeAction&method=goodsList
    NSString *strParam=[BKToolKit formatRequestParamToString:param];
    [[BKHttpRequest shared]sendPostRequest:@{@"key":strParam} url:BaseUrl success:^(NSDictionary *response) {
        BKLog(@"%@",response);
        if([[response objectForKey:@"code"] integerValue]<0){
            ALERT_SHOW([response objectForKey:@"data"]);
        }else {
            [self.collectionData removeAllObjects];
            NSArray *array=[response objectForKey:@"data"];
            if([BKToolKit isEmptyWithArray:array]){
                array=[[NSArray alloc]init];
            }
            [self.collectionData addObjectsFromArray:array];
        }
        [self.collectionView headerEndRefreshing];
        [self.collectionView reloadData];
    }];
    
    NSDictionary *params2=@{@"action":@"homeAction",@"method":@"getMenus"};
    NSString *paramsStr2=[BKToolKit formatRequestParamToString:params2];
    
    [[BKHttpRequest shared]sendPostRequest:@{@"key":paramsStr2} url:BaseUrl success:^(NSDictionary *response) {
        if([[response objectForKey:@"code"] integerValue]<0){
            ALERT_SHOW([response objectForKey:@"data"]);
            return ;
        }
        NSArray *menus=[response objectForKey:@"data"];
        if([BKToolKit isEmptyWithArray:menus]){
            menus=[[NSArray alloc]init];
        }
        [self setMenuItems:menus];
    }];
}

#pragma mark- EventMethod
-(void)menuAction:(UIButton *)sender
{
    NSDictionary *itemDic=[self.menuData objectAtIndex:sender.tag];
    NSString *actionID=[itemDic objectForKey:@"actionID"];//动作ID
    NSDictionary *params=[itemDic objectForKey:@"params"];//动作参数 ，可能为空
    MenuAction *action=[MenuAction new];
    [action executeAction:actionID andParams:params andNavigationController:self.navigationController];
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
        _collectionView.delegate=self;
        _collectionView.headerView=self.bannerView;
        __weak HomeViewController* weakSelf=self;
        [_collectionView addHeaderWithCallback:^{
            ALERT_SHOW(@"刷新完成");
            [[LoadingView shared]stop];
            [weakSelf request];
        }];
    }
    
    return _collectionView;
}

-(UIView *)bannerView
{
    if(!_bannerView)
    {
        _bannerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, BKDeviceWidth, 94)];
        _bannerView.backgroundColor=[UIColor clearColor];
    }
    return _bannerView;
}

//-(UIPageControl *)pageControl
//{
//    if(!_pageControl)
//    {
//        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(20, self.bannerView.getHeight-30, 100, 20)];
//    }
//    return _pageControl;
//}

-(NSMutableArray *)collectionData
{
    if(_collectionData==nil){
        _collectionData=[[NSMutableArray alloc]init];
    }
    return _collectionData;
}

@end
