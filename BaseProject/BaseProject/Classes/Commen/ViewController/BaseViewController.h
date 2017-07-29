//
//  BaseViewController.h
//  BaseProject
//
//  Created by cc on 2017/6/22.
//  Copyright © 2017年 cc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIColor+BGHexColor.h"

@interface BaseViewController : UIViewController

- (void)backAction;

- (void)setNavTitle:(NSString *)title;
-(CGFloat) getNavBarHeight;
@end
