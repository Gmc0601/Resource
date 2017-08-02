//
//  fixPhoneViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "fixPhoneViewController.h"

@interface fixPhoneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getcodeFixBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fixBtnWidth;

@end

@implementation fixPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机号";
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickFixBackBtn)];
     self.fixBtnWidth.constant = SizeWidth(345);
    self.getcodeFixBtn.layer.cornerRadius = 2.5;
    self.getcodeFixBtn.layer.borderWidth = 1.0;
    self.getcodeFixBtn.layer.borderColor = UIColorFromHex(0x379ff2).CGColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)clickFixBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
