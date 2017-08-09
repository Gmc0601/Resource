//
//  GoodsListViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsTableViewCell.h"
#import "AbandonGoodsViewController.h"
@interface GoodsListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *GoodsTableView;
    NSArray *ListArr;
}

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ListArr = [NSArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    self.title = self.titleListStr;
    self.view.backgroundColor = RGBColor(237, 239, 239);
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    [self getTableViewData];
    
}

- (void)getTableViewData{
    NSMutableDictionary *GoodsListDic = [NSMutableDictionary new];
    [GoodsListDic setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
//    [GoodsListDic setObject:self.goodListID forKey:@"real_id"];
     [GoodsListDic setObject:@"8" forKey:@"real_id"];
    [HttpRequest postPath:@"_goodlist_001" params:GoodsListDic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSDictionary *datadic = responseObject;
//        NSLog(@"error>%@", datadic);
        if ([datadic[@"error"] intValue] == 0) {
            ListArr = datadic[@"info"];
            [GoodsTableView reloadData];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
            
        }
        NSLog(@"error>>>>%@", error);
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)initTableView{
    GoodsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    GoodsTableView.delegate = self;
    GoodsTableView.dataSource = self;
    [self.view addSubview:GoodsTableView];
}

- (void)clickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MessageCell = @"cell1";
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCell];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.TableViewImg sd_setImageWithURL:[NSURL URLWithString:ListArr[indexPath.row][@"img"]] placeholderImage:[UIImage imageNamed:@""]];
    cell.leftNameLabel.text = ListArr[indexPath.row][@"goodlist"];
    cell.RightPriceLabel.text = [NSString stringWithFormat:@"%@元/%@", ListArr[indexPath.row][@"price"],ListArr[indexPath.row][@"unit"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AbandonGoodsViewController *abandonVC = [[AbandonGoodsViewController alloc] init];
    abandonVC.abandanGoosVCTitleStr = ListArr[indexPath.row][@"goodlist"];
    abandonVC.abandanGoodUnitStr = ListArr[indexPath.row][@"unit"];
    abandonVC.abandanGoodPriceStr = ListArr[indexPath.row][@"price"];
    abandonVC.abandanSecondIDStr = ListArr[indexPath.row][@"id"];
    [self.navigationController pushViewController:abandonVC animated:YES];
    
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
