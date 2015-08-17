/**
 ==================================================
 描述:下单成功页面
 开发:BigKiang
 时间:2015-08-17 11:28:32
 ==================================================
 */

#import "PurchaseSuccessViewController.h"

@interface PurchaseSuccessViewController ()
@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UILabel  *contentLabel;
@property(nonatomic,strong) UIButton *continueBtn;
@property(nonatomic,strong) UIButton *payBtn;

@end

@implementation PurchaseSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.payBtn];
    [self.view addSubview:self.continueBtn];
    
    
    [self.view setBackgroundColor:COLOR_BG];
    
}


#pragma mark- EventMethod
-(void)continueAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark- SystemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- InitVar
-(BKNavigationBar *)titleBar
{
    if(!_titleBar)
    {
        _titleBar=[self getNavigationBarWithTitle:@"下单成功"];
        
    }
    return _titleBar;
}

-(UILabel *)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, self.titleBar.getEndPointY+30, self.view.getWidth-40, 0)];
        _contentLabel.backgroundColor=[UIColor clearColor];
        _contentLabel.font=[UIFont systemFontOfSize:14];
        _contentLabel.textColor=COLOR_BTNHS;
        _contentLabel.numberOfLines=0;
        [_contentLabel setText:@"您已经成功下单，接下来，你还需要支付或者选择货到付款，只需要点击【立即支付】即可进入下一步，如果您还要需要购买的小鸡，请点击【继续购买】，继续购买之后 ，您之前下单成功的小鸡将放入购物车，等待您的付款结算。"];
        _contentLabel.frame=[BKToolKit getLabelAutoWeightByLabel:_contentLabel];
    }
    return _contentLabel;
}

-(UIButton *)payBtn
{
    if(!_payBtn)
    {
        _payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame=CGRectMake(20, self.contentLabel.getEndPointY+50, 260/2.0f, 35);
        _payBtn.backgroundColor=COLOR__RED;
        _payBtn.layer.cornerRadius=8;
        _payBtn.clipsToBounds=YES;
        [_payBtn setTitle:@"立即支付" forState:0];
    }
    return _payBtn;
}

-(UIButton *)continueBtn
{
    if(!_continueBtn){
        _continueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _continueBtn.frame=CGRectMake(self.payBtn.getEndPointX+20, self.payBtn.getPointY, 260/2.0f, 35);
        _continueBtn.backgroundColor=COLOR_BTNHS;
        _continueBtn.layer.cornerRadius=8;
        _continueBtn.clipsToBounds=YES;
        [_continueBtn setTitle:@"继续购买" forState:0];
        [_continueBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueBtn;
}



@end
