//
//  CustomAnima.h
//  IOS7Anima
//
//  Created by shikee_app03 on 14-12-8.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    AnimationTypePush=0,
    AnimationTypePop,
}AnimationType;

@interface BKNavigationAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign) AnimationType animationType;
@end
