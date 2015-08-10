//
//  GoodsPSCell.m
//  ShopApp
//
//  Created by shikee_app03 on 15/8/10.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsPSCell.h"




@implementation GoodsPSCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *infoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 145, 145)];
        self.infoImageView=[[UIImageView alloc]initWithFrame:infoView.bounds];
        
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.infoImageView.getEndPointY, self.infoImageView.getWidth, 40)];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        self.titleLabel.numberOfLines=2;
        self.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        
        self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.titleLabel.getEndPointY+3, 60, 15)];
        [self.priceLabel setPointX:self.infoImageView.getWidth-self.priceLabel.getWidth-3];
        self.priceLabel.backgroundColor=[UIColor clearColor];
        self.priceLabel.textColor=COLOR__RED;
        self.priceLabel.font=[UIFont systemFontOfSize:14];
        self.priceLabel.textAlignment=NSTextAlignmentRight;
        
        self.vipPriceLabel=[[UICustomLineLabel alloc]initWithFrame:CGRectMake(3, self.priceLabel.getPointY, 60, 15)];
        self.vipPriceLabel.backgroundColor=[UIColor clearColor];
        self.vipPriceLabel.lineType=LineTypeMiddle;
        self.vipPriceLabel.textColor=COLOR_HS;
        self.vipPriceLabel.font=[UIFont systemFontOfSize:14];
        self.vipPriceLabel.lineColor=self.vipPriceLabel.textColor;
        
        [self addSubview:infoView];
        [infoView addSubview:self.infoImageView];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.vipPriceLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
