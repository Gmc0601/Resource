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
@property (weak, nonatomic) IBOutlet UIButton *PersonBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *personBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepaViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdSepaHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qqHeight;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    
    self.personBtnHeight.constant = 64*kScreenH/667;
    self.sepaViewHeight.constant = 153*kScreenH/667;
    self.thirdHeight.constant = 73*kScreenH/667;
    self.thirdSepaHeight.constant = 83.5*kScreenH/667;
    self.qqHeight.constant = 48*kScreenH/667;
    
    NSLog(@"%f", self.personBtnHeight.constant);
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)CreateUI{
    self.PersonBtn.layer.cornerRadius = 14.5;
    self.PersonBtn.layer.borderWidth = 1;
    self.PersonBtn.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    
    self.shopBtn.layer.cornerRadius = 14.5;
    self.shopBtn.layer.borderWidth = 1;
    self.shopBtn.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
    
    self.getCodeBtn.layer.cornerRadius = 2;
    self.getCodeBtn.layer.borderWidth = 1;
    self.getCodeBtn.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    
    self.loginBtn.layer.cornerRadius = 22;

}

- (IBAction)ProtocolBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (IBAction)btnClick:(id)sender {
    
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:[PersonViewController new]];
    
    [self presentViewController:na animated:YES completion:^{
        
    }];
//    PersonViewController *personHomePageVC = [[PersonViewController alloc] init];
//    [self.navigationController pushViewController:personHomePageVC animated:YES];

}



@end
