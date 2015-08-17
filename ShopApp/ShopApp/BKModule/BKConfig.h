//
//  BGConfig.h
//  OCModule
//
//  Created by shikee_app03 on 15-4-13.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#ifndef OCModule_BKConfig_h
#define OCModule_BKConfig_h

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "BKNavigationBar.h"
#import "BKBaseViewController.h"
#import "BKNavigationCtr.h"
#import "BKHttpRequest.h"
#import "BKToolKit.h"
#import "Toast.h"
#import "XLog.h"
#import "NZLabel.h"
#import "UICustomLineLabel.h"
#import "UIImageView+WebCache.h"

// custom

#import "LoginModel.h"

#define BKDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define BKDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)
#ifdef DEBUG
#define BKLog(...) NSLog(__VA_ARGS__)
#else
#define BKLog(...)
#endif
//释放对象的宏定义
#define RELEASE(obj){}        if(obj)obj=nil;
//释放对象的宏定义
//#define RELEASE(obj){} [obj release];

//IOS7系统以上
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight (IOS7==YES ? 0 : 15)

//查看执行时间宏
//TICK
//do your work here
//TOCK
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   XLog(@"Time: %f", -[startTime timeIntervalSinceNow])


//十六进制颜色转换成UIColor
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//颜色板
#define COLOR_TEXT_YELL   [UIColor colorWithRed:88.0f/255.0f green:44.0f/255.0f blue:31.0f/255.0f alpha:1.0f]
#define COLOR__RED        UIColorFromRGB(0xE45252)  //导航栏的红色
#define COLOR_MAIN        UIColorFromRGB(0x0066B3)  //主题颜色
#define COLOR_LINE        UIColorFromRGB(0xd1d1d1)  //线条色
#define COLOR_HS          UIColorFromRGB(0x999999)  //灰色
#define COLOR_BG          UIColorFromRGB(0xfaf7f7)  //灰色
#define COLOR_BTNHS       UIColorFromRGB(0x666666)   //按钮灰
#define COLOR_BTN  COLOR__RED
#define SDIMGOption                 SDWebImageRetryFailed|SDWebImageLowPriority|SDWebImageRefreshCached
#endif
