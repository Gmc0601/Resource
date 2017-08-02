//
//  MessageViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"

#import "NewsWebViewController.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *messageTable;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
       [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets= NO;
    self.view.backgroundColor = RGBColor(236, 236, 236);
    self.navigationItem.title = @"消息";
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickMessBackBtn)];
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}


- (void)initTableView{
    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(SizeWidth(5),64, kScreenW -2*SizeWidth(5), kScreenH-64) style:UITableViewStylePlain];
    messageTable.delegate = self;
    messageTable.dataSource = self;
    messageTable.rowHeight = 103;
    messageTable.backgroundColor = RGBColor(236, 236, 236);
    messageTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:messageTable];
}

- (void)viewWillAppear:(BOOL)animated{
 
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewWillDisappear:(BOOL)animated{
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
//    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



-(void)clickMessBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsWebViewController *newsWeb = [[NewsWebViewController alloc] init];
//    newsWeb.newsId =  _NewSArrCount[indexPath.row][@"id"];
    newsWeb.titleStr = @"咨询详情";
    [self.navigationController pushViewController:newsWeb animated:YES];
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
