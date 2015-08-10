//
//  Toast.h
//  HotNewsApp
//
//  Created by shikee_app03 on 14-12-10.
//  Copyright (c) 2014年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PointTypeBottom=0,
    PointTypeCenter,
    PointTypeTop,
}PointType;

@interface Toast : UIView
-(void)show;
- (id)initWithPoint:(PointType)pointType andMsg:(NSString *)msg;
@end
