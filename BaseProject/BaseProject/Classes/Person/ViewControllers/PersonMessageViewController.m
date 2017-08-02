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

@end

@implementation PersonMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickPersonMessageBackBtn)];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickPersonMessageBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewWillDisappear:(BOOL)animated{
//     [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (IBAction)ChangeNickBtn:(UIButton *)sender {
    ChangeNickViewController  *NickVC = [[ChangeNickViewController alloc ] init];
    [self.navigationController pushViewController:NickVC animated:YES];
    
}
- (IBAction)ClickHeaderBtn:(UIButton *)sender {
    UIActionSheet *pictureSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"用户相册", nil];
    pictureSheet.tag = 111111;
    pictureSheet.delegate=self;
    [pictureSheet showInView:self.view];

}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.navigationController.navigationBar.translucent = NO;
    if (actionSheet.tag == 111111) {
        NSString *alertTitle = nil;
        if (buttonIndex == 0)
            alertTitle = @"拍照";
        else if(buttonIndex == 1)
            alertTitle = @"用户相册";
        
        if (buttonIndex == 0) {
            if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
                
                UIImagePickerController * imagePickerC = [[UIImagePickerController alloc] init];
                imagePickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerC.delegate = self;
                imagePickerC.allowsEditing = YES;
                [self.navigationController presentViewController:imagePickerC animated:YES completion:^{}];
                
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备没有照相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }
        }else
        {
            UIImagePickerController * imagePickerC = [[UIImagePickerController alloc] init];
            imagePickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerC.delegate = self;
            imagePickerC.allowsEditing = NO;
            imagePickerC.allowsEditing = YES;
            [self.navigationController presentViewController:imagePickerC animated:YES completion:^{}];
            
        }
        
    }
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]])
    {
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
}


//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //info是所选择照片的信息
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    NSLog(@"%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
    //     UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //     [self.imageArray addObject:resultImage];
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.ProtraitBtn setImage:resultImage forState:UIControlStateNormal];;
    oneImgViewData=UIImageJPEGRepresentation(resultImage,0.8);
    oneImgViewData = [oneImgViewData base64EncodedDataWithOptions:0];
    
    //
    //    //如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    //        //裁成边角
    //    }else
    //    {
    //        UIImage *resultImage1 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //        self.twoIMageBtn.image=resultImage1;
    //    }
    //
    
    //    button.layer.cornerRadius = 100;
    //    button.layer.masksToBounds = YES;
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
