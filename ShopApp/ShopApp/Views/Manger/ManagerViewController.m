/**
 ==================================================
 描述:管理员界面
 开发:BigKiang
 时间:2015-08-26 13:52:07
 ==================================================
 */

#import "ManagerViewController.h"
#import "MenuManagerViewController.h"
#import "PasswordMangerViewController.h"

@interface ManagerViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) BKNavigationBar *titleBar;
@property(nonatomic,strong) UITableView     *tableView;


@end

@implementation ManagerViewController

#pragma mark- ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:COLOR_BG];
    [self.view addSubview:self.titleBar];
    [self.view addSubview:self.tableView];
}


#pragma mark- UITablViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ManagerPanelID"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ManagerPanelID"];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text=@"菜单管理";
        }
            break;
            
        case 1:
        {
            cell.textLabel.text=@"商品管理";
        }
            break;
            
        case 2:
        {
            cell.textLabel.text=@"用户管理";
        }
            break;
            
        case 3:
        {
            cell.textLabel.text=@"密码管理";
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            MenuManagerViewController *vc=[[MenuManagerViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            NSDictionary *params=@{
                                   @"action":@"managerAction",
                                   @"method":@"addGoods",
                                   @"name":@"南宁正宗三黄鸡",
                                   @"price":@"12.30",
                                   @"vipPrice":@"10.30",
                                   @"synopsis":@"全身羽毛黄色密布，公鸡颈羽呈金黄色，主翼羽红夹杂黑色，尾羽为黑色，母鸡主翼羽半黄半黑，尾羽为黑色，颈羽夹杂斑点状黑灰色羽毛。喙为黄色，单冠，公鸡冠较高，冠齿5～7个。",
                                   @"browseNumber":@"10",
                                   @"synopsis":@"20",
                                   @"imageUrls":@"http://images.meishij.net/p/20110926/a87921f1de1dcfa427659ff5c0e64efe_180x180.jpg,http://images.meishij.net/p/20100729/5a7efef14add14eec8440b4be32f3562_150x150.jpg"
                                   };
            NSString *paramsStr=[BKToolKit formatRequestParamToString:params];
            [[BKHttpRequest shared]sendPostRequest:@{@"key":paramsStr} url:BaseUrl success:^(NSDictionary *response) {
                if([[response objectForKey:@"code"] integerValue]<0){
                    ALERT_SHOW([response objectForKey:@"data"]);
                }else{
                  ALERT_SHOW(@"添加成功");
                }
                
            }];
//            ALERT_SHOW(@"商品管理");
        }
            break;
        case 2:
        {
            
            ALERT_SHOW(@"用户管理");
        }
            break;
        case 3:
        {
            
//            ALERT_SHOW(@"密码管理");
            
        }
            break;
        default:
            break;
    }
}



// SystemDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - InitVar
-(BKNavigationBar *)titleBar
{
    if(!_titleBar)
    {
        _titleBar=[self getNavigationBarWithTitle:@"管理员"];
    }
    return _titleBar;
}

-(UITableView *)tableView
{
    if(_tableView==nil){
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.titleBar.getEndPointY, self.view.getWidth, self.view.getHeight-self.titleBar.getEndPointY) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}



@end
