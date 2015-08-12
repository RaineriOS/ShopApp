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

@interface HomeViewController ()<PSCollectionViewDataSource,PSCollectionViewDelegate,UIScrollViewDelegate>
{
}

@property(nonatomic,strong) BKNavigationBar   *titleBar;
@property(nonatomic,strong) PSCollectionView  *collectionView;
@property(nonatomic,strong) UIView            *bannerView;
@property(nonatomic,strong) UIPageControl     *pageControl;

@property(nonatomic,strong) NSMutableArray *collectionData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.titleBar];
    [self setBannerImages:@[@"Temp",@"Temp",@"Temp",@"Temp",@"Temp"]];
    
    self.view.backgroundColor=COLOR_BG;
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
    [cell.infoImageView setImage:[UIImage imageNamed:@"Temp"]];
    cell.titleLabel.text=@"阿济格卡机旮旯额高达和噶里";
    cell.vipPriceLabel.text=@"12.00";
    cell.priceLabel.text=@"14:00";
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 210;
}

#pragma mark UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if(scrollView.tag==10001){
//        return;
//    }
//    
//    [self.bannerView setPointY:self.titleBar.getEndPointY-scrollView.contentOffset.y];
//    [self.collectionView setPointY:self.bannerView.getEndPointY];
//    [self.collectionView setHeight:BKDeviceHeight-self.bannerView.getEndPointY];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.tag==10001){
        NSInteger currPage=scrollView.contentOffset.x/scrollView.getWidth;
        [self.pageControl setCurrentPage:currPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PrivateMethod
#pragma mark 设置Banner图集(图片名称)
-(void)setBannerImages:(NSArray *)images
{
    [self.bannerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.pageControl=nil;
    
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
    
    [self.bannerView addSubview:self.pageControl];
    [self.pageControl setNumberOfPages:images.count];
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
    }
    
    return _collectionView;
}

-(UIView *)bannerView
{
    if(!_bannerView)
    {
        _bannerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, BKDeviceWidth, 135)];
        _bannerView.backgroundColor=[UIColor clearColor];
    }
    return _bannerView;
}

-(UIPageControl *)pageControl
{
    if(!_pageControl)
    {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(20, self.bannerView.getHeight-30, 100, 20)];
    }
    return _pageControl;
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
