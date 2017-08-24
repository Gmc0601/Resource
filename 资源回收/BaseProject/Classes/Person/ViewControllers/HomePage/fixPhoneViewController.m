//
//  fixPhoneViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "fixPhoneViewController.h"
#import "MBProgressHUD.h"
#import "PersonViewController.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
#import "HomeViewController.h"
#import "RegisterInfoViewController.h"
@interface fixPhoneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getcodeFixBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fixBtnWidth;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@property (nonatomic, strong) NSString *codeStr;

@end

@implementation fixPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定手机号";
    self.titleLab.text = @"绑定手机号";
    self.rightBar.hidden = YES;
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickFixBackBtn)];
     self.fixBtnWidth.constant = SizeWidth(345);
    self.getcodeFixBtn.layer.cornerRadius = 2.5;
    self.getcodeFixBtn.layer.borderWidth = 1.0;
    self.getcodeFixBtn.layer.borderColor = UIColorFromHex(0x379ff2).CGColor;
    // Do any additional setup after loading the view from its nib.
}

//- (void)viewWillAppear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.translucent = YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//}
//
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//}

- (void)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)clickFixBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fixedCodeBtn:(UIButton *)sender {
    if ([self.phoneTF.text isEqualToString:@""]) {
        [ConfigModel mbProgressHUD:@"请输入正确的手机号" andView:self.view];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *codeMudic = [NSMutableDictionary dictionary];
    [codeMudic setObject:self.phoneTF.text forKey:@"mobile"];
    [HttpRequest postPath:@"_sms_002" params:codeMudic resultBlock:^(id responseObject, NSError *error) {
        //        NSLog(@"List>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        hud.hidden = YES;
        [hud removeFromSuperview];
        if ([datadic[@"error"] intValue] == 0) {
            sender.userInteractionEnabled = NO;
            _codeStr = datadic[@"info"];
            
            self.timeCount = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        //        NSLog(@"error>>>>%@", error);
    }];

}


- (IBAction)fixedBtn:(UIButton *)sender {
    if ([_codeStr isEqualToString:self.codeTF.text]) {
        
        
    }else{
        [ConfigModel mbProgressHUD:@"验证码错误" andView:self.view];
        return;
    }
    
    NSMutableDictionary *BingMudic = [NSMutableDictionary dictionary];
    if ([ConfigModel getBoolObjectforKey:@"IsQQ"]) {
        [BingMudic setObject:[ConfigModel getStringforKey:@"qqtoken"] forKey:@"qqtoken"];
        [BingMudic setObject:@"1" forKey:@"login_type"];
    }else{
        [BingMudic setObject:[ConfigModel getStringforKey:@"wechat"] forKey:@"wechat"];
        [BingMudic setObject:@"2" forKey:@"login_type"];
    }
    [BingMudic setObject:self.phoneTF.text forKey:@"mobile"];
    [BingMudic setObject:[ConfigModel getStringforKey:@"PersonPortrait"] forKey:@"avatar_url"];
    [BingMudic setObject:[ConfigModel getStringforKey:@"PersonNickName"] forKey:@"nickanme"];
    if ([[ConfigModel getStringforKey:isPersonlogin]  isEqualToString:@"1"]) {
         [BingMudic setObject:@"1" forKey:@"user_type"];
    }else{
        [BingMudic setObject:@"2" forKey:@"user_type"];
            }
    
//    NSLog(@"%@>>>>%@",[ConfigModel getStringforKey:isPersonlogin], BingMudic);
    [HttpRequest postPath:@"_setmobile_001" params:BingMudic resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"List>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
        NSString *usertoken = datadic[@"info"][@"userToken"];
        [ConfigModel saveString:usertoken forKey:UserToken];
        [ConfigModel saveString:self.phoneTF.text forKey:@"PersonPhone"];
            if ([[ConfigModel getStringforKey:isPersonlogin]  isEqualToString:@"1"]) {
                PersonViewController *personVC = [[ PersonViewController alloc] init];
                personVC.protraitUrlStr = [ConfigModel getStringforKey:@"PersonPortrait"];
                personVC.nickNameStr = [ConfigModel getStringforKey:@"PersonNickName"];
                personVC.phoneStr = [ConfigModel getStringforKey:@"PersonPhone"];
                
                UIApplication *app = [UIApplication sharedApplication];
                AppDelegate *app2 = app.delegate;
                app2.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:personVC];

                [JPUSHService setTags:nil alias:personVC.phoneStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
            }else {
                HomeViewController *personVC = [[ HomeViewController alloc] init];
//                personVC.protraitUrlStr = [ConfigModel getStringforKey:@"PersonPortrait"];
//                personVC.nickNameStr = [ConfigModel getStringforKey:@"PersonNickName"];
//                personVC.phoneStr = [ConfigModel getStringforKey:@"PersonPhone"];
                
                UIApplication *app = [UIApplication sharedApplication];
                AppDelegate *app2 = app.delegate;
                app2.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:personVC];
                
                [JPUSHService setTags:nil alias:self.phoneTF.text callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
            }
            
        }else {
            NSString *info = datadic[@"info"];
//            [ConfigModel mbProgressHUD:info andView:nil];
            if([datadic[@"info"]  isEqual: @"该商家账号尚未注册，请先提交注册申请！"]){
                RegisterInfoViewController *newVC = [[RegisterInfoViewController alloc] initWithTelNo:self.phoneTF.text];
                [self.navigationController pushViewController:newVC animated:YES];
            }
        }
        //        NSLog(@"error>>>>%@", error);
    }];

    
    
}


- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        self.getcodeFixBtn.font = [UIFont systemFontOfSize:12];
        [self.getcodeFixBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.getcodeFixBtn setTitleColor:RGBColor(55, 159, 242) forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getcodeFixBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        self.getcodeFixBtn.font = [UIFont systemFontOfSize:12];
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [self.getcodeFixBtn setTitle:str forState:UIControlStateNormal];
        self.getcodeFixBtn.userInteractionEnabled = NO;
        
    }
    
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
