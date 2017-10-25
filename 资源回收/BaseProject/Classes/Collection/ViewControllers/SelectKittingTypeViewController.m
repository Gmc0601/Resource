//
//  SelectKittingTypeViewController.m
//  BaseProject
//
//  Created by LeoGeng on 24/10/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "SelectKittingTypeViewController.h"
#import <TNRadioButtonGroup/TNRadioButtonGroup.h>
#import <Masonry/Masonry.h>
#import "Constants.h"

@interface SelectKittingTypeViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (retain, atomic) TNRadioButtonGroup *myGroup;
@end

@implementation SelectKittingTypeViewController

-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SELECTED_RADIO_BUTTON_CHANGED object:self.myGroup];

}

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
    
    UILabel *lbl1 = [UILabel new];
    lbl1.text = @"积分兑换";
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.textColor = [ColorContants userNameFontColor];
    lbl1.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(16)];
    [self.container addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.container.mas_left).offset(SizeWidth(20));
        make.top.equalTo(lbl.mas_bottom).offset(SizeHeight(25));
        make.height.equalTo(@(SizeHeight(20)));
        make.width.equalTo(@(SizeWidth(100)));
    }];
    
    UILabel *lbl2 = [UILabel new];
    lbl2.text = @"兑换会减掉相应的积分";
    lbl2.textAlignment = NSTextAlignmentLeft;
    lbl2.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
    lbl2.textColor = [ColorContants integralWhereFontColor];
    [self.container addSubview:lbl2];
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
    [self.container addSubview:lbl3];
    [lbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl1.mas_left);
        make.top.equalTo(lbl2.mas_bottom).offset(SizeHeight(15));
        make.height.equalTo(@(SizeHeight(16)));
        make.width.equalTo(@(SizeWidth(100)));
    }];
    
    UILabel *lbl4 = [UILabel new];
    lbl4.text = @"订购商品线下付款";
    lbl4.font =  lbl2.font;
    lbl4.textColor =  lbl2.textColor;
    lbl4.textAlignment = NSTextAlignmentLeft;
    [self.container addSubview:lbl4];
    [lbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl1.mas_left);
        make.top.equalTo(lbl3.mas_bottom);
        make.height.equalTo(@(SizeHeight(12)));
        make.width.equalTo(@(SizeWidth(150)));
    }];
    
    TNCircularRadioButtonData *kitData = [TNCircularRadioButtonData new];
    kitData.identifier = @"kit";
    kitData.selected = YES;
    kitData.borderRadius = 15;
    kitData.circleRadius = 15;
    
    
    TNCircularRadioButtonData *buyData = [TNCircularRadioButtonData new];
    buyData.identifier = @"buy";
    buyData.selected = NO;
    buyData.borderRadius = 15;
    buyData.circleRadius = 15;
    
    _myGroup = [[TNRadioButtonGroup alloc] initWithRadioButtonData:@[kitData, buyData] layout:TNRadioButtonGroupLayoutVertical];
    _myGroup.identifier = @"my group";
    _myGroup.marginBetweenItems = 30;

    [_myGroup create];
    [self.container addSubview:_myGroup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexGroupUpdated:) name:SELECTED_RADIO_BUTTON_CHANGED object:_myGroup];
    
    [_myGroup update];
    
    
    [_myGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.container).offset(-SizeWidth(20));
        make.top.equalTo(lbl1.mas_top).offset(SizeHeight(5));
        make.height.equalTo(@(SizeHeight(70)));
        make.width.equalTo(@(SizeWidth(15)));
    }];
}

- (void)sexGroupUpdated:(NSNotification *)notification {
    [self.delegate didChangeType:_myGroup.selectedRadioButton.data.identifier];
}

@end
