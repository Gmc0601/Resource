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
#import "GTMBase64.h"
#import "LoginViewController.h"
#import "UIImage+ResizeMagick.h"
#define Card_Front_Tag 10001
#define Card_Back_Tag 10002
#define License_Tag 10003
#define Facade_Tag 10004

@interface RegisterInfoViewController ()<LocationViewControllerDelegate>
@property(retain,atomic) UITextField *txtName;
@property(retain,atomic) UITextField *txtTelNo;
@property(retain,atomic) UITextField *txtCardId;
@property(retain,atomic) UITextField *txtPointName;
@property(retain,atomic) UIButton *btnAddress;
@property(retain,atomic) UITextField *txtDetailAddress;
@property(retain,atomic) NSData *imgCardFront;
@property(retain,atomic) NSData *imgCardBack;
@property(retain,atomic) NSData *imgLicense;
@property(retain,atomic) NSData *imgfacade;
@property(retain,atomic) UIView *superView;
@property(retain,atomic) ImagePickerView *currentPicker;
@property(retain,atomic) AMapGeoPoint *location;
@property(retain,atomic) NSString *address;
@property(retain,atomic) NSString *strTel;
@end

@implementation RegisterInfoViewController

- (instancetype)initWithTelNo:(NSString *) telNo
{
    self = [super init];
    if (self) {
        _strTel = telNo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitle:@"注册信息"];
    self.titleLab.text = @"注册信息";
    self.rightBar.hidden = YES;
    [self addSubviews];
}

-(void) addSubviews{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,  kScreenH - 64)];
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
    
//    UILabel *lblTelNo = [self addTitleLable:titleFont withTitleColor:titleColor with:@"手机:" withTopView:border1];
//    UIView *border2 = [self addBorder:lblTelNo];
    
    UILabel *lblCardId = [self addTitleLable:titleFont withTitleColor:titleColor with:@"身份证号:" withTopView:border1];
    UIView *border3 = [self addBorder:lblCardId];
    
    UILabel *lblPointName = [self addTitleLable:titleFont withTitleColor:titleColor with:@"收购点名称:" withTopView:border3];
    UIView *border4 = [self addBorder:lblPointName];
    
    UILabel *lblPointAddress = [self addTitleLable:titleFont withTitleColor:titleColor with:@"收购点地址:" withTopView:border4];
    UIView *border5 = [self addBorder:lblPointAddress];
    
    UILabel *lblDetailAddress = [self addTitleLable:titleFont withTitleColor:titleColor with:@"详细地址:" withTopView:border5];
    UIView *border6 = [self addBorder:lblDetailAddress];
    _txtName = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入姓名" withLeftView:lblName];

//    _txtTelNo = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入手机号" withLeftView:lblTelNo];
//    _txtTelNo.keyboardType = UIKeyboardTypePhonePad;
    _txtCardId = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入身份证号" withLeftView:lblCardId];
     _txtPointName = [self addTextField:titleFont withTitleColor:titleColor with:@"请输入收购点名称" withLeftView:lblPointName];
     _btnAddress = [self addLocationButton:lblPointAddress];
     _txtDetailAddress = [self addTextField:titleFont withTitleColor:titleColor with:@"例：16号楼234室" withLeftView:lblDetailAddress];

    UILabel *lblImageTitle = [self addTitleLable:titleFont withTitleColor:titleColor with:@"证件上传：" withTopView:border6];
    
    CGFloat pickMargin = SizeWidth(172/2);
    
    [self addImagePickerWithTopView:lblImageTitle withCenterXOffSet:SizeWidth(-pickMargin) withRemaindText:@"身份证正面" withTag:Card_Front_Tag];
    
    UIView *picker2 = [self addImagePickerWithTopView:lblImageTitle withCenterXOffSet:SizeWidth(pickMargin) withRemaindText:@"身份证反面" withTag:Card_Back_Tag];
    
    UIView *border7 = [UIView new];
    border7.backgroundColor = [ColorContants otherFontColor];
    [_superView addSubview:border7];
    
    [border7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(picker2.mas_bottom).offset(SizeHeight(10));
        make.centerX.equalTo(_superView.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(1)));
    }];
    
    [self addImagePickerWithTopView:border7 withCenterXOffSet:SizeWidth(-pickMargin) withRemaindText:@"营业执照" withTag:License_Tag];
    [self addImagePickerWithTopView:border7 withCenterXOffSet:SizeWidth(pickMargin) withRemaindText:@"门面照片" withTag:Facade_Tag];
    
    UIButton *btnConfirm = [[UIButton alloc] init];
    btnConfirm.backgroundColor = [ColorContants BlueButtonColor];
    btnConfirm.layer.cornerRadius = SizeHeight(3);
    [btnConfirm setTitle:@"提交" forState:UIControlStateNormal];
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
    
    CGFloat width =  [lblName.text widthWithFontSize:SizeWidth(15) height:SizeHeight(15)] + SizeWidth(15);
    [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(SizeHeight(17));
        make.left.equalTo(_superView.mas_left).offset(SizeWidth(16));
        make.width.equalTo(@(width));
        make.height.equalTo(@(SizeHeight(15)));
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
        make.left.equalTo(leftView.mas_right).offset(SizeWidth(0));
        make.right.equalTo(_superView.mas_right).offset(SizeWidth(-15));
        make.height.equalTo(@(SizeHeight(20)));
    }];
    
    return txt;
}

-(UIView *) addImagePickerWithTopView:(UIView *) top withCenterXOffSet:(CGFloat) xOffset withRemaindText:remaindText withTag:(int) tag{
    ImagePickerView *background = [[ImagePickerView alloc] initWithImage:nil withRemaindText:remaindText];
    background.tag = tag;
    background.delegate = self;
    background.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    background.layer.cornerRadius = SizeWidth(2.5);
    [_superView addSubview:background];
    
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(SizeHeight(10));
        make.centerX.equalTo(_superView.mas_centerX).offset(xOffset);
        make.width.equalTo(@(SizeWidth(339/2)));
        make.height.equalTo(@(SizeHeight(234/2)));
    }];
    return background;
}

-(UIButton *) addLocationButton:(UIView *)leftView{
    UIFont *placeHolderFont = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(14)];
    UIColor *placeHolderColor = [ColorContants integralWhereFontColor];
    
    _btnAddress = [UIButton new];
    [_btnAddress setImage:[UIImage imageNamed:@"fpxq_icon_dw"] forState:UIControlStateNormal];
    _btnAddress.titleLabel.font = placeHolderFont;
    _btnAddress.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_btnAddress setTitleColor:placeHolderColor forState:UIControlStateNormal];
    [_btnAddress setTitle:@"单击选择" forState:UIControlStateNormal];
    [_btnAddress addTarget:self action:@selector(tapLocationButton) forControlEvents:UIControlEventTouchUpInside];

    
    [_superView addSubview:_btnAddress];
    [_btnAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView.mas_centerY);
        make.left.equalTo(leftView.mas_right).offset(SizeWidth(0));
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
    newViewCotroller.delegate = self;
    [self.navigationController pushViewController:newViewCotroller animated:YES];
}

-(void) tapConfirmButton{
    BOOL isInvalidate = NO;
    NSMutableString *strMsg = [[NSMutableString alloc] initWithString:@"请输入正确的"];
    if (_txtName.text == nil || _txtName.text.length == 0) {
        [strMsg appendString:@"姓名"];
        isInvalidate = YES;
    }
    
//    if (_txtTelNo.text == nil || ![_txtTelNo.text isTelNumber]) {
//        [strMsg appendString:@",手机号码"];
//        isInvalidate = YES;
//    }
    
    if (_txtCardId.text == nil || ![_txtCardId.text isIdCardNo]) {
        [strMsg appendString:@",身份证号码"];
        isInvalidate = YES;
    }
    
    if (_txtPointName.text == nil || _txtPointName.text.length == 0) {
        [strMsg appendString:@",收购点名称"];
        isInvalidate = YES;
    }
    
    if (_txtDetailAddress.text == nil || _txtDetailAddress.text.length == 0) {
        [strMsg appendString:@",详细地址"];
        isInvalidate = YES;
    }
    
    if (_location == nil) {
        [strMsg appendString:@"\n请选择收购点地址"];
        isInvalidate = YES;
    }
    
    if (_imgfacade == nil || _imgLicense == nil || _imgCardBack == nil || _imgCardFront == nil) {
         [strMsg appendString:@"\n请上传全部图片"];
        isInvalidate = YES;
    }
    
    if (strMsg.length > 0 && isInvalidate) {
        NSString *msg = strMsg;
        if ([strMsg containsString:@"请输入正确的"]) {
            NSString *str = [strMsg substringWithRange:NSMakeRange(6, 1)];
            if ([str  isEqual: @","]) {
                msg = [strMsg stringByReplacingCharactersInRange:NSMakeRange(6, 1) withString:@""];
            }
        }
    
        [ConfigModel mbProgressHUD:msg andView:self.view];
        return;
    }
    

    [ConfigModel showHud:self];

    NSMutableDictionary *params = [NSMutableDictionary new];

    NSString *address = [NSString stringWithFormat:@"%@%@",_address,_txtDetailAddress.text];
    
    [params setObject:_txtName.text forKey:@"nickname"];
    [params setObject:_strTel forKey:@"mobile"];
    [params setObject:_txtCardId.text forKey:@"id_num"];
    [params setObject:_txtPointName.text forKey:@"good_name"];
    [params setObject:address forKey:@"address"];
    [params setObject:[NSString stringWithFormat:@"%f",_location.longitude] forKey:@"long"];
    [params setObject:[NSString stringWithFormat:@"%f",_location.latitude] forKey:@"lat"];
    [params setObject:[GTMBase64 encodeBase64Data:_imgCardFront] forKey:@"front_img"];
    [params setObject:[GTMBase64 encodeBase64Data:_imgCardBack] forKey:@"verso_img"];
    [params setObject:[GTMBase64 encodeBase64Data:_imgLicense] forKey:@"permit"];
    [params setObject:[GTMBase64 encodeBase64Data:_imgfacade] forKey:@"good_img"];
    NSLog(@"%@",params);
    
    [HttpRequest postPath:@"_register_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        
        if ([datadic[@"error"] intValue] == 0) {
             RegisterResultViewController *newVC = [RegisterResultViewController new];
            newVC.status = 1;
            [self.navigationController pushViewController:newVC animated:YES];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
    }];

}

-(void) chooseImage:(ImagePickerView *) sender{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    _currentPicker = sender;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
   UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    image = [image resizedImageWithMaximumSize:CGSizeMake(SizeWidth(512), SizeHeight(512))];
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    if (_currentPicker.tag == Card_Front_Tag) {
        _imgCardFront = data;
    }else if (_currentPicker.tag == Card_Back_Tag){
        _imgCardBack = data;
    }else if (_currentPicker.tag == License_Tag){
        _imgLicense = data;
    }else{
        _imgfacade = data;
    }
    
    [_currentPicker setImage:UIImageJPEGRepresentation(image, 1)];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) chooseAddress:(AMapGeoPoint *)point withName:(NSString *) name withAddress:(NSString *)address{
    _location = point;
    _address = address;
    UIColor *titleColor = [ColorContants userNameFontColor];
    [_btnAddress setTitleColor:titleColor forState:UIControlStateNormal];
    [_btnAddress setTitle:_address forState:UIControlStateNormal];
}

-(void) backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
