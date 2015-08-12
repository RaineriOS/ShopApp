/**
 ==================================================
 描述:商品行，继承自PSCollectionViewCell
 开发:BigKiang
 时间:2015-08-12 15:59:48
 ==================================================
 */


#import "PSCollectionViewCell.h"

@interface GoodsPSCell : PSCollectionViewCell
{
    
}

@property(nonatomic,strong) UIImageView *infoImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,strong) UICustomLineLabel *vipPriceLabel;
@end
