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
     UIView *separView;
    
    
   
    UIView *separView2;
    UILabel *labelRa;
}

@end

@implementation NewsWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"消息详情";
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
    
   
    
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    
    [self.view addSubview:NewsWebView];
//    [NewsWebView loadRequest:requeset];
    
    [self creatUI];
    
}


- (void)creatUI{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"消息详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    titleLabelD = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabelD.numberOfLines = 0;
    titleLabelD.font = [UIFont systemFontOfSize:25];
    titleLabelD.textColor = RGBColor(59, 59, 59);
    [NewsWebView.scrollView addSubview:titleLabelD];
    
    timeLabelD = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabelD.font = [UIFont systemFontOfSize:12];
    timeLabelD.textColor = RGBColor(153, 153, 153);
    [NewsWebView.scrollView addSubview:timeLabelD];
    
//    separView = [[UIView alloc] initWithFrame:CGRectZero];
//    separView.backgroundColor = [UIColor lightGrayColor];
//    [NewsWebView.scrollView addSubview:separView];

    
    urlStr = self.messageDetailContent;
    titleLabelD.text = self.messageDetailTitle;
    timeLabelD.text = self.messageDetailTime;
    

    NSString *wideStr = [NSString stringWithFormat:@" <head><style>img{width:%fpx !important;}</style></head>", (kScreenW+100)*2];
    urlStr = [wideStr stringByAppendingString:urlStr];
        

    [NewsWebView loadHTMLString:urlStr baseURL:nil];

    
}



- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewWillDisappear:(BOOL)animated{
//    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
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
//    separView.frame = CGRectMake(-16, -129, kScreenW, 1);
     timeLabelD.frame = CGRectMake(1, -18-30, 150, 10);
     titleLabelD.frame = CGRectMake(3, -120, kScreenW-40, 60);
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '340%'"];
    
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
