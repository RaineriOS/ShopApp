/**
 ==================================================
 描述:商品详情页面
 开发:BigKiang
 时间:2015-08-13 08:36:45
 ==================================================
 */

#import "GoodsDetilViewController.h"
#import "PurchaseSuccessViewController.h"
#import "CommentCell.h"
#import "KeyboardHelper.h"

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
//留言
@property(nonatomic,strong) UIView          *commentView;
@property(nonatomic,strong) UIButton        *keyboardBtn;
@property(nonatomic,strong) UITextField     *commentTextField;
@property(nonatomic,strong) UIButton        *commentSendBtn;

@property(nonatomic,strong) NSMutableArray  *imagesData;
@property(nonatomic,strong) NSMutableArray  *commentArray;
@property(nonatomic,strong) KeyboardHelper  *keyboardHelper;

@end

@implementation GoodsDetilViewController


#pragma mark- ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleBar];
    [self.tableHeaderView addSubview:self.imagesScrollView];
    [self.tableHeaderView addSubview:self.goodsNameView];
    [self.mainView addSubview:self.browseNumberLabel];
    [self.mainView addSubview:self.priceLabel];
    [self.mainView addSubview:self.surplusNumberLabel];
    [self.tableHeaderView addSubview:self.mainView];
    [self.tableHeaderView addSubview:self.synopsisLabel];
    [self.tableHeaderView setWidth:self.tableView.getWidth];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.tableHeaderView;

    [self.footerView addSubview:self.collectionBtn];
    [self.footerView addSubview:self.commentBtn];
    [self.footerView addSubview:self.shareBtn];
    [self.footerView addSubview:self.tradeButton];
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.commentView];
    [self.view setBackgroundColor:COLOR_BG];
    [self setImages:self.imagesData];
    self.keyboardHelper=[[KeyboardHelper alloc]initWithVC:self];
    [self.keyboardHelper addTextField:self.commentTextField];
    [self.keyboardHelper setMoveView:self.commentView];
    [self request];
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
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.imagesScrollView addSubview:imageView];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:LoadingIMG options:SDIMGOption];
        i++;
    }
    [self.imagesScrollView setContentSize:CGSizeMake(self.imagesScrollView.getWidth*i, 0)];
}

-(void)request
{
    if([BKToolKit isEmptyWithStr:self.goodsId]){
        ALERT_SHOW(@"非法请求");
        return;
    }
    NSDictionary *param=@{@"goodsId":self.goodsId,@"action":@"goodsAction",@"method":@"getGoodsDetil"};
    NSDictionary *paramFormat=@{@"key":[BKToolKit formatRequestParamToString:param]};
    [[BKHttpRequest shared]sendPostQueueRequest:paramFormat url:BaseUrl success:^(NSDictionary *response) {
        if([[response objectForKey:@"code"] integerValue]<0){
            ALERT_SHOW([response objectForKey:@"data"]);
        }else {
            NSDictionary *data=[response objectForKey:@"data"];
            //填充数据
            self.browseNumberLabel.text=[NSString stringWithFormat:@"浏览次数 %@",[[data objectForKey:@"browseNumber"] toString]];
            [self setImages:[data objectForKey:@"imageUrls"]];
            UILabel *goodsNameLabel=(UILabel*)[self.goodsNameView viewWithTag:1001];
            goodsNameLabel.text=[data objectForKey:@"name"];
            self.priceLabel.text=[NSString stringWithFormat:@"￥%@",[[data objectForKey:@"price"] toString]];
            self.synopsisLabel.text=[data objectForKey:@"synopsis"];
            [self.synopsisLabel setHeight:[BKToolKit getLabelAutoWeightByLabel:self.synopsisLabel].size.height];
            [self.tableHeaderView setHeight:self.synopsisLabel.getEndPointY+20];
            RELEASE(self.tableView.tableHeaderView);
            self.tableView.tableHeaderView=self.tableHeaderView;
            self.surplusNumberLabel.text=[NSString stringWithFormat:@"剩余数量 %@",[[data objectForKey:@"surplusNumber"] toString]];
//            self.commentArray=[data objectForKey:@"comments"];
        }
    }];
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
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"UITableViewCellID";
    CommentCell * cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell=[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
//    NSDictionary *comment=[self.commentArray objectAtIndex:indexPath.row];
    [cell setUPhoneImageUrl:@"http://avatar.csdn.net/4/1/9/1_zyaiwx.jpg"];
//    [cell setUPhoneImageUrl:[comment objectForKey:@"uPhoneImageUrl"]];
    [cell setUnameText:@"南宁网友"];
    [cell setDateText:@"刚刚"];
    [cell setContentText:[self.commentArray objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *cellHeaderView=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.tableView.getWidth-15, 20)];
    cellHeaderView.backgroundColor=COLOR_LINE;
    cellHeaderView.text=[NSString stringWithFormat:@"    留言"];
    cellHeaderView.font=[UIFont systemFontOfSize:14];
    cellHeaderView.textColor=COLOR_BTNHS;
    
    return cellHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    double contentWeight=self.view.getWidth-(34+8+10);//34是头像的endpointX，8是contentLabel和头像的间隔，10是contentLabel到右边的间隔
    double height=[BKToolKit getAutoSizeWithFontSize:12 andText:[self.commentArray objectAtIndex:indexPath.row] andWeight:contentWeight].height;
    height=height+40+10+10;//40是contentLabel到cell最上方的距离，10是contentLabel到cell最下方的距离
    return height;
}

#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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
        _surplusNumberLabel.text=[NSString stringWithFormat:@"剩余数量 %ld",0L];
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
//        _synopsisLabel.text=@"“三黄鸡”的名字由朱元璋钦赐。在国家农业部权威典籍《中国家禽志》一书中排名首位，该鸡属农户大自然放养。其肉质细嫩，味道鲜美，营养丰富，在国内外享有较高的声誉。具有体型小、外貌“三黄”（羽毛黄、爪黄、喙黄）、生存能力强、产蛋量高、肉质鲜嫩等优良特点，普遍饲养的家鸡品种，因黄羽、黄喙、黄脚得名。成年鸡体重约3-4公斤，鸡肉质嫩滑，皮脆骨软，脂肪丰满和味道鲜美。从而得到全世界的认可，三黄鸡是我国最著名的土鸡之一。";
//        [_synopsisLabel setHeight:[BKToolKit getLabelAutoWeightByLabel:_synopsisLabel].size.height];
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

-(UIView *)commentView
{
    bif(_commentView){
        _commentView=[[UIView alloc]initWithFrame:self.footerView.frame];
        _commentView.backgroundColor=[UIColor whiteColor];
        [_commentView addSubview:self.keyboardBtn];
        [_commentView addSubview:self.commentTextField];
        [_commentView addSubview:self.commentSendBtn];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,0, _commentView.getWidth, 0.5f)];
        line.backgroundColor=COLOR_LINE;
        [_commentView addSubview:line];
    }
    return _commentView;
}

-(UIButton *)keyboardBtn
{
    bif(_keyboardBtn)
    {
        _keyboardBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _keyboardBtn.frame=CGRectMake(0, 0, self.commentView.getHeight,self.commentView.getHeight);
        _keyboardBtn.backgroundColor=COLOR__RED;
    }
    return _keyboardBtn;
}

-(UITextField *)commentTextField
{
    bif(_commentTextField)
    {
        _commentTextField=[[UITextField alloc]initWithFrame:CGRectMake(self.keyboardBtn.getEndPointX,10,self.commentView.getWidth-60-self.keyboardBtn.getEndPointX,self.commentView.getHeight-20)];
        _commentTextField.backgroundColor=[UIColor whiteColor];
        _commentTextField.layer.borderColor=[COLOR_LINE CGColor];
        _commentTextField.layer.borderWidth=0.5f;
        _commentTextField.returnKeyType=UIReturnKeySend;
        _commentTextField.delegate=self;
    }
    return _commentTextField;
}

-(UIButton *)commentSendBtn
{
    bif(_commentSendBtn){
        _commentSendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _commentSendBtn.backgroundColor=[UIColor redColor];
        _commentSendBtn.frame=CGRectMake(self.commentView.getWidth-60-10, self.commentTextField.getPointY, 60, self.commentTextField.getHeight);
        [_commentSendBtn setTitle:@"发送" forState:0];
    }
    return _commentSendBtn;
}

#pragma mark data
-(NSMutableArray *)imagesData
{
    if(!_imagesData){
        _imagesData=[[NSMutableArray alloc]init];
        [_imagesData addObject:@"http://e.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=1c8d8537700e0cf3b4fa46a96b2f997a/d058ccbf6c81800a9507a12bb33533fa828b4730.jpg"];
        [_imagesData addObject:@"http://s0.hao123img.com/res/img/logo/logonew1.png"];
        [_imagesData addObject:@"http://p0.jmstatic.com/templates/jumei/images/logo_new_v1.jpg"];
        [_imagesData addObject:@"http://images2.jyimg.com/msn/index_pic/logo_1395045365.png"];
        
    }
    return _imagesData;
}

-(NSMutableArray *)commentArray
{
    bif(_commentArray)
    {
        _commentArray=[[NSMutableArray alloc]init];
        [_commentArray addObject:@"感觉不可能c++写一段code 然后大家都能用吧  那样的话c++也不会像现在这样了 看你的需求如何"];
        [_commentArray addObject:@"你就把Android当Linux, iOS当unix, 还不是你想用啥语言就用啥 ..."];
        [_commentArray addObject:@"怎么不能？\n 理论上，那些东西都是用底层语言实现的，加一个接口模块就可以。\n 实际上，Java有接口，安卓有本地语言开发的API，Perl有XS、DynaLoader构成的工具链，Python有boost的一个wrapper模块。"];
        [_commentArray addObject:@"顶一个"];
        [_commentArray addObject:@"顶一个"];
        [_commentArray addObject:@"顶一个"];
        [_commentArray addObject:@"顶一个"];
        [_commentArray addObject:@"顶一个"];
    }
    return _commentArray;
}

@end
