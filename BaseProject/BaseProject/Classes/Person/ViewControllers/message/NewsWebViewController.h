//
//  NewsWebViewController.h
//  BaseProject
//
//  Created by JeroMac on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LoginViewController.h"
@interface NewsWebViewController : UIViewController

@property (nonatomic, strong) UIViewController *loginViewC;
@property (nonatomic, strong) NSString *newsId;
// 标题
@property (nonatomic, strong) NSString *titleStr;


@property (nonatomic, strong) NSString *messageDetailTitle;
@property (nonatomic, strong) NSString *messageDetailTime;
@property (nonatomic, strong) NSString *messageDetailContent;


@end
