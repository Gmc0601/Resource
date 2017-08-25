//
//  KitingCell.m
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingCell.h"
#import "Constants.h"
#import "UIColor+BGHexColor.h"
#import <Masonry/Masonry.h>

@interface KitingCell()
@property(retain,atomic) UILabel *lblIntegral;
@property(retain,atomic) UILabel *lblMoney;
@end

@implementation KitingCell
@synthesize model = _model;
-(void) setModel:(KitingModel *)model{
    _model = model;
    _lblMoney.text = [NSString stringWithFormat:@"兑换 ￥%d",_model.money];
    _lblIntegral.text = [NSString stringWithFormat:@"积分 %d",_model.integral];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self changeState];
    }
    return self;
}

-(void) addSubviews{
    self.clipsToBounds = YES;
        self.layer.cornerRadius = SizeHeight(5);
    self.layer.borderWidth = 1;

    _lblIntegral = [[UILabel alloc] init];
    _lblIntegral.font = [UIFont fontWithName:[FontConstrants pingFang] size:13];
    _lblIntegral.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lblIntegral];
    
    [_lblIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(SizeHeight(36)));
    }];
    
    _lblMoney = [[UILabel alloc] init];
    _lblMoney.font = [UIFont fontWithName:[FontConstrants pingFang] size:14];
    _lblMoney.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lblMoney];
    
    [_lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@(SizeHeight(36)));
    }];
}
-(void) changeState{
    UIColor *borderColor;
    UIColor *integralFontColor;
    UIColor *moneyColor;
    
    if (self.selected) {
        UIColor *color = [UIColor colorWithHexString:@"#f78478"];
        borderColor = color;
        integralFontColor = color;
        moneyColor = [ColorContants whiteFontColor];
    }else{
        borderColor = [ColorContants gray];
        integralFontColor = [ColorContants kitingFontColor];
        moneyColor = [ColorContants phoneNumerFontColor];
    }
    
    self.layer.borderColor = borderColor.CGColor;
    _lblMoney.backgroundColor = borderColor;
    _lblIntegral.textColor = integralFontColor;
    _lblMoney.textColor = moneyColor;
}

-(void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self changeState];
}
@end
