//
//  AboutUsViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    
    self.titleLab.text = @"关于我们";
    self.rightBar.hidden = YES;
    self.view.backgroundColor = RGBColor(239, 240, 241);
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versonlabel.text = app_Version;
    NSLog(@"%@---%@", app_Name,app_Version);
    
    self.logoImg.frame = CGRectMake((kScreenW- SizeWidth(72))/2, 64+SizeHeight(125), SizeWidth(72), SizeHeight(72));
}
- (void)clickBackBtn{
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
