//
//  TBNavigationController.m
//  BaseProject
//
//  Created by cc on 2017/6/22.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "TBNavigationController.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@interface TBNavigationController ()<UINavigationBarDelegate>

@end

@implementation TBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        
        if (iOS7) {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb.png"] forBarMetrics:UIBarMetricsDefault];
        } else {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
        }
        
    }
        
    
    //导航栏
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(0, 0, 10, 19);
    setBtn.backgroundColor = [UIColor redColor];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"icon_fh"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(popToBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:setBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}


@end
