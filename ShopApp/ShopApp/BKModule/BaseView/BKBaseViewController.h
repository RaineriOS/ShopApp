//
//  BKBaseViewController.h
//  OCModule
//
//  Created by shikee_app03 on 15-4-14.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKBaseViewController : UIViewController
+(id)initWithXib;
-(id)getNavigationBarWithTitle:(NSString *)title;
-(IBAction)backView:(id)sender;
-(void)push:(NSString *)className;
@end
