//
//  CommentCell.m
//  ShopApp
//
//  Created by shikee_app03 on 15/9/7.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()
{

}
@property(nonatomic,strong) UILabel *dateLabel;
@property(nonatomic,strong) UILabel *unameLabel;
@property(nonatomic,strong) UIImageView *uPhotoImageView;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIView *linewView;

@end

@implementation CommentCell


#pragma mark- Init

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self addSubview:self.uPhotoImageView];
        [self addSubview:self.unameLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.linewView];
        [self constrainInit];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}


#pragma mark- PrivateMehtod
/**
 
 添加约束
 
 */
-(void)constrainInit
{
    [self.uPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.left.mas_equalTo(4);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.unameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.uPhotoImageView.mas_right).offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(self.dateLabel);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.unameLabel.mas_top);
        make.left.mas_equalTo(self.unameLabel.mas_right);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(self.unameLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.unameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.unameLabel.mas_left);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(self.dateLabel.mas_right);
    }];
    
    [self.linewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(9.5f);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0.5f);
        make.right.mas_equalTo(0);
        
    }];
}



-(void)setUPhoneImageUrl:(NSString *)url
{
    [self.uPhotoImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:LoadingIMG options:SDIMGOption];
}

-(void)setUnameText:(NSString *)uname
{
    self.unameLabel.text=uname;
    
}
-(void)setDateText:(NSString *)dateText
{
    self.dateLabel.text=dateText;
}

-(void)setContentText:(NSString *)contentText
{
    self.contentLabel.text=contentText;
}

#pragma mark- InitVar
-(UILabel *)dateLabel
{
    bif(_dateLabel)
    {
        _dateLabel=[UILabel new];
        _dateLabel.backgroundColor=[UIColor clearColor];
        _dateLabel.textAlignment=NSTextAlignmentRight;
        _dateLabel.font=[UIFont systemFontOfSize:12];
        _dateLabel.textColor=COLOR_HS;
    }
    return _dateLabel;
}

-(UILabel *)unameLabel
{
    bif(_unameLabel)
    {
        _unameLabel=[UILabel new];
        _unameLabel.backgroundColor=[UIColor clearColor];
        _unameLabel.textAlignment=NSTextAlignmentLeft;
        _unameLabel.textColor=[UIColor blackColor];
        _unameLabel.font=[UIFont systemFontOfSize:12];
    }
    return _unameLabel;
}

-(UIImageView *)uPhotoImageView
{
    bif(_uPhotoImageView)
    {
        _uPhotoImageView=[UIImageView new];
        _uPhotoImageView.layer.cornerRadius=30/2.0f;
        _uPhotoImageView.clipsToBounds=YES;
        _uPhotoImageView.backgroundColor=COLOR__RED;
    }
    return _uPhotoImageView;
}

-(UILabel *)contentLabel
{
    bif(_contentLabel)
    {
        _contentLabel=[UILabel new];
        _contentLabel.backgroundColor=[UIColor clearColor];
        _contentLabel.numberOfLines=0;
        _contentLabel.textColor=COLOR_BTNHS;
        _contentLabel.font=[UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}


-(UIView *)linewView
{
    bif(_linewView)
    {
        _linewView=[UIView new];
        _linewView.backgroundColor=COLOR_LINE;
    }
    return _linewView;
}


#pragma mark- SysteMethod
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
