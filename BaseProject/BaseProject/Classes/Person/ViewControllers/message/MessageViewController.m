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
#import "TBRefresh.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *messageArr;
}

@property (nonatomic, strong)  UITableView *messageTable;
@property(assign,nonatomic) int indexPage;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    messageArr = [NSMutableArray new];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//       [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets= NO;
    self.view.backgroundColor = RGBColor(236, 236, 236);
    self.navigationItem.title = @"消息";
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickMessBackBtn)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(cleanAllData)];
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view.
    
    __weak MessageViewController *weakSelf = self;
    [weakSelf.messageTable addRefreshHeaderWithBlock:^{
        _indexPage = 1;
        [weakSelf loadMessageData];
//        [weakSelf.messageTable.header endHeadRefresh];
    }];
    
    [weakSelf.messageTable addRefreshFootWithBlock:^{
        _indexPage++;
        [weakSelf loadMessageData];
//        [weakSelf.messageTable.footer endFooterRefreshing];
    }];
    
    [self.messageTable.header beginRefreshing];
}


-(void) loadMessageData{

    NSMutableDictionary *messageMudic = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [messageMudic setObject:userTokenStr forKey:@"userToken"];
    [messageMudic setObject:[NSString stringWithFormat:@"%d",_indexPage] forKey:@"page"];
    [messageMudic setObject:[NSString stringWithFormat:@"%d",2] forKey:@"size"];
    
    [HttpRequest postPath:@"_information_001" params:messageMudic resultBlock:^(id responseObject, NSError *error) {
        NSDictionary *datadic = responseObject;
        if (_indexPage == 1 ) {
            [self.messageTable.header endHeadRefresh];
             [messageArr removeAllObjects];
        }else{
            [self.messageTable.footer endFooterRefreshing];
        }
        
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            if (infoDic.count == 0) {
                _indexPage--;
                return;
            }
            NSLog(@"222%@", datadic[@"info"]);
            for (NSDictionary *Dic in datadic[@"info"]) {
                if ([messageArr containsObject:Dic]) {
                    return;
                }else{
                    [messageArr addObject:Dic];
                }
            }
            [self.messageTable reloadData];
            

        }else {
            _indexPage--;
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
    }];
    

    
}


//- (void)cleanAllData{
//    
//}


- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}


- (void)initTableView{
    self.messageTable = [[UITableView alloc] initWithFrame:CGRectMake(SizeWidth(5),64, kScreenW -2*SizeWidth(5), kScreenH-64) style:UITableViewStylePlain];
    self.messageTable.delegate = self;
    self.messageTable.dataSource = self;
    self.messageTable.rowHeight = 103;
    self.messageTable.backgroundColor = RGBColor(236, 236, 236);
    self.messageTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.messageTable];
}

- (void)viewWillAppear:(BOOL)animated{
   [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [self getMessageListData];
}


- (void)viewWillDisappear:(BOOL)animated{
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
//    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)getMessageListData{
    NSMutableDictionary *messageMudic = [NSMutableDictionary new];
    [messageMudic setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [HttpRequest postPath:@"_information_001" params:messageMudic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSDictionary *datadic = responseObject;
        NSLog(@"error>%@", datadic);
        if ([datadic[@"error"] intValue] == 0) {
            messageArr = datadic[@"info"];
            [self.messageTable reloadData];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
            
        }
        NSLog(@"error>>>>%@", error);
    }];
    
}

-(void)clickMessBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return messageArr.count;
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
    
    cell.messageTimeLabel.text = messageArr[indexPath.row][@"create_time"];
    cell.messagetitlelabel.text = messageArr[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsWebViewController *newsWeb = [[NewsWebViewController alloc] init];
    newsWeb.messageDetailTime = messageArr[indexPath.row][@"create_time"];
    newsWeb.messageDetailTitle = messageArr[indexPath.row][@"title"];
    newsWeb.messageDetailContent = messageArr[indexPath.row][@"content"];
    newsWeb.titleStr = @"消息详情";
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
