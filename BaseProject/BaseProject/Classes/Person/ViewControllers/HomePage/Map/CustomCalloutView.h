//
//  CustomCalloutView.h
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mapPlayPhoneDelegate <NSObject>

- (void)playMapPhone:(NSString *) str;

@end

@interface CustomCalloutView : UIView


@property (nonatomic, strong) UIImage *leftimage; //商户图
@property(nonatomic,strong)UIImage *rightimage;//
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址

@property(nonatomic,copy)NSString *threetitle;
@property(nonatomic,strong)NSString *fourtitle;

@property (nonatomic, strong) UIImageView *portraitView;
@property(nonatomic,strong)UIImageView *rightimageView;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, assign) id <mapPlayPhoneDelegate> delegate;

@end
