//
//  GoodsListCell.h
//  ShopApp
//
//  Created by shikee_app03 on 15/9/7.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListCell : UITableViewCell
-(void)setGoodsTitleText:(NSString *)goodsTitle;
-(void)setGoodsImageUrl:(NSString *)imageUrl;
-(void)setPriceText:(NSString *)priceText;
-(void)setSurplusNumberText:(NSString*)surplusNumberText;
@end
