/**
 ==================================================
 描述:首页左侧栏
 开发:BigKiang
 时间:2015-08-12 15:59:48
 ==================================================
 */


#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property(nonatomic,strong) UIView *menuView;
@property(nonatomic,strong) UITableView *menuItemsView;
@property(nonatomic,strong) UIView *menuHeaderView;
@property(nonatomic,strong) UIView *menuFooterView;
@property(nonatomic,strong) UILabel *userNameLabel;

@property(nonatomic,strong) NSMutableArray *menuItemsData;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuView];
    [self.menuHeaderView addSubview:self.userNameLabel];
    self.userNameLabel.text=@"BigKiang";
    [self.menuView addSubview:self.menuHeaderView];
    [self.menuView addSubview:self.menuItemsView];
    [self.menuView addSubview:self.menuFooterView];
    
    self.view.backgroundColor=[UIColor blackColor];
    
}



#pragma mark- ViewDelegate
-(void)moveWithX:(double)x andMaxMoveX:(double)maxMoveX andAnima:(BOOL)anima
{
//    double zoom=(maxMoveX*.85+x*.15)/maxMoveX;
//    double alp=(maxMoveX*.1+x*.9)/maxMoveX;
//    
//    double moveX=maxMoveX-(maxMoveX*.85+x*.15);
//    moveX=0-moveX;
//    
//    if(anima){
//        [UIView animateWithDuration:0.1 animations:^{
//            _menuView.transform=CGAffineTransformMakeScale(zoom, zoom);
//            _menuView.alpha=alp;
//            [UIView animateWithDuration:0.1 animations:^{
//                [_menuView setPointX:moveX];
//            }];
//        }completion:^(BOOL finished) {
//            _menuView.hidden=NO;
//        }];
//    }else {
//        _menuView.transform=CGAffineTransformMakeScale(zoom, zoom);
//        _menuView.alpha=alp;
//        [_menuView setPointX:moveX];
//        _menuView.hidden=NO;
//    }
//    
    
}

#pragma mark UITabelViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItemsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"MenuCellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text=self.menuItemsData[indexPath.row];
    return cell;
}

#pragma mark SystemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitVar 
-(UIView *)menuView
{
    if(!_menuView){
        _menuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, BKDeviceWidth, self.view.getHeight)];
        _menuView.backgroundColor=COLOR__RED;
        UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:_menuView.bounds];
        [bgImageView setImage:[UIImage imageNamed:@"personal_center_bg"]];
        [_menuView addSubview:bgImageView];
    }
    return _menuView;
}

-(UITableView *)menuItemsView
{
    if(!_menuItemsView){
        _menuItemsView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.menuHeaderView.getEndPointY, self.menuHeaderView.getWidth,self.menuView.getHeight-self.menuHeaderView.getHeight-self.menuFooterView.getHeight) style:UITableViewStylePlain];
        _menuItemsView.backgroundColor=[UIColor clearColor];
        _menuItemsView.delegate=self;
        _menuItemsView.dataSource=self;
        _menuItemsView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _menuItemsView;
}

-(UIView *)menuHeaderView
{
    if(!_menuHeaderView)
    {
        _menuHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.menuView.getWidth*.8f,100)];
        _menuHeaderView.backgroundColor=[UIColor clearColor];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, _menuHeaderView.getHeight-0.5f,_menuHeaderView.getWidth, 0.5f)];
        line.backgroundColor=COLOR_LINE;
        line.tag=1001;
        [_menuHeaderView addSubview:line];
    }
    
    return _menuHeaderView;
}


-(UIView *)menuFooterView
{
  if(!_menuFooterView)
  {
      _menuFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.menuView.getWidth*.8f,60)];
      _menuFooterView.backgroundColor=[UIColor clearColor];
      [_menuFooterView setPointY:self.menuView.getHeight-_menuFooterView.getHeight];
      
      UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _menuFooterView.getWidth/2.0f, _menuFooterView.getHeight)];
      btn1.backgroundColor=[UIColor clearColor];
      btn1.titleLabel.font=[UIFont systemFontOfSize:20];
      [btn1 setTitle:@"更多" forState:0];
      [_menuFooterView addSubview:btn1];
      
      UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(btn1.getEndPointX, 0, _menuFooterView.getWidth/2.0f, _menuFooterView.getHeight)];
      btn2.backgroundColor=[UIColor clearColor];
      btn2.titleLabel.font=[UIFont systemFontOfSize:20];
      [btn2 setTitle:@"反馈" forState:0];
      [_menuFooterView addSubview:btn2];
      
      
//      UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0,_menuHeaderView.getWidth, 0.5f)];
//      line.backgroundColor=COLOR_LINE;
//      line.tag=1001;
//      [_menuFooterView addSubview:line];
  }
    
    return _menuFooterView;
}

-(UILabel *)userNameLabel
{
    if(!_userNameLabel)
    {
        _userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.menuHeaderView.getWidth, 35)];
        [_userNameLabel setPointY:(self.menuHeaderView.getHeight-_userNameLabel.getHeight)/2.0f];
        _userNameLabel.backgroundColor=[UIColor clearColor];
        _userNameLabel.font=[UIFont boldSystemFontOfSize:20];
        _userNameLabel.textColor=[UIColor whiteColor];
        _userNameLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _userNameLabel;
}




-(NSMutableArray *)menuItemsData
{
    if(!_menuItemsData){
        _menuItemsData=[[NSMutableArray alloc]init];
        [_menuItemsData addObject:@"我的订单"];
        [_menuItemsData addObject:@"我的地址"];
        [_menuItemsData addObject:@"我的钱包"];
        [_menuItemsData addObject:@"购物卡车"];
        
    }
    return _menuItemsData;
}

@end
