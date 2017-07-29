//
//  AbandonGoodsViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "AbandonGoodsViewController.h"
#import <Masonry/Masonry.h>

#import "NearbyTableViewCell.h"
@interface AbandonGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *AbandonTableView;
    UIView *TBheadView;
    UIImageView *headImgView;
    UIImageView *BottomImgView;
    
    UILabel *moneyLabel;
    UITextField *AmountTF;
    UIButton *sureBtn;
    
    UILabel *priceLabel;
}
@end

@implementation AbandonGoodsViewController
//392
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"废报纸";
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    // Do any additional setup after loading the view.

    [self initTableView];
    [self CreateUI];
     AbandonTableView.tableHeaderView = TBheadView;
}


- (void)CreateUI{
    TBheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 392)];
    TBheadView.backgroundColor = [UIColor whiteColor];
    
    BottomImgView = [[UIImageView alloc] init];
    BottomImgView.layer.cornerRadius = 5;
    BottomImgView.layer.masksToBounds = YES;
    BottomImgView.frame = CGRectMake((kScreenW-355)/2, 15, 355, 308);
    [TBheadView addSubview:BottomImgView];
    BottomImgView.image = [UIImage imageNamed:@"53ccb7628f2cd"];
    BottomImgView.userInteractionEnabled = YES;
    
    headImgView = [[UIImageView alloc] init];
    headImgView.layer.cornerRadius = 5;
    headImgView.layer.masksToBounds = YES;
    headImgView.frame = CGRectMake(-1, 1, 357, 310);
    [BottomImgView addSubview:headImgView];
    headImgView.image = [UIImage imageNamed:@"圆角矩形-11-拷贝"];
    headImgView.userInteractionEnabled = YES;
    
    moneyLabel = [[UILabel alloc] init];
    [headImgView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView);
        make.top.equalTo(headImgView).offset(132);
        make.width.equalTo(headImgView);
        make.height.equalTo(@20);
        
    }];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = @"¥ 8.88";
    moneyLabel.font = [UIFont systemFontOfSize:24];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:moneyLabel.text];
    NSRange range = NSMakeRange(0, 1);
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    moneyLabel.attributedText = attString;
    
    
    
    UILabel *unitLabel = [[UILabel alloc]init];
    [headImgView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(20);
        make.top.equalTo(moneyLabel).offset(54);
        make.width.equalTo(@100);
        make.height.equalTo(@13);
        
    }];
    unitLabel.font = [UIFont systemFontOfSize:15];
    unitLabel.text = @"重量(kg):";
    
    
    AmountTF = [[UITextField alloc] init];
    [headImgView addSubview:AmountTF];
    AmountTF.placeholder = @"请输入废纸重量";
    AmountTF.layer.cornerRadius = 2.5;
    AmountTF.layer.borderWidth = 1;
    AmountTF.font = [UIFont systemFontOfSize:14];
    AmountTF.layer.borderColor = UIColorFromHex(0xe0e0e0).CGColor;
    [AmountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(20);
        make.top.equalTo(unitLabel).offset(30);
        make.width.equalTo(@249);
        make.height.equalTo(@44);
        
    }];
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 2.5;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = UIColorFromHex(0x78b4fc);
    [sureBtn addTarget:self action:@selector(calculateMoneyBtn) forControlEvents:UIControlEventTouchUpInside];
    [headImgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headImgView).offset(-20);
        make.top.equalTo(AmountTF);
        make.width.equalTo(@57);
        make.height.equalTo(@44);
        
    }];
    
    
    
    priceLabel = [[UILabel alloc] init];
    [headImgView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(20);
        make.bottom.equalTo(headImgView).offset(-20);
        make.width.equalTo(@200);
        make.height.equalTo(@13);
        
    }];
    priceLabel.text = @"单价: 0.80元/kg";
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:priceLabel.text];
    NSRange priceStrRange = NSMakeRange(4, 4);
//    [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:priceStrRange];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:priceStrRange];
    priceLabel.attributedText = priceStr;
    
    UIView *sepaView = [[UIView alloc] init];
    sepaView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [TBheadView addSubview:sepaView];
    sepaView.frame = CGRectMake(0, 339, kScreenW, 10);
    
    
    UIButton *nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nearbyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nearbyBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
    nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nearbyBtn setImageEdgeInsets:UIEdgeInsetsMake(15, kScreenW-20, 15, 10)];
    [nearbyBtn setImage:[[UIImage imageNamed:@"icon_gds"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    nearbyBtn.backgroundColor = [UIColor whiteColor];
    nearbyBtn.frame = CGRectMake(0, 349, kScreenW, 42);
    [nearbyBtn setTitle:@"附近的回收点" forState:UIControlStateNormal];
    [nearbyBtn addTarget:self action:@selector(calculateMoneyBtn) forControlEvents:UIControlEventTouchUpInside];;
    [TBheadView addSubview:nearbyBtn];
    
    UIView *seView = [[UIView alloc] init];
    seView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [TBheadView addSubview:seView];
    seView.frame = CGRectMake(0, 391, kScreenW, 1);
}


- (void)calculateMoneyBtn{
    
}

- (void)initTableView{
    AbandonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    AbandonTableView.delegate = self;
    AbandonTableView.dataSource = self;
    [self.view addSubview:AbandonTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 123;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NearbyTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
