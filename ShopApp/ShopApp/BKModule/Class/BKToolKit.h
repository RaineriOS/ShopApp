//
//  BKToolKit.h
//  OCModule
//
//  Created by shikee_app03 on 15-5-4.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#define ALERT_SHOW_TOP(msg)     [[[Toast alloc]initWithPoint:PointTypeTop andMsg:msg] show]
#define ALERT_SHOW(msg)         [[[Toast alloc]initWithPoint:PointTypeBottom andMsg:msg] show]
#define ALERT_SHOW_CENTER(msg)  [[[Toast alloc]initWithPoint:PointTypeCenter andMsg:msg] show]

#else
#define ALERT_SHOW_TOP(msg)     [[[[Toast alloc]initWithPoint:PointTypeTop andMsg:msg] autorelease] show]
#define ALERT_SHOW(msg)         [[[[Toast alloc]initWithPoint:PointTypeBottom andMsg:msg] autorelease] show]
#define ALERT_SHOW_CENTER(msg)  [[[[Toast alloc]initWithPoint:PointTypeCenter andMsg:msg] autorelease] show]
#endif


@interface BKToolKit : NSObject

#pragma mark ----检测字符串是否为空----
/**
 @description 检测字符串是否为空
 
 @param str 需要检测的字符串
 
 @return 返回检测结果,BOOL类型
 */
+ (BOOL)isEmptyWithStr:(NSString *)str;


#pragma mark ----检测数组是否为空----
/**
 @description 检测数组是否为空
 
 @param str 需要检测的字符串
 
 @return 返回检测结果,BOOL类型
 */
+ (BOOL)isEmptyWithArray:(NSArray *)ar;


#pragma mark ----检测字典数组是否为空----
/**
 @description 检测字典数组是否为空
 
 @param str 需要检测的字符串
 
 @return 返回检测结果,BOOL类型
 */
+ (BOOL)isEmptyWithDict:(NSDictionary *)dict;

/**
 @description 自适应文本的高度
 @param fontSize 字体的大小
 @param text 文字
 @param weight 宽度
 @return 自适应label的size
 
 */
+(CGSize)getAutoSizeWithFontSize:(double)fontSize andText:(NSString *)text andWeight:(double)weight;
+(CGRect)getLabelAutoWeightByLabel:(UILabel*)label;

+(NSString *)getSandBoxPath;

+(BOOL)saveToSandbox:(NSData *)data fileName:(NSString *)fileName;

+(NSString*)formatterTime:(long)time;

+(long)getNowTime;

/**
 @description 通过view获取view上的controller
 
 @param view 视图
 
 */
+(UIViewController*)getViewCtrollerByView:(UIView*)view;

@end
