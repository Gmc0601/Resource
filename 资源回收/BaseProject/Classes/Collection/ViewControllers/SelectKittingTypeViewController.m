//
//  SelectKittingTypeViewController.m
//  BaseProject
//
//  Created by LeoGeng on 24/10/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "SelectKittingTypeViewController.h"
#import <Masonry/Masonry.h>
#import "Constants.h"

@interface SelectKittingTypeViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (retain, atomic) UIView *kitting;
@property (retain, atomic) UIView *buy;
@end

@implementation SelectKittingTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bg = [UIView new];
    bg.backgroundColor = [ColorContants integralWhereFontColor];
    [self.container addSubview:bg];
   

    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.container.mas_left);
        make.right.equalTo(self.container.mas_right);
        make.top.equalTo(self.container.mas_top);
        make.height.equalTo(@(30));
    }];
    
    UILabel *lbl = [UILabel new];

    lbl.text = @"提示";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [ColorContants userNameFontColor];
    lbl.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(16)];
    [bg addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg.mas_centerX);
        make.centerY.equalTo(bg.mas_centerY);
        make.width.equalTo(@(SizeWidth(50)));
        make.height.equalTo(@(SizeHeight(16)));
    }];
    
    UIView *kittingView = [UIView new];
    [self.container addSubview:kittingView];
    [kittingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.container.mas_left).offset(SizeWidth(20));
        make.top.equalTo(lbl.mas_bottom).offset(SizeHeight(25));
        make.height.equalTo(@(SizeHeight(38)));
        make.right.equalTo(self.container.mas_right).offset(-SizeWidth(20));
    }];
    
    UIView *bugView = [UIView new];
    [self.container addSubview:bugView];
    [bugView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.container.mas_left).offset(SizeWidth(20));
        make.top.equalTo(kittingView.mas_bottom).offset(SizeHeight(10));
        make.height.equalTo(@(SizeHeight(38)));
        make.right.equalTo(self.container.mas_right).offset(-SizeWidth(20));
    }];
    
    
    UILabel *lbl1 = [UILabel new];
    lbl1.text = @"积分兑换";
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.textColor = [ColorContants userNameFontColor];
    lbl1.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(16)];
    [kittingView addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kittingView.mas_left);
        make.top.equalTo(kittingView);
        make.height.equalTo(@(SizeHeight(20)));
        make.width.equalTo(@(SizeWidth(100)));
    }];
    
    UILabel *lbl2 = [UILabel new];
    lbl2.text = @"兑换会减掉相应的积分";
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
    lbl2.textColor = [ColorContants integralWhereFontColor];
    [kittingView addSubview:lbl2];
    [lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl1.mas_left);
        make.top.equalTo(lbl1.mas_bottom);
        make.height.equalTo(@(SizeHeight(14)));
        make.width.equalTo(@(SizeWidth(150)));
    }];
    
    UILabel *lbl3 = [UILabel new];
    lbl3.text = @"订购";
    lbl3.font = lbl1.font;
    lbl3.textColor = lbl1.textColor;
    lbl3.textAlignment = NSTextAlignmentLeft;
    [bugView addSubview:lbl3];
    [lbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bugView.mas_left);
        make.top.equalTo(bugView);
        make.height.equalTo(@(SizeHeight(20)));
        make.width.equalTo(@(SizeWidth(100)));
    }];
    
    UILabel *lbl4 = [UILabel new];
    lbl4.text = @"订购商品线下付款";
    lbl4.font =  lbl2.font;
    lbl4.textColor =  lbl2.textColor;
    lbl4.textAlignment = NSTextAlignmentLeft;
    [bugView addSubview:lbl4];
    [lbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl3.mas_left);
        make.top.equalTo(lbl3.mas_bottom);
        make.height.equalTo(@(SizeHeight(14)));
        make.width.equalTo(@(SizeWidth(150)));

    }];
    
    _kitting = [UIView new];
    _kitting.backgroundColor = [UIColor blackColor];
    _kitting.layer.borderWidth = 3;
    _kitting.layer.cornerRadius = 10;
    [kittingView addSubview:_kitting];
    [_kitting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(kittingView.mas_right);
        make.centerY.equalTo(kittingView);
        make.height.equalTo(@(SizeHeight(20)));
        make.width.equalTo(@(SizeWidth(20)));
    }];
    
    _buy = [UIView new];
    _buy.backgroundColor = [UIColor whiteColor];
    _buy.layer.borderWidth = 3;
    _buy.layer.cornerRadius = 10;
    [bugView addSubview:_buy];
    [_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bugView.mas_right);
        make.centerY.equalTo(bugView);
        make.height.equalTo(@(SizeHeight(20)));
        make.width.equalTo(@(SizeWidth(20)));
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapKitting)];
    kittingView.userInteractionEnabled = YES;
    [kittingView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBuy)];
    bugView.userInteractionEnabled = YES;
    [bugView addGestureRecognizer:tap2];
   
}

-(void) tapKitting{
    _kitting.backgroundColor = [UIColor blackColor];
    _buy.backgroundColor = [UIColor whiteColor];
    [self.delegate didChangeType:@"kit"];
}

-(void) tapBuy{
    _kitting.backgroundColor = [UIColor whiteColor];
    _buy.backgroundColor = [UIColor blackColor];
    [self.delegate didChangeType:@"buy"];

}

@end
