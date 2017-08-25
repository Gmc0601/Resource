//
//  AbandonGoodsViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "AbandonGoodsViewController.h"
#import "MapViewController.h"
#import <Masonry/Masonry.h>

#import "NearbyTableViewCell.h"
@interface AbandonGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,PersonPageTableViewDelegate, UITextFieldDelegate>
{
    UITableView *AbandonTableView;
    UIView *TBheadView;
    UIImageView *headImgView;
    UIImageView *BottomImgView;
    
    UILabel *moneyLabel;
    UITextField *AmountTF;
    UIButton *sureBtn;
    
    UILabel *priceLabel;
    NSMutableArray *GoodsDetailArr;
}
@end

@implementation AbandonGoodsViewController
//392
- (void)viewDidLoad {
    [super viewDidLoad];
    GoodsDetailArr = [NSMutableArray new];
    self.title = self.abandanGoosVCTitleStr;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    [self CreateUI];
    [self getGoodsDetailData];
    AbandonTableView.tableHeaderView = TBheadView;
}



- (void)getGoodsDetailData{
    NSMutableDictionary *GoodsDetailDic = [NSMutableDictionary new];
    [GoodsDetailDic setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [GoodsDetailDic setObject:self.abandanSecondIDStr forKey:@"id"];
    [GoodsDetailDic setObject:[ConfigModel getStringforKey:@"longitudeStr"] forKey:@"long"];
    [GoodsDetailDic setObject:[ConfigModel getStringforKey:@"latitudeStr"] forKey:@"lat"];
    [HttpRequest postPath:@"_gooddetail_001" params:GoodsDetailDic resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSDictionary *datadic = responseObject;
        NSLog(@"error>%@", datadic);
        if ([datadic[@"error"] intValue] == 0) {
            GoodsDetailArr = datadic[@"info"][@"merchantlist"];
            [AbandonTableView reloadData];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
            
        }
        NSLog(@"error>>>>%@", error);
    }];
    
}




- (void)CreateUI{
    TBheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, SizeHeight(392))];
    TBheadView.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    [TBheadView addSubview:topView];
    topView.backgroundColor = UIColorFromHex(0xf1f2f2);
    
    
    BottomImgView = [[UIImageView alloc] init];
    BottomImgView.layer.cornerRadius = 5;
    BottomImgView.layer.masksToBounds = YES;
    BottomImgView.frame = CGRectMake(SizeWidth((kScreenW-SizeWidth(355))/2), SizeHeight(15), SizeWidth(355), SizeHeight(308));
    [TBheadView addSubview:BottomImgView];
    //    BottomImgView.image = [UIImage imageNamed:@"53ccb7628f2cd"];
    BottomImgView.userInteractionEnabled = YES;
    
    headImgView = [[UIImageView alloc] init];
    headImgView.layer.cornerRadius = 5;
    headImgView.layer.masksToBounds = YES;
    headImgView.frame = CGRectMake(-1, 1, SizeWidth(357), SizeHeight(310));
    [BottomImgView addSubview:headImgView];
    headImgView.image = [UIImage imageNamed:@"bg_img_fpxq"];
    headImgView.userInteractionEnabled = YES;
    
    moneyLabel = [[UILabel alloc] init];
    [headImgView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView);
        make.top.equalTo(headImgView).offset(SizeHeight(132));
        make.width.equalTo(headImgView);
        make.height.equalTo(@(SizeHeight(23)));
        
    }];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = @"¥ 0.00";
    moneyLabel.font = [UIFont systemFontOfSize:24];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:moneyLabel.text];
    NSRange range = NSMakeRange(0, 1);
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    moneyLabel.attributedText = attString;
    
    
    
    UILabel *unitLabel = [[UILabel alloc]init];
    [headImgView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.top.equalTo(moneyLabel).offset(SizeHeight(54));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(13)));
        
    }];
    unitLabel.font = [UIFont systemFontOfSize:15];
    //    unitLabel.text = @"单位(kg):";
    unitLabel.text = [NSString stringWithFormat:@"单位(%@):",self.abandanGoodUnitStr ];
    
    AmountTF = [[UITextField alloc] init];
    [headImgView addSubview:AmountTF];
    AmountTF.placeholder = @"请输入废品重量";
    AmountTF.layer.cornerRadius = 2.5;
    AmountTF.layer.borderWidth = 1;
    AmountTF.keyboardType = UIKeyboardTypeDecimalPad;
    [AmountTF setValue:[NSNumber numberWithInt:20] forKey:@"paddingLeft"];
    AmountTF.font = [UIFont systemFontOfSize:14];
    AmountTF.delegate = self;
    AmountTF.layer.borderColor = UIColorFromHex(0xe0e0e0).CGColor;
    [AmountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.top.equalTo(unitLabel).offset(SizeHeight(30));
        make.width.equalTo(@(SizeWidth(249)));
        make.height.equalTo(@(SizeHeight(44)));
        
    }];
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 2.5;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = UIColorFromHex(0x78b4fc);
    [sureBtn addTarget:self action:@selector(calculateMoneyBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    [headImgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headImgView).offset(SizeWidth(-20));
        make.top.equalTo(AmountTF);
        make.width.equalTo(@(SizeWidth(57)));
        make.height.equalTo(@(SizeHeight(44)));
        
    }];
    
    
    
    priceLabel = [[UILabel alloc] init];
    [headImgView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.bottom.equalTo(headImgView).offset(SizeHeight(-20));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(13)));
        
    }];
    //    priceLabel.text = @"单价: 0.80元/kg";
    priceLabel.text = [NSString stringWithFormat:@"单价: %@元/%@",self.abandanGoodPriceStr,self.abandanGoodUnitStr];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:priceLabel.text];
    NSRange priceStrRange = NSMakeRange(4, self.abandanGoodPriceStr.length);
    //    [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:priceStrRange];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:priceStrRange];
    priceLabel.attributedText = priceStr;
    
    UIView *sepaView = [[UIView alloc] init];
    sepaView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [TBheadView addSubview:sepaView];
    sepaView.frame = CGRectMake(0, SizeHeight(339), kScreenW, SizeHeight(10));
    
    
    UIButton *nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nearbyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nearbyBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
    nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nearbyBtn setImageEdgeInsets:UIEdgeInsetsMake(SizeHeight(15), kScreenW-SizeWidth(20), SizeHeight(15), SizeWidth(10))];
    [nearbyBtn setImage:[[UIImage imageNamed:@"icon_gds"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    nearbyBtn.backgroundColor = [UIColor whiteColor];
    nearbyBtn.frame = CGRectMake(0, SizeHeight(349), kScreenW, SizeHeight(42));
    [nearbyBtn setTitle:@"附近的回收点" forState:UIControlStateNormal];
    [nearbyBtn addTarget:self action:@selector(nearby:) forControlEvents:UIControlEventTouchUpInside];;
    [TBheadView addSubview:nearbyBtn];
    
    UIView *seView = [[UIView alloc] init];
    seView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [TBheadView addSubview:seView];
    seView.frame = CGRectMake(0, SizeHeight(391), kScreenW, 1);
}

- (void)nearby:(UIButton *)sender {
    MapViewController *mapVC = [[MapViewController alloc] init];
    mapVC.StoreArr = GoodsDetailArr;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSRange rangeItem = [AmountTF.text rangeOfString:@"."];//判断字符串是否包含
    
    if (rangeItem.location!=NSNotFound){
        if ([string isEqualToString:@"."]) {
            return NO;
        }else{
            //rangeItem.location == 0   说明“.”在第一个位置
            if (range.location>rangeItem.location+2) {
                return NO;
            }
        }
    }else{
        if ([string isEqualToString:@"."]) {
            if (AmountTF.text.length<1) {
                AmountTF.text = @"0.";
                return NO;
            }
            return YES;
        }
        if (range.location>1) {
            return NO;
        }
    }
    
    return YES;
}


- (void)calculateMoneyBtnBtn{
    moneyLabel.text = [NSString stringWithFormat:@"￥ %.2f",[self getSumMoney]];
    NSLog(@"%f", [self getSumMoney]);
    moneyLabel.font = [UIFont systemFontOfSize:24];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:moneyLabel.text];
    NSRange range = NSMakeRange(0, 1);
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    moneyLabel.attributedText = attString;
}

-(float) getSumMoney{
    return [AmountTF.text floatValue] * [self.abandanGoodPriceStr floatValue];
}
- (void)initTableView{
    AbandonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
    AbandonTableView.delegate = self;
    AbandonTableView.dataSource = self;
    [self.view addSubview:AbandonTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 123;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return GoodsDetailArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NearbyTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.personHomePageImage sd_setImageWithURL:[NSURL URLWithString:GoodsDetailArr[indexPath.row][@"good_img"]] placeholderImage:[UIImage imageNamed:@"backGroud"]];
    cell.personHomePagePhone.text = GoodsDetailArr[indexPath.row][@"mobile"];
    cell.personHomePageTitle.text = GoodsDetailArr[indexPath.row][@"good_name"];
    cell.personHomePageAddress.text = GoodsDetailArr[indexPath.row][@"address"];
    cell.personHomePageDistance.text = [NSString stringWithFormat:@"%@ km",GoodsDetailArr[indexPath.row][@"distance"]];
    cell.delegate = self;
    
    return cell;
}

- (void)ClickPersonHomePageBtn:(NSString *)str{
    
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",str];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    
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
