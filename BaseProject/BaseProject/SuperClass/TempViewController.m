//
//  TempViewController.m
//  BaseProject
//
//  Created by LeoGeng on 29/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "TempViewController.h"

#import "HomeViewController.h"
#import "TBNavigationController.h"
#import "LoginViewController.h"
@interface TempViewController ()

@end

@implementation TempViewController
- (IBAction)tapPerson:(id)sender {
    LoginViewController *logVC = [[LoginViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:logVC];
    //    LoginViewController *logVC = [[LoginViewController alloc] init];
    //    [self.navigationController pushViewController:logVC animated:YES];
    [self presentViewController:navc animated:YES completion:nil];
    
}

- (IBAction)tapPoint:(id)sender {
    TBNavigationController * nav = [[TBNavigationController alloc] initWithRootViewController:[HomeViewController new]];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
