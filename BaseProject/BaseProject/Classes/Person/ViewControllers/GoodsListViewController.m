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
}

@end

@implementation GoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    self.title = @"废纸";
    self.view.backgroundColor = RGBColor(237, 239, 239);
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    // Do any additional setup after loading the view.
    
    [self initTableView];
}

- (void)initTableView{
    GoodsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH) style:UITableViewStylePlain];
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
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MessageCell = @"cell1";
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCell];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AbandonGoodsViewController *abandonVC = [[AbandonGoodsViewController alloc] init];
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
