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
        make.top.equalTo(backView.mas_top);
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
    
    UIButton *btnOrder = [UIButton new];
    [btnOrder setTitle:@"订购" forState:UIControlStateNormal];
    [btnOrder setTitleColor:[ColorContants BlueFontColor] forState:UIControlStateNormal];
    btnOrder.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    btnOrder.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnOrder.layer.borderColor = [ColorContants BlueFontColor].CGColor;
    btnOrder.layer.borderWidth = SizeHeight(1);
    btnOrder.layer.cornerRadius = SizeHeight(5);
    
    [btnOrder addTarget:self action:@selector(tapOrderButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btnOrder];
    
    [btnOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblIntegral.mas_bottom).offset(SizeHeight(13/2));
        make.left.equalTo(backView.mas_left).offset(SizeWidth(5));
        make.width.equalTo(@(SizeWidth(155/2)));
        make.height.equalTo(@(SizeHeight(88/2)));
    }];
    
    UIButton *btnKitting = [UIButton new];
    [btnKitting setTitle:@"兑换" forState:UIControlStateNormal];
    [btnKitting setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnKitting.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    btnKitting.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnKitting.layer.borderColor = [ColorContants BlueFontColor].CGColor;
    btnKitting.layer.borderWidth = SizeHeight(1);
    btnKitting.layer.cornerRadius = SizeHeight(5);
    btnKitting.backgroundColor = [ColorContants BlueFontColor];
    
    [btnKitting addTarget:self action:@selector(tapKittingButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btnKitting];
    
    [btnKitting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnOrder.mas_centerY);
        make.left.equalTo(btnOrder.mas_right).offset(SizeWidth(10));
        make.width.equalTo(@(SizeWidth(155/2)));
        make.height.equalTo(@(SizeHeight(88/2)));
    }];
}

-(void) tapKittingButton{
    [self.delegate didSelectKittingId:_model._id isKitting:YES];
}
-(void) tapOrderButton{
    [self.delegate didSelectKittingId:_model._id isKitting:NO];
}
@end
