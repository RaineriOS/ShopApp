//
//  GoodsListCell.m
//  ShopApp
//
//  Created by shikee_app03 on 15/9/7.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "GoodsListCell.h"
#define CellHeight 90


@interface GoodsListCell()
{
    
}
@property(nonatomic,strong) UIImageView *goodsImageView;//商品封面
@property(nonatomic,strong) UILabel     *goodsTitleLabel;//商品标题
@property(nonatomic,strong) UILabel     *priceLabel;//价格显示
@property(nonatomic,strong) UIButton    *tradeBtn;//交易按钮
@property(nonatomic,strong) UILabel     *surplusNumberLabel;//剩余数量

@end

@implementation GoodsListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self addSubview:self.goodsImageView];
        [self addSubview:self.goodsTitleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.surplusNumberLabel];
        [self addSubview:self.tradeBtn];
        [self constrainInit];
    }
    return self;
}


#pragma mark- PrivatMethod
-(void)constrainInit
{
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CellHeight, CellHeight));
        make.top.mas_equalTo(@10);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.goodsImageView.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-CellHeight/2.0f);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsTitleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.goodsTitleLabel.mas_left);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.surplusNumberLabel);
    }];
    
    [self.surplusNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_top);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self.priceLabel.mas_bottom);
        make.right.mas_equalTo(self.goodsTitleLabel.mas_centerX).offset(10);
    }];
    
    [self.tradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.surplusNumberLabel.mas_top);
        make.left.mas_equalTo(self.surplusNumberLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self.surplusNumberLabel.mas_bottom);
        make.right.mas_equalTo(-10);
    }];
}


#pragma mark - InitVar
-(UIImageView *)goodsImageView
{
    if(!_goodsImageView){
        _goodsImageView=[UIImageView new];
        _goodsImageView.backgroundColor=[UIColor redColor];
    }
    return _goodsImageView;
}


-(UILabel *)goodsTitleLabel
{
    if(!_goodsTitleLabel)
    {
        _goodsTitleLabel=[UILabel new];
        _goodsTitleLabel.backgroundColor=[UIColor clearColor];
        _goodsTitleLabel.numberOfLines=2;
        _goodsTitleLabel.font=[UIFont systemFontOfSize:14];
        _goodsTitleLabel.textColor=COLOR_BTNHS;
    }
    return _goodsTitleLabel;
}

-(UILabel *)priceLabel
{
    bif(_priceLabel)
    {
        _priceLabel=[UILabel new];
        _priceLabel.backgroundColor=[UIColor clearColor];
        _priceLabel.textColor=COLOR__RED;
        _priceLabel.font=[UIFont systemFontOfSize:14];
        
    }
    return _priceLabel;
}

-(UIButton *)tradeBtn
{
    bif(_tradeBtn)
    {
        _tradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _tradeBtn.layer.cornerRadius=4;
        _tradeBtn.clipsToBounds=YES;
        _tradeBtn.backgroundColor=COLOR__RED;
        [_tradeBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_tradeBtn setTitle:@"正在加载" forState:0];
        
    }
    return _tradeBtn;
}

-(UILabel *)surplusNumberLabel
{
    bif(_surplusNumberLabel)
    {
        _surplusNumberLabel=[UILabel new];
        _surplusNumberLabel.backgroundColor=[UIColor clearColor];
        _surplusNumberLabel.font=[UIFont systemFontOfSize:12];
        _surplusNumberLabel.textColor=COLOR_BTNHS;
    }
    return _surplusNumberLabel;
}

-(void)setGoodsTitleText:(NSString *)goodsTitle
{
    self.goodsTitleLabel.text=goodsTitle;
}

-(void)setGoodsImageUrl:(NSString *)imageUrl
{
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:imageUrl]  placeholderImage:LoadingIMG options:SDIMGOption];
}

-(void)setPriceText:(NSString *)priceText
{
    priceText=[NSString stringWithFormat:@"￥%@",priceText];
    self.priceLabel.text=priceText;
}

-(void)setSurplusNumberText:(NSString*)surplusNumberText
{
    surplusNumberText=[NSString stringWithFormat:@"剩余:%@",surplusNumberText];
    self.surplusNumberLabel.text=surplusNumberText;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
