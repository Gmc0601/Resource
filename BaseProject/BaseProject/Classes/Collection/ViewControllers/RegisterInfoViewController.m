//
//  RegisterInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 31/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "RegisterInfoViewController.h"
#import "NSString+Category.h"
#import "LocationViewController.h"
#import "RegisterResultViewController.h"

@interface RegisterInfoViewController ()
@property(retain,atomic) UITextField *txtName;
@property(retain,atomic) UITextField *txtTelNo;
@property(retain,atomic) UITextField *txtCardId;
@property(retain,atomic) UITextField *txtPointName;
@property(retain,atomic) UIButton *btnAddress;
@property(retain,atomic) UITextField *txtDetailAddress;
@property(retain,atomic) UIImage *imgCardFront;
@property(retain,atomic) UIImage *imgCardBack;
@property(retain,atomic) UIImage *imgLicense;
@property(retain,atomic) UIImage *imgfacade;
@property(retain,atomic) UIView *superView;
@end

@implementation RegisterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
}

-(void) addSubviews{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [self getNavBarHeight], self.view.bounds.size.width, self.view.bounds.size.height - [self getNavBarHeight] - 54)];
    [scrollView setScrollEnabled:YES];
    scrollView.clipsToBounds = YES;
    _superView = [[UIView alloc] initWithFrame:self.view.bounds];
    [scrollView addSubview:_superView];
    [self.view addSubview:scrollView];
    scrollView.contentSize = _superView.bounds.size;
    
    CGFloat titlFontSize = SizeWidth(15);
    UIFont *titleFont = [UIFont fontWithName:[FontConstrants pingFang] size:titlFontSize];
    UIColor *titleColor = [ColorContants userNameFontColor];
    
    UILabel *lblName = [self addTitleLable:titleFont withTitleColor:titleColor with:@"姓名:" withTopView:_superView];
    UIView *border1 = [self addBorder:lblName];
    
    UILabel *lblTelNo = [self addTitleLable:titleFont withTitleColor:titleColor with:@"手机:" withTopView:border1];
    UIView *border2 = [self addBorder:lblTelNo];
    
    UILabel *lblCardId = [self addTitleLable:titleFont withTitleColor:titleColor with:@"身份证号:" withTopView:border2];
    UIView *border3 = [self addBorder:lblCardId];
    
    UILabel *lblPointName = [self addTitleLable:titleFont withTitleColor:titleColor with:@"收购点名称:" withTopView:border3];
    UIView *border4 = [self addBorder:lblPointName];
    
    UILabel *lblPointAddress = [self addTitleLable:titleFont withTitleColor:titleColor with:@"收购点地址:" withTopView:border4];
    UIView *border5 = [self addBorder:lblPointAddress];
    
    UILabel *lblDetailAddress = [self addTitleLable:titleFont withTitleColor:titleColor with:@"详细地址:" withTopView:border5];
    UIView *border6 = [self addBorder:lblDetailAddress];
    _txtName = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入姓名" withLeftView:lblName];

    _txtTelNo = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入手机号" withLeftView:lblTelNo];
    _txtCardId = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入身份证号" withLeftView:lblCardId];
     _txtPointName = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入收购点名称" withLeftView:lblPointName];
     _btnAddress = [self addLocationButton:lblPointAddress];
     _txtDetailAddress = [self addTextField:titleFont withTitleColor:titleColor with:@"例：16号楼234室" withLeftView:lblDetailAddress];

    UILabel *lblImageTitle = [self addTitleLable:titleFont withTitleColor:titleColor with:@"证件上传：" withTopView:border6];
    
    CGFloat pickMargin = SizeWidth(172/2);
    
    [self addImagePickerWithTopView:lblImageTitle withCenterXOffSet:SizeWidth(-pickMargin) withRemaindText:@"身份证正面"];
    
    UIView *picker2 = [self addImagePickerWithTopView:lblImageTitle withCenterXOffSet:SizeWidth(pickMargin) withRemaindText:@"身份证反面"];
    
    UIView *border7 = [UIView new];
    border7.backgroundColor = [ColorContants otherFontColor];
    [_superView addSubview:border7];
    
    [border7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picker2.mas_bottom).offset(SizeHeight(10));
        make.centerX.equalTo(_superView.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    [self addImagePickerWithTopView:border7 withCenterXOffSet:SizeWidth(-pickMargin) withRemaindText:@"营业执照"];
    [self addImagePickerWithTopView:border7 withCenterXOffSet:SizeWidth(pickMargin) withRemaindText:@"门面照片"];
    
    UIButton *btnConfirm = [[UIButton alloc] init];
    btnConfirm.backgroundColor = [ColorContants BlueFontColor];
    btnConfirm.layer.cornerRadius = SizeHeight(3);
    [btnConfirm setTitle:@"提交" forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forState:UIControlStateNormal];
    [btnConfirm setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnConfirm.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:16];
    
    [btnConfirm addTarget:self action:@selector(tapConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(SizeHeight(-20));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(44)));
    }];
}

-(UILabel *) addTitleLable:(UIFont *) font withTitleColor:(UIColor *) color with:(NSString *) text withTopView:(UIView *) topView{
    UILabel *lblName = [[UILabel alloc] init];
    lblName.font = font;
    lblName.textColor = color;
    lblName.text = text;
    [_superView addSubview:lblName];
    
    CGFloat width =  [lblName.text widthWithFontSize:15 height:15];
    [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(SizeHeight(17));
        make.left.equalTo(_superView.mas_left).offset(SizeWidth(16));
        make.width.equalTo(@(width));
        make.height.equalTo(@(15));
    }];
    
    return lblName;
}

-(UIView *) addBorder:(UIView *) topView{
    UIView *border1 = [UIView new];
    border1.backgroundColor = [ColorContants otherFontColor];
    [_superView addSubview:border1];
    
    [border1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(SizeHeight(17));
        make.centerX.equalTo(_superView.mas_centerX);
        make.width.equalTo(@(SizeWidth(730/2)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    return  border1;
}

-(UITextField *) addTextField:(UIFont *) font withTitleColor:(UIColor *) color with:(NSString *) text withLeftView:(UIView *) leftView{
    UIFont *placeHolderFont = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(14)];
    UIColor *placeHolderColor = [ColorContants integralWhereFontColor];
    
    UITextField *txt = [UITextField new];
    txt.font = font;
    txt.textColor = color;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:text attributes:@{ NSForegroundColorAttributeName : placeHolderColor,NSFontAttributeName:placeHolderFont}];
    txt.attributedPlaceholder = str;
    
    [_superView addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView.mas_centerY);
        make.left.equalTo(leftView.mas_right).offset(SizeWidth(15));
        make.right.equalTo(_superView.mas_right).offset(SizeWidth(-15));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    return txt;
}

-(UIView *) addImagePickerWithTopView:(UIView *) top withCenterXOffSet:(CGFloat) xOffset withRemaindText:remaindText{
    UIView *background = [UIView new];
    background.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    background.layer.cornerRadius = SizeWidth(2.5);
    [_superView addSubview:background];
    
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(SizeHeight(10));
        make.centerX.equalTo(_superView.mas_centerX).offset(xOffset);
        make.width.equalTo(@(SizeWidth(339/2)));
        make.height.equalTo(@(SizeHeight(234/2)));
    }];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    lbl.textColor = [ColorContants integralWhereFontColor];
    lbl.text = remaindText;
    lbl.textAlignment = NSTextAlignmentCenter;
    [background addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(background.mas_centerX);
        make.bottom.equalTo(background.mas_centerY).offset(SizeHeight(-15));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(13)));
    }];
    
    UIButton *btnUpload = [[UIButton alloc] init];
    btnUpload.layer.cornerRadius = SizeHeight(3);
    [btnUpload setTitle:@"上传" forState:UIControlStateNormal];
    [btnUpload setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forState:UIControlStateNormal];
    [btnUpload setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnUpload.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    
    [btnUpload addTarget:self action:@selector(tapConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    [background addSubview:btnUpload];
    [btnUpload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(background.mas_centerX);
        make.top.equalTo(background.mas_centerY).offset(SizeHeight(5));
        make.width.equalTo(@(SizeWidth(98)));
        make.height.equalTo(@(SizeHeight(32)));
    }];
    
    return background;
}

-(UIButton *) addLocationButton:(UIView *)leftView{
    UIFont *placeHolderFont = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(14)];
    UIColor *placeHolderColor = [ColorContants integralWhereFontColor];
    
    _btnAddress = [UIButton new];
    [_btnAddress setImage:[UIImage imageNamed:@"fpxq_icon_dw"] forState:UIControlStateNormal];
    _btnAddress.titleLabel.font = placeHolderFont;
    [_btnAddress setTitleColor:placeHolderColor forState:UIControlStateNormal];
    [_btnAddress setTitle:@"单击选择" forState:UIControlStateNormal];
    [_btnAddress addTarget:self action:@selector(tapLocationButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_superView addSubview:_btnAddress];
    [_btnAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView.mas_centerY);
        make.left.equalTo(leftView.mas_right).offset(SizeWidth(15));
        make.right.equalTo(_superView.mas_right).offset(SizeWidth(-16));
        make.height.equalTo(@(SizeHeight(30)));
    }];
    
    _btnAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnAddress.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _btnAddress.titleEdgeInsets = UIEdgeInsetsMake(0, SizeWidth(10), 0, 0);
    
    UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_gds"]];
    [_btnAddress addSubview:rightView];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btnAddress.mas_centerY);
        make.right.equalTo(_btnAddress.mas_right);
        make.height.equalTo(@(SizeHeight(14)));
        make.width.equalTo(@(SizeWidth(7)));
    }];
    
    return _btnAddress;
}

-(void) setLocationButtonTitle:(NSString *) title{
    UIFont *titleFont = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    UIColor *titleColor = [ColorContants userNameFontColor];
    
    _btnAddress.titleLabel.font = titleFont;
    [_btnAddress setTitleColor:titleColor forState:UIControlStateNormal];
    [_btnAddress setTitle:@"单击选择" forState:UIControlStateNormal];
}

-(void) tapLocationButton{
    LocationViewController *newViewCotroller = [LocationViewController new];
    [self.navigationController pushViewController:newViewCotroller animated:YES];
}

-(void) tapConfirmButton{
    RegisterResultViewController *newVC = [RegisterResultViewController new];
    [self.navigationController pushViewController:newVC animated:YES];
}

@end