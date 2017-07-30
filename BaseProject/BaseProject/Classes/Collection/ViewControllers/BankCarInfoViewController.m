//
//  BankCarInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "BankCarInfoViewController.h"

@interface BankCarInfoViewController ()
@property(retain,atomic) UITextField *txtUserName;
@property(retain,atomic) UITextField *txtCardNo;
@end

@implementation BankCarInfoViewController
@synthesize model = _model;
-(void) setModel:(BankCardModel *)model{
    _txtCardNo.text = model.cardNumber;
    _txtUserName.text = model.userName;
    _model = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"新增银行卡"];
    [self addSubviews];
}

-(void) addSubviews{
    UILabel *lblMsg = [[UILabel alloc] init];
    lblMsg.font = [UIFont fontWithName:[FontConstrants pingFang] size:12];
    lblMsg.textColor = [ColorContants phoneNumerFontColor];
    lblMsg.textAlignment = NSTextAlignmentLeft;
    lblMsg.text = @"请确保持卡人与银行预留姓名一致";
    [self.view addSubview:lblMsg];
    
    [lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SizeHeight(64+16));
        make.left.equalTo(self.view.mas_left).offset(SizeWidth(10));
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(SizeHeight(12)));
    }];
    
    UILabel *lblUserName = [[UILabel alloc] init];
    lblUserName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    lblUserName.textColor = [ColorContants userNameFontColor];
    lblUserName.textAlignment = NSTextAlignmentLeft;
    lblUserName.text = @"持卡人:";
    [self.view addSubview:lblUserName];
    
    [lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMsg.mas_bottom).offset(SizeHeight(76/2));
        make.left.equalTo(lblMsg.mas_left);
        make.width.equalTo(@(SizeWidth(55)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    UIView *border1 = [UIView new];
    border1.backgroundColor = [ColorContants otherFontColor];
    [self.view addSubview:border1];

    [border1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblUserName.mas_bottom).offset(SizeHeight(34/2));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(730)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    CGFloat padding = 15;
    UILabel *lblCardName = [[UILabel alloc] init];
    lblCardName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    lblCardName.textColor = [ColorContants userNameFontColor];
    lblCardName.textAlignment = NSTextAlignmentLeft;
    lblCardName.text = @"银行卡号:";
    [self.view addSubview:lblCardName];
    
    [lblCardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(border1.mas_bottom).offset(SizeHeight(padding));
        make.left.equalTo(lblMsg.mas_left);
        make.width.equalTo(@(SizeWidth(70)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    UIView *border2 = [UIView new];
    border2.backgroundColor = [ColorContants otherFontColor];
    [self.view addSubview:border2];
    
    [border2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblCardName.mas_bottom).offset(SizeHeight(20));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(730)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    UIButton *btnConfirm = [[UIButton alloc] init];
    btnConfirm.backgroundColor = [ColorContants BlueFontColor];
    btnConfirm.layer.cornerRadius = SizeHeight(3);
    [btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forState:UIControlStateNormal];
    [btnConfirm setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnConfirm.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:16];
    
    [btnConfirm addTarget:self action:@selector(tapConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(border2.mas_bottom).offset(SizeHeight(18));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(43)));
    }];
    
    UIFont *placeHolderFont = [UIFont fontWithName:[FontConstrants pingFang] size:14];
    UIColor *placeHolderColor = [ColorContants integralWhereFontColor];
   
    _txtUserName = [UITextField new];
    _txtUserName.font = placeHolderFont;
    _txtUserName.textColor = [ColorContants kitingFontColor];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请天假持卡人姓名" attributes:@{ NSForegroundColorAttributeName : placeHolderColor,NSFontAttributeName:placeHolderFont}];
    _txtUserName.attributedPlaceholder = str;
    
    [self.view addSubview:_txtUserName];
    
    [_txtUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblUserName.mas_centerY);
        make.left.equalTo(lblUserName.mas_right).offset(SizeWidth(5));
        make.right.equalTo(border1.mas_right);
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _txtCardNo = [UITextField new];
    _txtCardNo.font = placeHolderFont;
    _txtCardNo.textColor = [ColorContants kitingFontColor];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"请填写银行卡卡号" attributes:@{ NSForegroundColorAttributeName : placeHolderColor,NSFontAttributeName:placeHolderFont}];
    _txtCardNo.attributedPlaceholder = str1;
    
    [self.view addSubview:_txtCardNo];
    
    [_txtCardNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblCardName.mas_centerY);
        make.left.equalTo(lblCardName.mas_right).offset(SizeWidth(5));
        make.right.equalTo(border1.mas_right);
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _txtCardNo.text = _model.cardNumber;
    _txtUserName.text = _model.userName;
}

-(void) tapConfirmButton{
    
}
@end
