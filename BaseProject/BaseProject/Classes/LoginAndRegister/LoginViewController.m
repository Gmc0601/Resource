//
//  LoginViewController.m
//  BaseProject
//
//  Created by cc on 2017/7/23.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "LoginViewController.h"
#import "PersonViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:[PersonViewController new]];
    
    [self presentViewController:na animated:YES completion:^{
        
    }];

}



@end
