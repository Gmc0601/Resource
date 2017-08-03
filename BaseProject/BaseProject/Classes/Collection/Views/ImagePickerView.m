//
//  ImagPickerView.m
//  BaseProject
//
//  Created by LeoGeng on 03/08/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "ImagePickerView.h"
#import "Constants.h"
#import <Masonry/Masonry.h>

@interface ImagePickerView();
@property(retain,atomic) UILabel *lblRemaind;
@property(retain,nonatomic) NSString *buttonTitle;
@property(retain,nonatomic) NSData *imgData;
@property(retain,nonatomic) UIImageView *backgroundImageView;
@end

@implementation ImagePickerView

- (instancetype)initWithImage:(NSData *) img withRemaindText:(NSString *) remmaindText
{
    self = [super init];
    if (self) {
        _imgData = img;
        _buttonTitle = remmaindText;
        [self addSubviews];
    }
    return self;
}

-(void) addSubviews{
    
    if (_imgData!=nil) {
        [self addImage:_imgData];

        return;
    }
    
    _lblRemaind = [[UILabel alloc] init];
    _lblRemaind.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    _lblRemaind.textColor = [ColorContants integralWhereFontColor];
    _lblRemaind.textAlignment = NSTextAlignmentCenter;
    _lblRemaind.text = _buttonTitle;
    [self addSubview:_lblRemaind];
    
    [_lblRemaind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(SizeHeight(-15));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(13)));
    }];
    
    UIButton *btnUpload = [[UIButton alloc] init];
    btnUpload.layer.cornerRadius = SizeHeight(3);
    [btnUpload setTitle:@"上传" forState:UIControlStateNormal];
    btnUpload.backgroundColor=[ColorContants BlueButtonColor];
    [btnUpload setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnUpload.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    
    [btnUpload addTarget:self action:@selector(tapUploadButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btnUpload];
    [btnUpload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_centerY).offset(SizeHeight(5));
        make.width.equalTo(@(SizeWidth(98)));
        make.height.equalTo(@(SizeHeight(32)));
    }];
}

-(void) addImage:(NSData *) imgData{
    if (_backgroundImageView == nil) {
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_backgroundImageView];
        
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(self);
        }];
        
        [self addtapGuesture];
    }
    
    _backgroundImageView.image = [UIImage imageWithData:imgData];
}

-(void) tapUploadButton{
    [self.delegate chooseImage:self];
}

-(void) setImage:(NSData *)img{
    _imgData = img;
    [self addImage:_imgData];
}

-(NSData *) getImage{
    return  _imgData;
}

-(void) addtapGuesture{
    UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUploadButton)];
    
    re.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:re];
}
@end
