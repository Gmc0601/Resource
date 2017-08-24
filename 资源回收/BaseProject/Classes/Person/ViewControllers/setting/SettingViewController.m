//
//  SettingViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "CDZPicker.h"
#import "ConfigModel.h"
#import "ProtocolViewController.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
#import "LoginViewController.h"
#import "PersonViewController.h"
@interface SettingViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,UIApplicationDelegate>
{
    NSArray *roleArray;
    BOOL ISExist;
}
@end


@implementation SettingViewController

- (void)viewDidLoad {
    [self getPhoneStr];
    [super viewDidLoad];
    ISExist = YES;
    
    self.titleLab.text = @"设置";
    self.rightBar.hidden = YES;
//    self.phoneStr = @"15639073148";
//    self.navigationItem.title = @"设置";
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickSettingBackBtn)];
    // Do any additional setup after loading the view from its nib.
//    roleArray = [[NSArray alloc]initWithObjects:@"个人",@"回收点",nil];

    if (self.from == Person_Setting) {
        self.typeLabel.text = @"个人";
    }else {
        self.typeLabel.text = @"回收点";
    }
    
//    if (![ConfigModel isPerson]) {
//
//    }
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    
}

- (IBAction)changeRoleBtn:(UIButton *)sender {
    
    [CDZPicker showPickerInView:self.view withStrings:@[@"个人",@"回收点"] confirm:^(NSArray<NSString *> *stringArray) {
        self.typeLabel.text = stringArray.firstObject;
        
        NSMutableDictionary *changeDic = [NSMutableDictionary dictionary];
        if ([self.typeLabel.text isEqualToString:@"个人"]) {
             [changeDic setObject:@"1" forKey:@"user_type"];
        }else{
             [changeDic setObject:@"2" forKey:@"user_type"];
        }
       
        [changeDic setObject:[ConfigModel getStringforKey:@"PersonPhone"] forKey:@"mobile"];
//  5ea5511a5873cad757056d88f30ce1ae   6bc5e2b21bb8901ea08bd65278f1a546
        [HttpRequest postPath:@"_login_001" params:changeDic resultBlock:^(id responseObject, NSError *error) {
            NSLog(@"List>>>>>>%@", responseObject);
            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] == 0) {
              ISExist = YES;
                NSDictionary *dic = datadic[@"info"];
                NSString *userToken = dic[@"userToken"];
                
//                if ([self.typeLabel.text isEqualToString:@"个人"]) {
//                    [ConfigModel saveBoolObject:YES forKey:isPersonlogin];
//                    [ConfigModel saveBoolObject:NO forKey:isStorelogin];
//                }else {
//                    [ConfigModel saveBoolObject:NO forKey:isPersonlogin];
//                    [ConfigModel saveBoolObject:YES forKey:isStorelogin];
//                }
                
                [ConfigModel saveString:userToken forKey:UserToken];
                
            }else {
                ISExist = NO;

                
                NSString *info = datadic[@"info"];
                [ConfigModel mbProgressHUD:info andView:nil];
            }
            NSLog(@"error>>>>%@", error);
        }];
        
        
    }cancel:^{
        //your code
    }];

    
}



- (void)getPhoneStr{
    NSMutableDictionary *loginDic = [NSMutableDictionary new];
    [loginDic setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [HttpRequest postPath:@"_setinfo_001" params:loginDic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        if ([responseObject[@"error"] intValue] == 0) {
            NSDictionary *datadic = responseObject[@"info"];
            self.phoneStr = datadic[@"phone"];
            self.phoneLabel.text = self.phoneStr;
        }else {
            NSString *info = responseObject[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];

        }
        NSLog(@"error>>>>%@", error);
    }];
    

}


- (IBAction)PlayCustomerTelBtn:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打客服电话"
                                                    message:self.phoneLabel.text
                                                   delegate:nil
                                          cancelButtonTitle:@"拨打"
                                          otherButtonTitles:@"取消",nil];
    
    alert.delegate = self;
    [alert show];
    
//    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneStr];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",self.phoneLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}



- (IBAction)CleanMemoryBtn:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"清除缓存数据,给手机瘦身吧" message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self clearFile];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
    }];
     [alertVC addAction:cancleAction];
     [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
- (IBAction)AboutUsBtn:(UIButton *)sender {
    AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}
- (IBAction)CustomerProtocol:(UIButton *)sender {
    ProtocolViewController *protocolVC = [[ProtocolViewController alloc] init];
    [self.navigationController pushViewController:protocolVC animated:YES];
    
}


- (IBAction)logoutBtn:(UIButton *)sender {
    NSMutableDictionary *loginDic = [NSMutableDictionary new];
    [loginDic setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [HttpRequest postPath:@"_logout_001" params:loginDic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            [ConfigModel mbProgressHUD:datadic[@"info"] andView:self.view];
            [ConfigModel saveBoolObject:NO forKey:isPersonlogin];
            [ConfigModel saveBoolObject:NO forKey:isStorelogin];
            NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [defatluts dictionaryRepresentation];
            for(NSString *key in [dictionary allKeys]){
                [defatluts removeObjectForKey:key];
                [defatluts synchronize];
            }
            
            LoginViewController * loginVC = [[LoginViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:navi animated:YES completion:nil];
            
            NSLog(@"lo>>>>>>%@", [ConfigModel getStringforKey:@"PersonNickName"]);
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
//            LoginViewController * loginVC = [[LoginViewController alloc] init];
//            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            [self presentViewController:navi animated:YES completion:nil];

        }
        NSLog(@"error>>>>%@", error);
    }];
    
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_QQ completion:^(id result, NSError *error) {

    }];
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
        
    }];

}


- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
//    读取缓存大小
    float cacheSize = [self readCacheSize] *1024;
    NSLog(@"%f999-----", cacheSize);
//    self.cacheSize.text = [NSString stringWithFormat:@"%.2fKB",cacheSize];
    
//    [ConfigModel mbProgressHUD:[NSString stringWithFormat:@"恭喜您已清除%@M",[NSString stringWithFormat:@"%.2f",cacheSize/1024]] andView:self.view];
      [ConfigModel mbProgressHUD:@"恭喜您已清除完毕" andView:self.view];
    
}
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)sender {
    if ([self.typeLabel.text isEqualToString:@"个人"]) {
        [self.navigationController popViewControllerAnimated:YES];
        if (ISExist) {
            PersonViewController  *homeVC = [[PersonViewController alloc] init];
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *app2 = app.delegate;
            app2.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
            
            [JPUSHService setTags:nil alias:[ConfigModel getStringforKey:@"PersonPhone"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
            
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            
        }
        
        
    }else{
        if (ISExist) {
            HomeViewController *homeVC = [[HomeViewController alloc] init];
            UIApplication *app = [UIApplication sharedApplication];
            AppDelegate *app2 = app.delegate;
            app2.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
            
            [JPUSHService setTags:nil alias:[ConfigModel getStringforKey:@"PersonPhone"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
            
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            
        }
        
        
    }
}

//- (void)clickSettingBackBtn{
//    if ([self.typeLabel.text isEqualToString:@"个人"]) {
//        [self.navigationController popViewControllerAnimated:YES];
//        if (ISExist) {
//           PersonViewController  *homeVC = [[PersonViewController alloc] init];
//            UIApplication *app = [UIApplication sharedApplication];
//            AppDelegate *app2 = app.delegate;
//            app2.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
//            
//            [JPUSHService setTags:nil alias:[ConfigModel getStringforKey:@"PersonPhone"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//            
//        }else{
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            [self presentViewController:loginVC animated:YES completion:nil];
//            
//        }
//        
//        
//    }else{
//        if (ISExist) {
//            HomeViewController *homeVC = [[HomeViewController alloc] init];
//            UIApplication *app = [UIApplication sharedApplication];
//            AppDelegate *app2 = app.delegate;
//            app2.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
//            
//            [JPUSHService setTags:nil alias:[ConfigModel getStringforKey:@"PersonPhone"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//            
//        }else{
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            [self presentViewController:loginVC animated:YES completion:nil];
//            
//        }
//        
//        
//    }
//
//}



- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
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
