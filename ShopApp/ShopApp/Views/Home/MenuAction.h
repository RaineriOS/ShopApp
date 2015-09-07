/**
 ==================================================
 描述:首页菜单事件处理
 开发:BigKiang
 时间:2015-08-26 13:52:07
 ==================================================
 */

#import <Foundation/Foundation.h>

@interface MenuAction : NSObject

-(void)executeAction:(NSString *)actionID andParams:(NSDictionary *)params andNavigationController:(UINavigationController*)navCtr;

@end
