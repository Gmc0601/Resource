//
//  ProtocolViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ProtocolViewController.h"
#import "ConfigModel.h"
#import "MBProgressHUD.h"
@interface ProtocolViewController ()<UIWebViewDelegate>

{
    UIWebView *DetailWebView;
}


@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册协议";
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     
//     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//       
//       NSForegroundColorAttributeName:RGBColor(0, 0, 0)}];

    
    [self getProtocolURl];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickProtocolBackBtn)];
    
    DetailWebView = [[UIWebView alloc] init];
    DetailWebView.backgroundColor = [UIColor whiteColor];
    DetailWebView.frame = CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.height-64);
    DetailWebView.delegate = self;
    DetailWebView.scalesPageToFit = YES;
    //    [DetailWebView loadHTMLString:URLStr baseURL:nil];
    
//        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//        NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
//       [DetailWebView loadRequest:requeset];
    
    
       [self.view addSubview:DetailWebView];
    
    
    for (UIView *subView in [DetailWebView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            // 不显示竖直的滚动条
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
        }
    }
    
}


- (void)getProtocolURl{
    NSMutableDictionary *protocolDic = [NSMutableDictionary new];
    [protocolDic setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [HttpRequest postPath:@"_useragreement_001" params:protocolDic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSURL *url = [NSURL URLWithString:datadic[@"info"]];
            NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
            [DetailWebView loadRequest:requeset];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
    
}




- (void)clickProtocolBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '340%'"];
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [ConfigModel mbProgressHUD:@"加载失败" andView:self.view];
    [ConfigModel hideHud:self];
    //    [MBProgressHUD hideHUDForView:DetailWebView animated:YES];
    
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
