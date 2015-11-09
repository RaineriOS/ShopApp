//
//  CommentCell.h
//  ShopApp
//
//  Created by shikee_app03 on 15/9/7.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
-(void)setUPhoneImageUrl:(NSString *)url;
-(void)setUnameText:(NSString *)uname;
-(void)setDateText:(NSString *)dateText;
-(void)setContentText:(NSString *)contentText;
@end
