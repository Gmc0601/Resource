//
//  RegisterResultViewController.m
//  BaseProject
//
//  Created by LeoGeng on 01/08/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "RegisterResultViewController.h"
#import "LoginViewController.h"
#import "RegisterInfoViewController.h"
#import "FactorySet.h"
@interface RegisterResultViewController ()
@property(retain,atomic) UILabel *lblMsg ;
@property(retain,atomic) UIImageView *img;
@end

@implementation RegisterResultViewController

@synthesize status = _status;
-(void) setStatus:(int)status{
    if (status == 1 || status == 4) {
        [self addApprovingView];
    }else if (status == 2) {
        [self addApprovedView];
    }else if (status == 3) {
        [self addRejectedView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"资料审核"];
    
    [self.navigationItem setHidesBackButton:NO animated:NO];
    
    UIBarButtonItem *leftBarButtonItem = [FactorySet createBackBarButtonItemWithTarget:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

-(void) addApprovingView{
    [self addImage:@"zlsh_icon_shz"];
    [self addMessageLabel:@"以上资料已提交，正在审核中..."];
}

-(void) addRejectedView{
    [self addImage:@"zlsh_icon_yw"];
    [self addMessageLabel:@"因填写的资料有误，请重新填写"];
    [self addRegistButton];
}

-(void) addApprovedView{
    [self addImage:@"zlsh_icon_tg"];
    [self addMessageLabel:@"您的审核已通过"];
}

-(void) addMessageLabel:(NSString *) text{
    _lblMsg = [[UILabel alloc]init];
    _lblMsg.textColor = [ColorContants integralWhereFontColor];
    _lblMsg.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    _lblMsg.textAlignment = NSTextAlignmentCenter;
    _lblMsg.text = text;
    [self.view addSubview:_lblMsg];
    
    [_lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_img.mas_bottom).offset(SizeHeight(15));
        make.height.equalTo(@(SizeHeight(13)));
        make.width.equalTo(@(SizeWidth(250)));
    }];
}

-(void) addImage:(NSString *) imageName{
    _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self.view addSubview:_img];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(SizeHeight(242/2)+[self getNavBarHeight]);
        make.height.equalTo(@(SizeHeight(100)));
        make.width.equalTo(@(SizeWidth(100)));
    }];
}

-(void) addBackButton{
    UIButton *btnBack = [[UIButton alloc] init];
    btnBack.backgroundColor = [ColorContants gray];
    btnBack.layer.cornerRadius = SizeHeight(5);
    [btnBack setTitle:@"返回首页" forState:UIControlStateNormal];
    [btnBack setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeHeight(15)];
    
    [btnBack addTarget:self action:@selector(tapBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnBack];
    [self addConstraintsForButtton:btnBack];
}

-(void) addRegistButton{
    UIButton *btnBack = [[UIButton alloc] init];
    btnBack.layer.cornerRadius = SizeHeight(5);
    [btnBack setTitle:@"重新注册" forState:UIControlStateNormal];
    btnBack.backgroundColor = [ColorContants BlueButtonColor];
    [btnBack setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeHeight(15)];
    
    [btnBack addTarget:self action:@selector(tapRegistButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnBack];
    [self addConstraintsForButtton:btnBack];
}

-(void) addConstraintsForButtton:(UIButton *) btn{
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblMsg.mas_bottom).offset(SizeHeight(20));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(44)));
    }];
}

-(void) tapBackButton{
    
}

-(void) backAction{
    LoginViewController *newVC = [LoginViewController new];
    [self presentViewController:newVC animated:YES completion:nil];
}

-(void) tapRegistButton{
    NSString *telNo = [ConfigModel getStringforKey:@"PersonPhone"];
    RegisterInfoViewController *newVC = [[RegisterInfoViewController alloc] initWithTelNo:telNo];
    [self.navigationController pushViewController:newVC animated:YES];
}

@end
