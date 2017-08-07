//
//  ChangeNickViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ChangeNickViewController.h"

@interface ChangeNickViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;

@end

@implementation ChangeNickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改昵称";
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickChangeNickBackBtn)];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(ClickNIckBtn)];
    // Do any additional setup after loading the view from its nib.
}

- (void)ClickNIckBtn{

    NSMutableDictionary *NickDic = [NSMutableDictionary new];
    [NickDic setObject:self.nickNameTF.text forKey:@"nickname"];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [NickDic setObject:userTokenStr forKey:@"userToken"];
    [HttpRequest postPath:@"_update_userinfo_001" params:NickDic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
//            NSDictionary *infoDIc = datadic[@"info"];
            [ConfigModel mbProgressHUD:@"昵称修改成功" andView:nil];
            [ConfigModel saveString:self.nickNameTF.text forKey:@"PersonNickName"];
            [self performSelector:@selector(backNickBtn) withObject:self afterDelay:2.0];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:@"昵称修改失败" andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];

}

- (void)backNickBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickChangeNickBackBtn{
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
