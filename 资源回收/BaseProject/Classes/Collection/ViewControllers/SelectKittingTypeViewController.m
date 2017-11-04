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
@property (retain, atomic) UITextField *txt;
@end

@implementation SelectKittingTypeViewController

-(int) count{
    return  _txt.text.intValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lbl = [UILabel new];

    lbl.text = self.isKitting ? @"积分兑换":@"订购";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [ColorContants userNameFontColor];
    lbl.font = [UIFont fontWithName:[FontConstrants pingFangBold] size:SizeWidth(18)];
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(SizeHeight(25));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(20)));
    }];
    
    UILabel *lblMsg = [UILabel new];
    
    lblMsg.text =  self.isKitting ? @"兑换会减掉相应的积分":@"订购商品线下付款";
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.textColor = [ColorContants kitingFontColor];
    lblMsg.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    [self.view addSubview:lblMsg];
    [lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(lbl.mas_bottom).offset(SizeHeight(15));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(17)));
    }];
    
    _txt = [UITextField new];
    _txt.text = @"1";
    _txt.textAlignment = NSTextAlignmentCenter;
    _txt.textColor = [ColorContants userNameFontColor];
    _txt.font = [UIFont fontWithName:[FontConstrants helvetica] size:SizeWidth(15)];
    _txt.keyboardType = UIKeyboardTypeNumberPad;
    _txt.layer.borderColor = [ColorContants otherFontColor].CGColor;
    _txt.layer.borderWidth = SizeWidth(2);
    [self.view addSubview:_txt];
    
    [_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(lblMsg.mas_bottom).offset(SizeHeight(35));
        make.width.equalTo(@(SizeWidth(150)));
        make.height.equalTo(@(SizeHeight(44)));
    }];
   
    UIButton *btnAdd = [UIButton new];
    [btnAdd setTitle:@"+" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[ColorContants userNameFontColor] forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(18)];
    btnAdd.backgroundColor = [ColorContants otherFontColor];
    [btnAdd addTarget:self action:@selector(tapAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    [btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_txt.mas_right).offset(SizeWidth(3));
        make.centerY.equalTo(_txt);
        make.width.equalTo(@(SizeWidth(85/2)));
        make.height.equalTo(@(SizeHeight(44)));
    }];
    
    UIButton *btnSubtract = [UIButton new];
    [btnSubtract setTitle:@"-" forState:UIControlStateNormal];
    [btnSubtract setTitleColor:[ColorContants userNameFontColor] forState:UIControlStateNormal];
    btnSubtract.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(18)];
    btnSubtract.backgroundColor = [ColorContants otherFontColor];
    [btnSubtract addTarget:self action:@selector(tapSubstract) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSubtract];
    
    [btnSubtract mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_txt.mas_left).offset(-SizeWidth(3));
        make.centerY.equalTo(_txt);
        make.width.equalTo(@(SizeWidth(85/2)));
        make.height.equalTo(@(SizeHeight(44)));
    }];
}

-(void) tapAdd{
    int  count = _txt.text.intValue + 1;
    _txt.text = [NSString stringWithFormat:@"%d",count];
}

-(void) tapSubstract{
    if(_txt.text.intValue > 1){
        int  count = _txt.text.intValue - 1;
        _txt.text = [NSString stringWithFormat:@"%d",count];
    }
}

@end
