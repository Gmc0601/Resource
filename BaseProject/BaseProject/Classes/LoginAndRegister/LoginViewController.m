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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *personBTNHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logginBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logginBtnTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logginBottomBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    self.personBTNHeight.constant = SizeHeight(29);
    self.personBtnHeight.constant = SizeHeight(64);
    self.sepaViewHeight.constant = SizeHeight(153);
    self.thirdHeight.constant = SizeHeight(73);
    self.thirdSepaHeight.constant = SizeHeight(83.5);
    self.qqHeight.constant = SizeHeight(48);
    
    
     self.logginBtnHeight.constant = SizeHeight(44);
     self.logginBtnTop.constant = SizeHeight(20);
     self.logginBottomBtn.constant = SizeHeight(20);
    NSLog(@"%f", self.personBtnHeight.constant);
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)CreateUI{
    self.PersonBtn.layer.cornerRadius = SizeHeight(14.5);
    self.PersonBtn.layer.borderWidth = 1;
    self.PersonBtn.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    
    self.shopBtn.layer.cornerRadius = SizeHeight(14.5);
    self.shopBtn.layer.borderWidth = 1;
    self.shopBtn.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
    
    self.getCodeBtn.layer.cornerRadius = 2;
    self.getCodeBtn.layer.borderWidth = 1;
    self.getCodeBtn.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    
    self.loginBtn.layer.cornerRadius = SizeHeight(22);

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
