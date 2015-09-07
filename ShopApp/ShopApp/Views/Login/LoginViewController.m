/**
 ==================================================
 描述:登录页面
 开发:BigKiang
 时间:2015-08-18 11:45:34
 ==================================================
 */

#import "LoginViewController.h"

@interface LoginViewController ()
{
    
}

@property(nonatomic,strong) BKNavigationBar     *titleBar;
@property(nonatomic,strong) UILabel             *unameLabel;//用户名
@property(nonatomic,strong) UITextField         *unameTextField;//用户名
@property(nonatomic,strong) UILabel             *upswLabel;//用户密码
@property(nonatomic,strong) UITextField         *upswField;//用户密码
@property(nonatomic,strong) UIButton            *loginBtn;//登录按钮
@property(nonatomic,strong) UICustomLineLabel   *registerLabel;//注册按钮
@property(nonatomic,strong) UICustomLineLabel   *findPswLabel;//找回密码


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.unameLabel];
    [self.view addSubview:self.unameTextField];
    [self.view addSubview:self.upswLabel];
    [self.view addSubview:self.upswField];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerLabel];
    [self.view addSubview:self.findPswLabel];
    
    self.view.backgroundColor=COLOR_BG;
}

#pragma mark- SystemDeleagate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark- EventMethod
-(void)loginAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    ALERT_SHOW(@"登录成功");
}

#pragma mark- InitVar
-(BKNavigationBar *)titleBar
{
    if(!_titleBar)
    {
        _titleBar=[self getNavigationBarWithTitle:@"登录"];
    }
    
    return _titleBar;
}

-(UILabel *)unameLabel
{
    if(_unameLabel==nil){
        _unameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY+40, 110, 40)];
        _unameLabel.backgroundColor=[UIColor clearColor];
        _unameLabel.textColor=COLOR_BTNHS;
        _unameLabel.text=@"用户账号：";
        _unameLabel.textAlignment=NSTextAlignmentRight;
    }
    return _unameLabel;
}

-(UITextField *)unameTextField
{
    if(_unameTextField==nil)
    {
        _unameTextField=[[UITextField alloc]initWithFrame:CGRectMake(_unameLabel.getEndPointX, _unameLabel.getPointY, 180, _unameLabel.getHeight)];
        _unameTextField.backgroundColor=[UIColor clearColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _unameTextField.getHeight-2.0f, _unameTextField.getWidth, 0.5f)];
        lineView.backgroundColor=COLOR_LINE;
        [_unameTextField addSubview:lineView];
    }
    return _unameTextField;
}

-(UILabel *)upswLabel
{
    if(_upswLabel==nil){
        _upswLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.unameLabel.getEndPointY+20,110, 40)];
        _upswLabel.backgroundColor=[UIColor clearColor];
        _upswLabel.text=@"用户密码：";
        _upswLabel.textColor=COLOR_BTNHS;
        _upswLabel.textAlignment=NSTextAlignmentRight;
    }
    return _upswLabel;
}

-(UITextField *)upswField
{
    if(_upswField==nil)
    {
        _upswField=[[UITextField alloc]initWithFrame:CGRectMake(_upswLabel.getEndPointX, _upswLabel.getPointY, 180, _upswLabel.getHeight)];
        _upswField.backgroundColor=[UIColor clearColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _upswField.getHeight-2.0f, _upswField.getWidth, 0.5f)];
        lineView.backgroundColor=COLOR_LINE;
        [_upswField addSubview:lineView];
    }
    return _upswField;
}

-(UIButton *)loginBtn
{
    if(_loginBtn==nil){
        _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame=CGRectMake(30, self.unameLabel.getEndPointY+100,self.view.getWidth-30*2, 40);
        _loginBtn.backgroundColor=COLOR_MAIN;
        [_loginBtn setTitle:@"立即登录" forState:0];
        _loginBtn.layer.cornerRadius=8;
        _loginBtn.clipsToBounds=YES;
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UICustomLineLabel *)registerLabel
{
    if(_registerLabel==nil){
        _registerLabel=[[UICustomLineLabel alloc]initWithFrame:CGRectMake(30, BKDeviceHeight-25, 130, 20)];
        _registerLabel.backgroundColor=[UIColor clearColor];
        _registerLabel.textColor=COLOR_MAIN;
        _registerLabel.font=[UIFont systemFontOfSize:14];
        _registerLabel.text=@"新用户注册";
        [_registerLabel setLineType:LineTypeDown];
        

    }
    return _registerLabel;
}

-(UICustomLineLabel *)findPswLabel
{
    if(_findPswLabel==nil){
        _findPswLabel=[[UICustomLineLabel alloc]initWithFrame:CGRectMake(BKDeviceWidth-30-130, BKDeviceHeight-25, 130, 20)];
        _findPswLabel.backgroundColor=[UIColor clearColor];
        _findPswLabel.textAlignment=NSTextAlignmentRight;
        _findPswLabel.textColor=COLOR_MAIN;
        _findPswLabel.font=[UIFont systemFontOfSize:14];
        _findPswLabel.text=@"忘记密码";
        [_findPswLabel setLineType:LineTypeDown];
        
        
    }
    return _findPswLabel;
}

@end
