//
//  BankCarInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "SendIntegralViewController.h"

@interface SendIntegralViewController ()
@property(retain,atomic) UITextField *txtPhoneNo;
@property(retain,atomic) UITextField *txtIntegral;
@end

@implementation SendIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"赠送积分"];
    [self addSubviews];
}

-(void) addSubviews{
    UILabel *lblUserName = [[UILabel alloc] init];
    lblUserName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    lblUserName.textColor = [ColorContants userNameFontColor];
    lblUserName.textAlignment = NSTextAlignmentLeft;
    lblUserName.text = @"手机号:";
    [self.view addSubview:lblUserName];
    
    [lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset([self getNavBarHeight] + SizeHeight(20));
        make.left.equalTo(self.view.mas_left).offset(SizeWidth(12));
        make.width.equalTo(@(SizeWidth(50)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    UIView *border1 = [UIView new];
    border1.backgroundColor = [ColorContants otherFontColor];
    [self.view addSubview:border1];
    
    [border1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblUserName.mas_bottom).offset(SizeHeight(34/2));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(730/2)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    CGFloat padding = 15;
    UILabel *lblCardName = [[UILabel alloc] init];
    lblCardName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    lblCardName.textColor = [ColorContants userNameFontColor];
    lblCardName.textAlignment = NSTextAlignmentLeft;
    lblCardName.text = @"积分数:";
    [self.view addSubview:lblCardName];
    
    [lblCardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(border1.mas_bottom).offset(SizeHeight(padding));
        make.left.equalTo(lblUserName.mas_left);
        make.width.equalTo(@(SizeWidth(50)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    UIView *border2 = [UIView new];
    border2.backgroundColor = [ColorContants otherFontColor];
    [self.view addSubview:border2];
    
    [border2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblCardName.mas_bottom).offset(SizeHeight(20));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(730/2)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    UIButton *btnConfirm = [[UIButton alloc] init];
    btnConfirm.backgroundColor = [ColorContants BlueButtonColor];
    btnConfirm.layer.cornerRadius = SizeHeight(3);
    [btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [btnConfirm setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnConfirm.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:16];
    
    [btnConfirm addTarget:self action:@selector(tapConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(border2.mas_bottom).offset(SizeHeight(19));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(44)));
    }];
    
    UIFont *placeHolderFont = [UIFont fontWithName:[FontConstrants pingFang] size:14];
    UIColor *placeHolderColor = [ColorContants integralWhereFontColor];
    
    _txtPhoneNo = [UITextField new];
    _txtPhoneNo.font = placeHolderFont;
    _txtPhoneNo.textColor = [ColorContants kitingFontColor];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请输入赠送方的手机号" attributes:@{ NSForegroundColorAttributeName : placeHolderColor,NSFontAttributeName:placeHolderFont}];
    _txtPhoneNo.attributedPlaceholder = str;
    
    [self.view addSubview:_txtPhoneNo];
    
    [_txtPhoneNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblUserName.mas_centerY);
        make.left.equalTo(lblUserName.mas_right).offset(SizeWidth(5));
        make.right.equalTo(border1.mas_right);
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _txtIntegral = [UITextField new];
    _txtIntegral.font = placeHolderFont;
    _txtIntegral.textColor = [ColorContants kitingFontColor];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"请输入赠送积分数量" attributes:@{ NSForegroundColorAttributeName : placeHolderColor,NSFontAttributeName:placeHolderFont}];
    _txtIntegral.attributedPlaceholder = str1;
    
    [self.view addSubview:_txtIntegral];
    
    [_txtIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblCardName.mas_centerY);
        make.left.equalTo(lblCardName.mas_right).offset(SizeWidth(5));
        make.right.equalTo(border1.mas_right);
        make.height.equalTo(@(SizeHeight(15)));
    }];
}

-(void) tapConfirmButton{
    
}
@end
