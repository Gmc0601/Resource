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
    _img = [UIImageView new];
    _img.backgroundColor = [UIColor redColor];
    [self addSubview:_img];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SizeHeight(10));
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(SizeHeight(111)));
    }];
    
    _lblGoodsName = [[UILabel alloc] init];
    _lblGoodsName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    _lblGoodsName.textColor = [ColorContants userNameFontColor];
    [self addSubview:_lblGoodsName];
    
    [_lblGoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_bottom).offset(SizeHeight(11));
        make.left.equalTo(self.mas_left).offset(SizeWidth(10));
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _lblIntegral = [[UILabel alloc] init];
    _lblIntegral.font = [UIFont fontWithName:[FontConstrants pingFang] size:13];
    _lblIntegral.textColor = [ColorContants BlueFontColor];
    [self addSubview:_lblIntegral];
    
    [_lblIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblGoodsName.mas_bottom).offset(SizeHeight(11));
        make.left.equalTo(_lblGoodsName.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(SizeHeight(13)));
    }];
}
@end
