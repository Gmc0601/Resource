//
//  KitingCell.m
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingGoodCell.h"
#import "Constants.h"
#import "UIColor+BGHexColor.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"

@interface KitingGoodCell()
@property(retain,atomic) UILabel *lblGoodsName;
@property(retain,atomic) UILabel *lblIntegral;
@property(retain,atomic) UIImageView *img;
@end

@implementation KitingGoodCell
@synthesize model = _model;
-(void) setModel:(KitingGoodsModel *)model{
    _model = model;
    _lblGoodsName.text = _model.name;
    _lblIntegral.text = [NSString stringWithFormat:@"%@积分",_model.needIntergal] ;
    [_img sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void) addSubviews{
    UIImageView *bImg = [[UIImageView alloc] initWithFrame:self.bounds];
    bImg.image = [UIImage imageNamed:@"bg_jfdh_sp.png"];
    [self addSubview:bImg];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 3.5)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];

    
    _img = [UIImageView new];
    [backView addSubview:_img];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(SizeHeight(10));
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(@(SizeHeight(111)));
    }];
    
    _lblGoodsName = [[UILabel alloc] init];
    _lblGoodsName.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    _lblGoodsName.textColor = [ColorContants userNameFontColor];
    [backView addSubview:_lblGoodsName];
    
    [_lblGoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_bottom).offset(SizeHeight(11));
        make.left.equalTo(backView.mas_left).offset(SizeWidth(10));
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _lblIntegral = [[UILabel alloc] init];
    _lblIntegral.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    _lblIntegral.textColor = [ColorContants BlueFontColor];
    [backView addSubview:_lblIntegral];
    
    [_lblIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblGoodsName.mas_bottom).offset(SizeHeight(11));
        make.left.equalTo(_lblGoodsName.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.equalTo(@(SizeHeight(13)));
    }];
}
@end
