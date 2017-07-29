//
//  SettingViewController.h
//  BaseProject
//
//  Created by JeroMac on 2017/7/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property (nonatomic, strong) NSString *phoneStr;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
