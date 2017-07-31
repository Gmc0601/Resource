//
//  PublicClass.m
//  BaseProject
//
//  Created by lxl on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "PublicClass.h"
#import <PopupDialog/PopupDialog-Swift.h>
#import "Constants.h"

@implementation PublicClass
+ (UIButton *)setRightTitleOnTargetNav:(id)controller action:(SEL)action Title:(NSString *)title{
    //设置navbar上的右键按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:149/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC" size:15];
    [rightBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [[controller navigationItem] setRightBarButtonItem:backItem];
    return rightBtn;
}
+ (UIButton *)setLeftButtonItemOnTargetNav:(id)controller action:(SEL)action image:(UIImage *)image{
    //设置navbar上的左键按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    rightBtn.adjustsImageWhenHighlighted = NO;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [[controller navigationItem] setLeftBarButtonItem:backItem];
    return rightBtn;
}
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
    //中间文字
+ (UILabel *)seTitleViewOnTargetNav:(id)controller UIFont:(UIFont *)font title:(NSString *)title textColor:(UIColor *)color{
    UILabel * lab = [[UILabel alloc]init];
    lab.text = title;
    lab.textColor = color;
    lab.font = font;
    [lab sizeToFit];
    [[controller navigationItem] setTitleView:lab];
    return lab;
}
+(BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor
    {
        if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor))
        {
            NSLog(@"颜色相同");
            return YES;
        }
        else
        {
            NSLog(@"颜色不同");
            return NO;
        }
    }
    
    +(void) showCallPopupWithTelNo:(NSString *) telNo inViewController:(UIViewController*) viewController{
        PopupDialog *popup = [[PopupDialog alloc] initWithTitle:@"拨打平台电话"
                                                        message:telNo
                                                          image:nil
                                                buttonAlignment:UILayoutConstraintAxisHorizontal
                                                transitionStyle:PopupDialogTransitionStyleBounceUp
                                               gestureDismissal:YES
                                                     completion:nil];
        
        PopupDialogDefaultViewController *popupViewController = (PopupDialogDefaultViewController *)popup.viewController;
        
        popupViewController.titleColor = [ColorContants userNameFontColor];
        popupViewController.titleFont = [UIFont fontWithName:[FontConstrants pingFang] size:15];
        
        popupViewController.messageColor = [ColorContants kitingFontColor];
        popupViewController.messageFont = [UIFont fontWithName:[FontConstrants pingFang] size:13];
        
        
        CancelButton *cancel = [[CancelButton alloc] initWithTitle:@"取消" height:50 dismissOnTap:NO action:^{
            [popup dismiss:^{
                
            }];
        }];
        
        cancel.titleColor = popupViewController.titleColor;
        
        DefaultButton *ok = [[DefaultButton alloc] initWithTitle:@"拨打" height:50 dismissOnTap:NO action:^{
            NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",telNo];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
            [popup dismiss:^{
                
            }];
        }];
        
        ok.titleColor = popupViewController.titleColor;
        
        [popup addButtons: @[ok, cancel]];
        
        [viewController presentViewController:popup animated:YES completion:nil];
        
    }
    
    @end
