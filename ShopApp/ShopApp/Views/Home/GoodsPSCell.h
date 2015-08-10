//
//  GoodsPSCell.h
//  ShopApp
//
//  Created by shikee_app03 on 15/8/10.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "PSCollectionViewCell.h"

@interface GoodsPSCell : PSCollectionViewCell
{
    
}

@property(nonatomic,strong) UIImageView *infoImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,strong) UICustomLineLabel *vipPriceLabel;
@end
