//
//  NewsWebViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NewsWebViewController.h"
@interface NewsWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

{
    UIWebView *NewsWebView;
    NSString *urlStr;
    NSString *readStr;
    UIButton *PraiseBtn;
    
    UILabel *titleLabelD;
    UILabel *timeLabelD;
    UILabel *readCountLabel;
    
    
    UIView *separView1;
    UIView *separView2;
    UILabel *labelRa;
}

@end

@implementation NewsWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBackBtn)];
    
    
    NewsWebView = [[UIWebView alloc] init];
    NewsWebView.scalesPageToFit = YES;
    NewsWebView.frame = CGRectMake(16, 0, self.view.bounds.size.width-32, self.view.bounds.size.height);
    NewsWebView.backgroundColor = [UIColor whiteColor];
    NewsWebView.delegate = self;
    NewsWebView.scrollView.delegate = self;
    for (UIView *subView in [NewsWebView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            // 不显示竖直的滚动条
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
        }
    }
    NewsWebView.scrollView.contentInset = UIEdgeInsetsMake(130, 0, 130, 0);
    NewsWebView.scrollView.contentOffset= CGPointMake(0, -260);
    
   
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    
    [self.view addSubview:NewsWebView];
    [NewsWebView loadRequest:requeset];
    
    [self creatUI];
    
}

- (void)getUrlViewWebDetail:(NSString *)pathStr {
    NSMutableDictionary *newsIdMudic = [NSMutableDictionary new];
    [newsIdMudic setObject:self.newsId forKey:@"id"];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [newsIdMudic setObject:userTokenStr forKey:@"userToken"];
    [HttpRequest postPath:pathStr params:newsIdMudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"%@_newsdetails_001>>>>>>%@",responseObject[@"info"][@"userhint"], responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            urlStr = infoDic[@"content"];
            readStr = infoDic[@"userhint"];
            if ([readStr isEqualToString:@"1"]) {
                [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
            }else{
                [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
            }

            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
    

    
    
}



- (void)getUrlWebDetail:(NSString *)pathStr {
    NSMutableDictionary *newsIdMudic = [NSMutableDictionary new];
    [newsIdMudic setObject:self.newsId forKey:@"id"];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [newsIdMudic setObject:userTokenStr forKey:@"userToken"];
    [HttpRequest postPath:pathStr params:newsIdMudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"%@_newsdetails_001>>>>>>%@",responseObject[@"info"][@"userhint"], responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            urlStr = infoDic[@"content"];
            titleLabelD.text =infoDic[@"title"];
            timeLabelD.text =infoDic[@"create_time"];
            
            if ([self.titleStr isEqualToString:@"咨询详情"]) {
                readStr = infoDic[@"userhint"];
                if ([readStr isEqualToString:@"1"]) {
                    [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
                }else{
                    [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
                }
                readCountLabel.text = [NSString stringWithFormat:@"阅读 %@   赞 %@",infoDic[@"read_num"],infoDic[@"praise_num"]];
                NSString *wideStr = [NSString stringWithFormat:@" <head><style>img{width:%fpx !important;}</style></head>", (kScreenW+100)*2];
                urlStr = [wideStr stringByAppendingString:urlStr];

            }
            
            
            NSLog(@"error>>>>%lu", (unsigned long)urlStr.length);
            
            [NewsWebView loadHTMLString:urlStr baseURL:nil];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];

    
}
- (void)creatUI{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"标题";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    titleLabelD = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabelD.numberOfLines = 0;
    titleLabelD.font = [UIFont systemFontOfSize:25];
    titleLabelD.textColor = RGBColor(59, 59, 59);
    [NewsWebView.scrollView addSubview:titleLabelD];
    
    timeLabelD = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabelD.font = [UIFont systemFontOfSize:10];
    timeLabelD.textColor = RGBColor(153, 153, 153);
    [NewsWebView.scrollView addSubview:timeLabelD];
    

    titleLabelD.text =@"达到很好的";
    timeLabelD.text =@"2017 08 08 12:12:12";
    
}


- (void)PraiseBtnClick:(UIButton *)sender{
//    [ConfigModel saveBoolObject:NO forKey:IsLogin];
    NSLog(@"%@888", IsLogin);
    if ([ConfigModel getBoolObjectforKey:IsLogin] ) {
        if ([readStr isEqualToString:@"1"]) {
            NSMutableDictionary *UNPraiseMudic = [NSMutableDictionary new];
            [UNPraiseMudic setObject:self.newsId forKey:@"id"];
            NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
            [UNPraiseMudic setObject:userTokenStr forKey:@"userToken"];
            [HttpRequest postPath:@"_offgoodnews_001" params:UNPraiseMudic resultBlock:^(id responseObject, NSError *error) {
                
                if([error isEqual:[NSNull null]] || error == nil){
                    NSLog(@"success");
                }
                
                NSLog(@"%@----%@_newsdetails_001>>>>>>%@",self.newsId, userTokenStr, responseObject);
                NSDictionary *datadic = responseObject;
                if ([datadic[@"error"] intValue] == 0) {
                    NSDictionary *infoDic = responseObject[@"info"];
                    [ConfigModel mbProgressHUD:@"取消点赞成功" andView:self.view];
                    readStr=@"2";
                    [sender setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
                    
                }else {
                    NSString *info = datadic[@"info"];
                    [ConfigModel mbProgressHUD:info andView:nil];
                }
                NSLog(@"error>>>>%@", error);
            }];
            
        }else{
            NSMutableDictionary *PraiseMudic = [NSMutableDictionary new];
            [PraiseMudic setObject:self.newsId forKey:@"id"];
            NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
            [PraiseMudic setObject:userTokenStr forKey:@"userToken"];
            [HttpRequest postPath:@"_goodnews_001" params:PraiseMudic resultBlock:^(id responseObject, NSError *error) {
                
                if([error isEqual:[NSNull null]] || error == nil){
                    NSLog(@"success");
                }
                
                NSLog(@"%@----%@_newsdetails_001>>>>>>%@",self.newsId, userTokenStr, responseObject);
                NSDictionary *datadic = responseObject;
                if ([datadic[@"error"] intValue] == 0) {
                    NSDictionary *infoDic = responseObject[@"info"];
                    readStr = @"1";
                    [ConfigModel mbProgressHUD:@"点赞成功" andView:self.view];
                    [sender setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
                    
                }else {
                    NSString *info = datadic[@"info"];
                    [ConfigModel mbProgressHUD:info andView:nil];
                }
                NSLog(@"error>>>>%@", error);
            }];
            
        }
 
        return;
    }else{
//        LoginViewController *loginVC = [[LoginViewController alloc ] init];
//
//        [self presentViewController:loginVC animated:YES completion:nil];

        
    }
 
    
   
}




//- (void)viewWillAppear:(BOOL)animated{
////   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
//     [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//
//    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
//   
//}



- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewWillDisappear:(BOOL)animated{
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}


- (void)clickNewsBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
     timeLabelD.frame = CGRectMake(1, -18-30, 150, 10);
     titleLabelD.frame = CGRectMake(-3, -120, kScreenW-40, 60);
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '340%'"];
    
     NSLog(@"%f------", webView.scrollView.contentSize.height);

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f------%f-----%f", scrollView.contentSize.height - scrollView.contentOffset.y+130,scrollView.contentOffset.y,scrollView.frame.size.height);
//    667.000000-------260.000000-----667.000000
//    1776.000000------1239.000000-----667.000000   537
    
//    568.000000-------194.000000-----568.000000
//    1491.000000------1053.000000-----568.000000   438

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