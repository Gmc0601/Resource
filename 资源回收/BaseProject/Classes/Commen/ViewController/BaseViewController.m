//
//  BaseViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/22.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "BaseViewController.h"
#include "FactorySet.h"
#include "PublicClass.h"
#import "ConfigModel.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define ViewController_BackGround [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]//视图控制器背景颜色
@interface BaseViewController ()
@property (nonatomic, retain) UIView* overlayView;
@property (nonatomic, retain) UIView* bgview;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIImageView *loadingImageView;
@end

@implementation BaseViewController


- (void)viewDidLoad
{
    
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏 返回 按钮
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1){
        
        [self.navigationItem setHidesBackButton:NO animated:NO];
        
        UIBarButtonItem *leftBarButtonItem = [FactorySet createBackBarButtonItemWithTarget:self action:@selector(backAction)];
        
        if (iOS7) {
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -15;
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButtonItem];
            
        }else{
            
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        }
        
        //返回的手势
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSweepGesture:)];
        gesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:gesture];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
        [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
    }else{
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }
}

- (void)setNavTitle:(NSString *)str_title{
    [PublicClass seTitleViewOnTargetNav:self UIFont:[UIFont fontWithName:[FontConstrants pingFang] size:18] title:str_title textColor:UIColorFromHex(666666)];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count <= 1){
        [self.navigationController setNavigationBarHidden:YES];
    }
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)backSweepGesture:(UISwipeGestureRecognizer*)gesture{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark Action

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat) getNavBarHeight{
    return  SizeHeight(64);
}

@end
