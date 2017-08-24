//
//  BaseTableView.h
//  EasyMake
//
//  Created by cc on 2017/5/10.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"

@interface BaseTableView : CCBaseViewController

@property (nonatomic, retain) UITableView *CC_table;

- (void)back:(UIButton *)sender ;

- (void)more:(UIButton *)sender ;

- (void)CC_reloadDate;

@end
