/**
 ==================================================
 描述:首页菜单事件处理
 开发:BigKiang
 时间:2015-08-26 13:52:07
 ==================================================
 */

#import "MenuAction.h"
#import "GoodsDetilViewController.h"
#import "MoerViewController.h"
#import "GoodsListViewController.h"

@implementation MenuAction


-(void)executeAction:(NSString *)actionID andParams:(NSDictionary *)params andNavigationController:(UINavigationController*)navCtr
{
    if([BKToolKit isEmptyWithStr:actionID]){
        GoodsListViewController *vc=[[GoodsListViewController alloc]init];
        [navCtr pushViewController:vc animated:YES];
        //@"action":@"homeAction",@"method":@"getMenus"
        NSString *paramStr=[BKToolKit formatRequestParamToString:@{
                                                                   @"action":@"goodsAction",
                                                                   @"method":@"getGoodsListWithType",
                                                                   @"type":@"GoodsListTypeRecommend"
                                                                   
                                                                   }];
        
        NSDictionary *param=@{@"key":paramStr};
        [[BKHttpRequest shared]sendPostRequest:param url:BaseUrl success:^(NSDictionary *response) {
            NSInteger code=[[response objectForKey:@"code"] integerValue];
            if(code<0){
                ALERT_SHOW([response objectForKey:@"msg"]);
            }else {
                ALERT_SHOW(@"~");
            }
        }];
        
//        ALERT_SHOW(@"操作异常");
        return;
    }
    if([actionID isEqualToString:@"1001"]){//打开更多页面
        MoerViewController *vc=[[MoerViewController alloc]init];
        [navCtr pushViewController:vc animated:YES];
    }else if([actionID isEqualToString:@"1002"]){//打开详情
        GoodsDetilViewController *vc=[[GoodsDetilViewController alloc]init];
        vc.goodsId=[BKToolKit isEmptyWithStr:[params objectForKey:@"goodsId"]]?@"":[params objectForKey:@"goodsId"];
        [navCtr pushViewController:vc animated:YES];
    }else {
        
    }
}

@end
