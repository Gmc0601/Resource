//
//  PersonViewController.m
//  BaseProject
//
//  Created by cc on 2017/7/23.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"我也不知道是啥界面";
}

#pragma resetFarther
- (void)back:(UIButton *)sender {
    //  默认是返回  如果没有左侧返回按钮 隐藏 重写该方法 不做操作即可
}

- (void)more:(UIButton *)sender {
 //  更多 点击事件
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
