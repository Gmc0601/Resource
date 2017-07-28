//
//  IntegralHeaderCell.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "IntegralHeaderCell.h"
#import <Masonry/Masonry.h>
#import "Constants.h"

@interface IntegralHeaderCell()
@property (retain,atomic) UILabel *lblIntegral;
@end

@implementation IntegralHeaderCell

@synthesize integral = _integral;
-(void) setIntegral:(NSString *)integral{
    _integral = integral;
    _lblIntegral.text = integral;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_phb"]];
    }
    return self;
}

-(void) addSubviews{
    CGFloat cornerRadius = SizeHeight(14);
    
    
    UIButton *btnConvert = [UIButton new];
    [btnConvert setTitle:@"兑换" forState:UIControlStateNormal];
    [btnConvert setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnConvert.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    btnConvert.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnConvert.layer.borderColor = [ColorContants silverColor].CGColor;
    btnConvert.layer.borderWidth = SizeHeight(1);
    btnConvert.layer.cornerRadius = SizeHeight(cornerRadius);
    
    [btnConvert addTarget:self action:@selector(tapConvertButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnConvert];
    
    [btnConvert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(SizeHeight(-27));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(28)));
    }];
    
    UIButton *btnKitting = [UIButton new];
    [btnKitting setTitle:@"提现" forState:UIControlStateNormal];
    [btnKitting setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnKitting.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    btnKitting.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnKitting.layer.borderColor = [ColorContants silverColor].CGColor;
    btnKitting.layer.borderWidth = SizeHeight(1);
    btnKitting.layer.cornerRadius = SizeHeight(cornerRadius);
    
    [btnKitting addTarget:self action:@selector(tapKitingButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnKitting];
    
    [btnKitting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnConvert.mas_centerY).offset(0);
        make.right.equalTo(btnConvert.mas_left).offset(SizeWidth(-20));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(28)));
    }];
    
    UIButton *btnSend = [UIButton new];
    [btnSend setTitle:@"转增积分" forState:UIControlStateNormal];
    [btnSend setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnSend.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    btnSend.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnSend.layer.borderColor = [ColorContants silverColor].CGColor;
    btnSend.layer.borderWidth = SizeHeight(1);
    btnSend.layer.cornerRadius = SizeHeight(cornerRadius);
    
    [btnSend addTarget:self action:@selector(tapSend) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSend];
    
    [btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnConvert.mas_centerY).offset(0);
        make.left.equalTo(btnConvert.mas_right).offset(SizeWidth(20));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(28)));
    }];
    
    
    _lblIntegral = [[UILabel alloc]init];
    _lblIntegral.text = @"8877";
    _lblIntegral.textColor = [ColorContants whiteFontColor];
    _lblIntegral.font = [UIFont fontWithName:[FontConstrants pingFang] size:50];
    _lblIntegral.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lblIntegral];
    
    [_lblIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.bottom.equalTo(btnConvert.mas_top).offset(SizeHeight(-41));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(50)));
    }];
    
    UILabel * lblSummery = [[UILabel alloc]init];
    lblSummery.text = @"我的积分（单位:分）";
    lblSummery.textColor = [ColorContants integralSummeryFontColor];
    lblSummery.font = [UIFont fontWithName:[FontConstrants pingFang] size:12];
    lblSummery.textAlignment = NSTextAlignmentCenter;
    [lblSummery sizeToFit];
    [self addSubview:lblSummery];
    
    [lblSummery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.bottom.equalTo(_lblIntegral.mas_top).offset(SizeHeight(-9));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(12)));
    }];

}

-(void) tapConvertButton{
    
}

-(void) tapKitingButton{
    
}

-(void) tapSend{
    
}

@end
