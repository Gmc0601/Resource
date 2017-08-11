//
//  LoginViewController.m
//  BaseProject
//
//  Created by cc on 2017/7/23.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "LoginViewController.h"
#import "PersonViewController.h"
#import "RegisterInfoViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MBProgressHUD.h"
#import "RegisterResultViewController.h"
#import "HomeViewController.h"

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


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@property (nonatomic, assign) BOOL IsPerson;
@property (nonatomic, assign) BOOL IsStore;
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
    self.qqHeight.constant = SizeHeight(44);
    
    
     self.logginBtnHeight.constant = SizeHeight(44);
     self.logginBtnTop.constant = SizeHeight(20);
     self.logginBottomBtn.constant = SizeHeight(20);
     self.IsPerson = YES;
     self.IsStore = NO;
    NSLog(@"%f", self.personBtnHeight.constant);
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)personLoginBtn:(UIButton *)sender {
    sender.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    [self.PersonBtn setTitleColor:UIColorFromHex(0x79b4f8) forState:UIControlStateNormal];
    self.shopBtn.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
    [self.shopBtn setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
    self.IsPerson = YES;
    self.IsStore = NO;
}

- (IBAction)StoreLoginBtn:(UIButton *)sender {
    sender.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    [sender setTitleColor:UIColorFromHex(0x79b4f8) forState:UIControlStateNormal];
     self.PersonBtn.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
     [self.PersonBtn setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
     self.IsPerson = NO;
     self.IsStore = YES;
}


- (IBAction)protocolBtn:(UIButton *)sender {
    [ConfigModel mbProgressHUD:@"使用本产品必需同意用户协议" andView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)CreateUI{
    self.PersonBtn.layer.cornerRadius = SizeHeight(14.5);
    self.PersonBtn.layer.borderWidth = 1;
    self.PersonBtn.layer.borderColor = UIColorFromHex(0x79b4f8).CGColor;
    [self.PersonBtn setTitleColor:UIColorFromHex(0x79b4f8) forState:UIControlStateNormal];
    
    self.shopBtn.layer.cornerRadius = SizeHeight(14.5);
    self.shopBtn.layer.borderWidth = 1;
    self.shopBtn.layer.borderColor = UIColorFromHex(0xcccccc).CGColor;
    [self.shopBtn setTitleColor:UIColorFromHex(0xcccccc) forState:UIControlStateNormal];
    
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

- (IBAction)weixinBtn:(id)sender {
     [self getAuthWithUserInfoFromWechat];
}

- (IBAction)qqBtn:(id)sender {
    [self getAuthWithUserInfoFromQQ];
}

- (void)getAuthWithUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}




- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"Wechat: %@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}


//获取验证码
- (IBAction)getCodeBtn:(UIButton *)sender {
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
//            _codeddStr = datadic[@"info"];
            
            self.timeCount = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];

        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
//        NSLog(@"error>>>>%@", error);
    }];
    
}

- (IBAction)loginBtn:(UIButton *)sender {
    NSMutableDictionary *loginDic = [NSMutableDictionary new];
    [loginDic setObject:self.phoneTF.text forKey:@"mobile"];
    [loginDic setObject:self.codeTF.text forKey:@"code"];
    if (self.IsPerson) {
        [loginDic setObject:@"1" forKey:@"user_type"];
    }else{
         [loginDic setObject:@"2" forKey:@"user_type"];
    }
    
    [HttpRequest postPath:@"_login_001" params:loginDic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        [ConfigModel saveString:self.phoneTF.text forKey:@"PersonPhone"];
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = datadic[@"info"];
            NSString *usertoken = infoDic[@"userToken"];
            if (self.IsPerson) {
                 [ConfigModel saveBoolObject:_IsPerson forKey:isPersonlogin];
            }else{
                 [ConfigModel saveBoolObject:_IsStore forKey:isStorelogin];
            }
           
            [ConfigModel saveString:usertoken forKey:UserToken];
            [ConfigModel saveString:infoDic[@"avatar_url"] forKey:@"PersonPortrait"];
            [ConfigModel saveString:infoDic[@"nickname"] forKey:@"PersonNickName"];
           
            if (_IsPerson) {
                PersonViewController *personVC = [[ PersonViewController alloc] init];
                personVC.protraitUrlStr = infoDic[@"avatar_url"];
                personVC.nickNameStr = infoDic[@"nickname"];
                personVC.phoneStr = infoDic[@"mobile"];
                [self.navigationController pushViewController:personVC animated:YES];
            }else{
                HomeViewController * homeVC = [[HomeViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];

                [self presentViewController:nav animated:YES completion:nil];
            }
        }else {
            NSString *info = datadic[@"info"];
            if([datadic[@"info"]  isEqual: @"该商家账号尚未注册，请先提交注册申请！"]){
                RegisterInfoViewController *newVC = [[RegisterInfoViewController alloc] initWithTelNo:self.phoneTF.text];
                [self.navigationController pushViewController:newVC animated:YES];
            }else if([datadic[@"info"] isEqualToString:@"商家注册尚未通过，请等待！"]){
                RegisterResultViewController *newVC = [RegisterResultViewController new];
                newVC.status = 1;
                [self.navigationController pushViewController:newVC animated:YES];
            }else if([datadic[@"info"] isEqualToString:@"商家注册未通过，请重新提交！"]){
                RegisterResultViewController *newVC = [RegisterResultViewController new];
                newVC.status = 3;
                [self.navigationController pushViewController:newVC animated:YES];
            }
            else{
                [ConfigModel mbProgressHUD:info andView:nil];
            }
        }
        NSLog(@"error>>>>%@", error);
    }];
    
}

- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        self.getCodeBtn.font = [UIFont systemFontOfSize:12];
        [self.getCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.getCodeBtn setTitleColor:RGBColor(55, 159, 242) forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getCodeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        self.getCodeBtn.font = [UIFont systemFontOfSize:12];
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [self.getCodeBtn setTitle:str forState:UIControlStateNormal];
        self.getCodeBtn.userInteractionEnabled = NO;
        
    }
    
}

@end
