/**
 ==================================================
 描述:商品详情页面
 开发:BigKiang
 时间:2015-08-13 08:36:45
 ==================================================
 */

#import "GoodsDetilViewController.h"
#import "PurchaseSuccessViewController.h"

@interface GoodsDetilViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) BKNavigationBar *titleBar;//标题
@property(nonatomic,strong) UIScrollView    *imagesScrollView;//图片滚动视图
@property(nonatomic,strong) UIView          *goodsNameView;//商品名视图
@property(nonatomic,strong) UIView          *mainView;//主要视图
@property(nonatomic,strong) UIView          *footerView;//页脚
@property(nonatomic,strong) UIButton        *tradeButton;//购买按钮
@property(nonatomic,strong) UILabel         *priceLabel;
@property(nonatomic,strong) UILabel         *originalPriceLabel;
@property(nonatomic,strong) UILabel         *browseNumberLabel;//浏览次数
@property(nonatomic,strong) UILabel         *surplusNumberLabel;//剩余份数
@property(nonatomic,strong) UIButton        *collectionBtn;//收藏按钮
@property(nonatomic,strong) UIButton        *commentBtn;//评论按钮
@property(nonatomic,strong) UIButton        *shareBtn;//分享按钮
@property(nonatomic,strong) UIView          *tableHeaderView;
@property(nonatomic,strong) UITableView     *tableView;
@property(nonatomic,strong) UILabel         *synopsisLabel;//简介

@property(nonatomic,strong) NSMutableArray  *imagesData;

@end

@implementation GoodsDetilViewController


#pragma mark- ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleBar];
    [self.tableHeaderView addSubview:self.imagesScrollView];
    UILabel *goodsNameLabel=(UILabel*)[self.goodsNameView viewWithTag:1001];
    goodsNameLabel.text=@"三黄鸡 南宁正宗三黄鸡 现在购买全额返现 全区最低价，错过了就没了";
    [self.tableHeaderView addSubview:self.goodsNameView];
    [self.mainView addSubview:self.browseNumberLabel];
    [self.mainView addSubview:self.priceLabel];
    [self.mainView addSubview:self.surplusNumberLabel];
    [self.tableHeaderView addSubview:self.mainView];
    [self.tableHeaderView addSubview:self.synopsisLabel];
    [self.tableHeaderView setHeight:self.synopsisLabel.getEndPointY+20];
    [self.tableHeaderView setWidth:self.tableView.getWidth];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.tableHeaderView;

    [self.footerView addSubview:self.collectionBtn];
    [self.footerView addSubview:self.commentBtn];
    [self.footerView addSubview:self.shareBtn];
    [self.footerView addSubview:self.tradeButton];
    [self.view addSubview:self.footerView];
    [self.view setBackgroundColor:COLOR_BG];
    [self setImages:self.imagesData];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark- privateMethod

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



#pragma mark- EvnetMethod
-(void)collectionAction:(UIButton *)sender
{
    ALERT_SHOW(@"收藏成功");
}

-(void)commentAction:(UIButton *)sender
{
    ALERT_SHOW(@"评论成功");
}

-(void)shareAction:(UIButton *)sender
{
    ALERT_SHOW(@"分享成功");
}

-(void)tradeAction:(UIButton *)sender
{
    PurchaseSuccessViewController *vc=[[PurchaseSuccessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"UITableViewCellID";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    cell.backgroundColor=[UIColor clearColor];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"  %ld",indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *cellHeaderView=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.tableView.getWidth-15, 20)];
    cellHeaderView.backgroundColor=[UIColor whiteColor];
    cellHeaderView.text=[NSString stringWithFormat:@"    留言"];
    cellHeaderView.font=[UIFont systemFontOfSize:14];
    cellHeaderView.textColor=COLOR_BTNHS;
    return cellHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
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
        _titleBar.rightBtn.hidden=NO;
    }
    return _titleBar;
}

-(UIScrollView *)imagesScrollView
{
    if(_imagesScrollView==nil){
        _imagesScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.getWidth, 170)];
        _imagesScrollView.backgroundColor=[UIColor clearColor];
        _imagesScrollView.pagingEnabled=YES;
    }
    return _imagesScrollView;
}

-(UIView *)goodsNameView
{
    if(!_goodsNameView){
        _goodsNameView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.getWidth,40)];
        [_goodsNameView setPointY:(self.imagesScrollView.getHeight-_goodsNameView.getHeight)];
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

-(UIView *)mainView
{
    if(!_mainView)
    {
        _mainView=[[UIView alloc]initWithFrame:CGRectMake(0,self.imagesScrollView.getEndPointY, self.view.getWidth, 60)];
        _mainView.backgroundColor=[UIColor whiteColor];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, _mainView.getHeight-0.5f, _mainView.getWidth, 0.5f)];
        line.backgroundColor=COLOR_LINE;
        [_mainView addSubview:line];
    }
    return _mainView;
    
}

-(UIView *)footerView
{
    if(!_footerView)
    {
        _footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.getWidth, 64)];
        _footerView.backgroundColor=[UIColor whiteColor];
        [_footerView setPointY:BKDeviceHeight-_footerView.getHeight];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _footerView.getWidth, 0.5f)];
        line.backgroundColor=COLOR_LINE;
        [_footerView addSubview:line];
    }
    return _footerView;
}

-(UILabel *)priceLabel
{
    if(_priceLabel==nil){
        _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, self.mainView.getHeight/2.0f)];
        _priceLabel.backgroundColor=[UIColor clearColor];
        _priceLabel.font=[UIFont systemFontOfSize:20];
        _priceLabel.textColor=COLOR__RED;
        _priceLabel.text=@"￥0.50";
    }
    return _priceLabel;
}

-(UILabel *)browseNumberLabel
{
   if(!_browseNumberLabel)
   {
       _browseNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.getWidth/2.0f-10, 0, self.mainView.getWidth/2.0f,self.mainView.getHeight)];
       _browseNumberLabel.backgroundColor=[UIColor clearColor];
       _browseNumberLabel.text=[NSString stringWithFormat:@"浏览次数 %ld",20L];
       _browseNumberLabel.textAlignment=NSTextAlignmentRight;
       _browseNumberLabel.textColor=COLOR_BTNHS;
       _browseNumberLabel.font=[UIFont systemFontOfSize:15];
   }
    return _browseNumberLabel;
}

-(UILabel *)surplusNumberLabel
{
    if(_surplusNumberLabel==nil)
    {
        _surplusNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.priceLabel.getPointX, self.mainView.getHeight/2.0f, self.priceLabel.getWidth,self.priceLabel.getHeight)];
        _surplusNumberLabel.backgroundColor=[UIColor clearColor];
        _surplusNumberLabel.font=[UIFont systemFontOfSize:14];
        _surplusNumberLabel.text=[NSString stringWithFormat:@"剩余数量 %ld",20L];
    }
    return _surplusNumberLabel;
}


-(UILabel *)synopsisLabel
{
    if(!_synopsisLabel){
        _synopsisLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.mainView.getEndPointY, self.view.getWidth-20,0)];
        _synopsisLabel.backgroundColor=[UIColor clearColor];
        _synopsisLabel.font=[UIFont systemFontOfSize:14];
        _synopsisLabel.numberOfLines=0;
        _synopsisLabel.text=@"Do you mean that you can programmatically change the text of the label, but you can't access the fontName and pointSize? I edited the above answer to include self.label, instead of just label, since I didn't mention creating an instance variable for label.";
        [_synopsisLabel setHeight:[BKToolKit getLabelAutoWeightByLabel:_synopsisLabel].size.height];
    }
    
    return _synopsisLabel;
    
}

-(UIView *)tableHeaderView
{
    if(!_tableHeaderView)
    {
        _tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableHeaderView.backgroundColor=COLOR_BG;
    }
    return _tableHeaderView;
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY, BKDeviceWidth,BKDeviceHeight-self.titleBar.getEndPointY-self.footerView.getHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIButton *)collectionBtn
{
    if(!_collectionBtn)
    {
        _collectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _collectionBtn.backgroundColor=[UIColor clearColor];
        double weight=(self.footerView.getWidth-self.tradeButton.getPointX)/3.0f;
        _collectionBtn.frame=CGRectMake(0, 0, weight,self.footerView.getHeight);
        [_collectionBtn setImage:[UIImage imageNamed:@"appleLogoMini"] forState:0];
        [_collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

-(UIButton *)commentBtn
{
    if(!_commentBtn)
    {
        _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.backgroundColor=[UIColor clearColor];
        double weight=(self.footerView.getWidth-self.tradeButton.getPointX)/3.0f;
        _commentBtn.frame=CGRectMake(weight, 0, weight,self.footerView.getHeight);
        [_commentBtn setImage:[UIImage imageNamed:@"appleLogoMini"] forState:0];
        [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

-(UIButton *)shareBtn
{
    if(!_shareBtn)
    {
        _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.backgroundColor=[UIColor clearColor];
        double weight=(self.footerView.getWidth-self.tradeButton.getPointX)/3.0f;
        _shareBtn.frame=CGRectMake(weight*2, 0, weight,self.footerView.getHeight);
        [_shareBtn setImage:[UIImage imageNamed:@"appleLogoMini"] forState:0];
        [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

-(UIButton *)tradeButton
{
  if(!_tradeButton)
  {
      _tradeButton=[UIButton buttonWithType:UIButtonTypeCustom];
      _tradeButton.frame=CGRectMake(0, 0, 100, 35);
      [_tradeButton setPointX:self.footerView.getWidth-_tradeButton.getWidth-50];
      [_tradeButton setPointY:(self.footerView.getHeight-_tradeButton.getHeight)/2.0f];
      _tradeButton.layer.cornerRadius=8;
      _tradeButton.clipsToBounds=YES;
      _tradeButton.backgroundColor=COLOR__RED;
      [_tradeButton setTitle:@"正在加载.." forState:0];
      [_tradeButton addTarget:self action:@selector(tradeAction:) forControlEvents:UIControlEventTouchUpInside];
  }
    return _tradeButton;
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
