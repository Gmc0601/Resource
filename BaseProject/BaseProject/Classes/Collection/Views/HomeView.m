//
//  HomeView.m
//  BaseProject
//
//  Created by LeoGeng on 24/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "HomeView.h"
#import <Masonry/Masonry.h>
#import "Constants.h"
#import "NSMutableAttributedString+Category.h"

@interface HomeView()
@property(retain,atomic) UILabel *lblIntegral;

@end

@implementation HomeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [ColorContants gray];
    }
    return self;
}

-(void) addHeader{
    UIImageView *header = [[UIImageView alloc] init];
    header.image = [UIImage imageNamed:@"sgd_bg_sy"];
    
    [self addSubview:header];
    
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.leading.equalTo(self.mas_leading);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@269);
    }];
    
    UIButton *btnMessage = [[UIButton alloc] init];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
    [btnMessage addTarget:self action:@selector(tapMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:btnMessage];
    [btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top).offset(44);
        make.leading.equalTo(header.mas_leading).offset(16);
        make.width.equalTo(@22);
        make.height.equalTo(@19);
    }];
    
    UIButton *btnSetting = [[UIButton alloc] init];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(tapMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:btnSetting];
    [btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_top).offset(44);
        make.right.equalTo(header.mas_right).offset(-16);
        make.width.equalTo(@20.4);
        make.height.equalTo(@22);
    }];
    
    
    UIButton *btnCheck = [[UIButton alloc] init];
    [btnCheck setTitle:@"点击查看" forState:UIControlStateNormal];
    [btnCheck setTitleColor:[ColorContants orange] forState:UIControlStateNormal];
    btnCheck.titleLabel.font = [UIFont fontWithName:[FontConstrants pinFang] size:11];
    btnCheck.titleLabel.layer.borderColor = [ColorContants orange].CGColor;
    btnCheck.titleLabel.layer.borderWidth = 1;
    btnCheck.titleLabel.layer.cornerRadius = 22.5;
    
    [btnCheck addTarget:self action:@selector(tapCheckButton) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:btnCheck];
    [btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(header.mas_bottom).offset(-17);
        make.centerX.equalTo(header.mas_centerX).offset(73);
        make.width.equalTo(@73);
        make.height.equalTo(@19);
    }];
    
    _lblIntegral  = [[UILabel alloc] init];
    [header addSubview:_lblIntegral];
    
    [_lblIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnCheck.mas_centerY).offset(0);
        make.left.equalTo(header.mas_left).offset(0);
        make.right.equalTo(btnCheck.mas_left).offset(37);
        make.height.equalTo(@15);
    }];
    
    UILabel *lblTag  = [[UILabel alloc] init];
    lblTag.text = @"收购点";
    [header addSubview:lblTag];
    
    [lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnCheck.mas_centerY).offset(0);
        make.left.equalTo(header.mas_left).offset(0);
        make.right.equalTo(btnCheck.mas_left).offset(37);
        make.height.equalTo(@15);
    }];
    
}

-(void) setIntergral:(NSString *) strIntegral{
    UIFont *font1 = [UIFont fontWithName:[FontConstrants helveticaNeue] size:15];
    UIFont *font2 = [UIFont fontWithName:[FontConstrants pinFang] size:12];
    _lblIntegral.attributedText = [NSMutableAttributedString attributeString:strIntegral prefixFont:font1 prefixColor:[ColorContants orange] suffixString:@"积分" suffixFont:font2 suffixColor:[ColorContants orange] ];
}

-(void) addGoodsList{
    
}

-(void) tapMessageButton{
    
}

-(void) tapSettingButton{
    
}

-(void) tapCheckButton{
    
}

@end
