//
//  PersonMessageViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "PersonMessageViewController.h"
#import "ChangeNickViewController.h"
@interface PersonMessageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
     NSData *oneImgViewData;
}

@property (weak, nonatomic) IBOutlet UIButton *ProtraitBtn;
@property (weak, nonatomic) IBOutlet UIButton *nickNameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *ProtraitImg;

@end

@implementation PersonMessageViewController

- (void)viewDidLoad {
    [self.ProtraitImg setImage:self.protraitImage];
//    [self setImageAndTitle];
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickPersonMessageBackBtn)];
    
    // Do any additional setup after loading the view from its nib.
    self.ProtraitBtn.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickPersonMessageBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self setImageAndTitle];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    //     [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)setImageAndTitle{

    [self.ProtraitImg sd_setImageWithURL:[NSURL URLWithString:[ConfigModel getStringforKey:@"PersonPortrait"]] placeholderImage:[UIImage imageNamed:@"mrtx144"] completed:nil];

    if ([[ConfigModel getStringforKey:@"PersonNickName"] isEqualToString:@"(null)"]) {
        [self.nickNameBtn setTitle:@"我就是个名" forState:UIControlStateNormal];
    }else{
        [self.nickNameBtn setTitle:[ConfigModel getStringforKey:@"PersonNickName"] forState:UIControlStateNormal];
    }

}




- (IBAction)ChangeNickBtn:(UIButton *)sender {
    ChangeNickViewController  *NickVC = [[ChangeNickViewController alloc ] init];
    [self.navigationController pushViewController:NickVC animated:YES];
    
}
- (IBAction)ClickHeaderBtn:(UIButton *)sender {

    UIAlertController *changeAlert = [UIAlertController alertControllerWithTitle:@"请选择图片" message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        picker.navigationBar.translucent = NO;
        picker.view.backgroundColor = [UIColor whiteColor];
        picker.sourceType               = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate                 = self;
        picker.allowsEditing            = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            picker.navigationBar.translucent = NO;
            [picker.navigationController setNavigationBarHidden:YES animated:YES];
            picker.delegate                 = self;
            picker.allowsEditing            = YES;
            picker.sourceType               = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"此设备无拍照功能" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action    = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [changeAlert addAction:photoAction];
    [changeAlert addAction:cameraAction];
    [changeAlert addAction:cancel];
    
    [self presentViewController:changeAlert animated:YES completion:nil];


}


//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *resultImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.ProtraitBtn setImage:resultImage forState:UIControlStateNormal];
//    self.ProtraitImg.image = resultImage;
    oneImgViewData=UIImageJPEGRepresentation(resultImage,0.8);
    oneImgViewData = [oneImgViewData base64EncodedDataWithOptions:0];
    
    NSString * tmpOneImgViewString = [[NSString alloc] initWithData:oneImgViewData  encoding:NSUTF8StringEncoding];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    NSDictionary *infoDic = @{
                                     @"avatar_url":tmpOneImgViewString,
                                     @"userToken" :userTokenStr
                                     };

    [HttpRequest postPath:@"_update_userinfo_001" params:infoDic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *avatarDic = datadic[@"info"];
            NSLog(@"333%@", datadic);
            [ConfigModel saveString:avatarDic[@"avatar_url"] forKey:@"PersonPortrait"];
            [ConfigModel mbProgressHUD:@"修改头像成功" andView:nil];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
    }];

    [picker dismissViewControllerAnimated:YES completion:nil];

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
