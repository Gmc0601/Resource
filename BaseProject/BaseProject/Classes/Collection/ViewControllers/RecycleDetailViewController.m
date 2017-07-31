//
//  RecycleDetailViewController.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "RecycleDetailViewController.h"
#import <Masonry/Masonry.h>
#import "PublicClass.h"

#import "NearbyTableViewCell.h"
@interface RecycleDetailViewController ()
{
    UIView *TBheadView;
    UIImageView *headImgView;
    UIImageView *BottomImgView;
    
    UILabel *moneyLabel;
    UITextField *AmountTF;
    UIButton *sureBtn;
    
    UILabel *priceLabel;
}
@end

@implementation RecycleDetailViewController
//392
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"废报纸";
    
    [self CreateUI];
    [PublicClass addCallButtonInViewContrller:self];
}


- (void)CreateUI{
    TBheadView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getNavBarHeight], kScreenW, SizeHeight(392))];
    TBheadView.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    [TBheadView addSubview:topView];
    topView.backgroundColor = UIColorFromHex(0xf1f2f2);
    
    
    BottomImgView = [[UIImageView alloc] init];
    BottomImgView.layer.cornerRadius = 5;
    BottomImgView.layer.masksToBounds = YES;
    BottomImgView.frame = CGRectMake(SizeWidth((kScreenW-SizeWidth(355))/2), SizeHeight(15), SizeWidth(355), SizeHeight(308));
    [TBheadView addSubview:BottomImgView];
    BottomImgView.image = [UIImage imageNamed:@"53ccb7628f2cd"];
    BottomImgView.userInteractionEnabled = YES;
    
    headImgView = [[UIImageView alloc] init];
    headImgView.layer.cornerRadius = 5;
    headImgView.layer.masksToBounds = YES;
    headImgView.frame = CGRectMake(-1, 1, SizeWidth(357), SizeHeight(310));
    [BottomImgView addSubview:headImgView];
    headImgView.image = [UIImage imageNamed:@"圆角矩形-11-拷贝"];
    headImgView.userInteractionEnabled = YES;
    
    moneyLabel = [[UILabel alloc] init];
    [headImgView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView);
        make.top.equalTo(headImgView).offset(SizeHeight(132));
        make.width.equalTo(headImgView);
        make.height.equalTo(@(SizeHeight(20)));
        
    }];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = @"¥ 8.88";
    moneyLabel.font = [UIFont systemFontOfSize:24];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:moneyLabel.text];
    NSRange range = NSMakeRange(0, 1);
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    moneyLabel.attributedText = attString;
    
    
    
    UILabel *unitLabel = [[UILabel alloc]init];
    [headImgView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.top.equalTo(moneyLabel).offset(SizeHeight(54));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(13)));
        
    }];
    unitLabel.font = [UIFont systemFontOfSize:15];
    unitLabel.text = @"重量(kg):";
    
    
    AmountTF = [[UITextField alloc] init];
    [headImgView addSubview:AmountTF];
    AmountTF.placeholder = @"请输入废纸重量";
    AmountTF.layer.cornerRadius = 2.5;
    AmountTF.layer.borderWidth = 1;
    AmountTF.font = [UIFont systemFontOfSize:14];
    AmountTF.layer.borderColor = UIColorFromHex(0xe0e0e0).CGColor;
    [AmountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.top.equalTo(unitLabel).offset(SizeHeight(30));
        make.width.equalTo(@(SizeWidth(249)));
        make.height.equalTo(@(SizeHeight(44)));
        
    }];
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 2.5;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = UIColorFromHex(0x78b4fc);
    [sureBtn addTarget:self action:@selector(calculateMoneyBtn) forControlEvents:UIControlEventTouchUpInside];
    [headImgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headImgView).offset(SizeWidth(-20));
        make.top.equalTo(AmountTF);
        make.width.equalTo(@(SizeWidth(57)));
        make.height.equalTo(@(SizeHeight(44)));
        
    }];
    
    
    
    priceLabel = [[UILabel alloc] init];
    [headImgView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.bottom.equalTo(headImgView).offset(SizeHeight(-20));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(13)));
        
    }];
    priceLabel.text = @"单价: 0.80元/kg";
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:priceLabel.text];
    NSRange priceStrRange = NSMakeRange(4, 4);
    //    [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:priceStrRange];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:priceStrRange];
    priceLabel.attributedText = priceStr;
    
    
    [self.view addSubview:TBheadView];
}


- (void)calculateMoneyBtn{
    
}

-(void) showCallView{
    [PublicClass showCallPopupWithTelNo:@"400-800-2123" inViewController:self];
}

@end
