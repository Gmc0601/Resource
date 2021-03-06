//
//  RecycleDetailViewController.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "RecycleDetailViewController.h"
#import <Masonry/Masonry.h>
#import "PublicClass.h"
#import "NSMutableAttributedString+Category.h"
#import "NearbyTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface RecycleDetailViewController ()<UITextFieldDelegate>
{
    UIView *TBheadView;
    UIImageView *headImgView;
    UIImageView *BottomImgView;
    
    UILabel *moneyLabel;
    UITextField *AmountTF;
    UIButton *sureBtn;
    UILabel *unitLabel;
    UILabel *priceLabel;
    NSString *telNum;
    NSString *weight;
}
@property(retain,nonatomic) GoodsModel *model;
@end

@implementation RecycleDetailViewController

@synthesize goodsId = _goodsId;
-(void) setGoodsId:(NSString *)goodsId{
    _goodsId = goodsId;
    [self loadData];
}

-(void) setModel:(GoodsModel *)model{
    _model = model;
    self.title = model.name;
//    [BottomImgView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
//    moneyLabel.text = [NSString stringWithFormat:@"￥%.2f", _model.price];
    if (_model.unit != nil) {
        unitLabel.text = [NSString stringWithFormat:@"单位(%@):",_model.unit];
        priceLabel.text = [NSString stringWithFormat:@"单位:%.2f元/%@",_model.price,_model.unit];
        [self setAttributeString];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    self.view.backgroundColor = RGBColor(237, 239, 239);
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    
    
    [self CreateUI];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self getTelNum];
}

- (void)clickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    BottomImgView.image = [UIImage imageNamed:@""];
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
        make.height.equalTo(@(SizeHeight(20)));
        
    }];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = @"¥ 0.00";
    moneyLabel.font = [UIFont systemFontOfSize:24];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:moneyLabel.text];
    NSRange range = NSMakeRange(0, 1);
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    moneyLabel.attributedText = attString;
    
    
    unitLabel = [[UILabel alloc]init];
    [headImgView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImgView).offset(SizeWidth(20));
        make.top.equalTo(moneyLabel).offset(SizeHeight(54));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(13)));
        
    }];
    unitLabel.font = [UIFont systemFontOfSize:15];
    unitLabel.text = @"单位(kg):";
    
    AmountTF = [[UITextField alloc] init];
    [headImgView addSubview:AmountTF];
    AmountTF.placeholder = @"请输入废纸重量";
    AmountTF.layer.cornerRadius = 2.5;
    AmountTF.layer.borderWidth = 1;
    AmountTF.font = [UIFont systemFontOfSize:14];
    AmountTF.keyboardType = UIKeyboardTypeDecimalPad;
    AmountTF.delegate = self;
    AmountTF.layer.borderColor = UIColorFromHex(0xe0e0e0).CGColor;
    
    CGRect frame = [AmountTF frame];
    frame.size.width=SizeWidth(10);
    [AmountTF setLeftView:[[UIView alloc]initWithFrame:frame]];
    [AmountTF setLeftViewMode:UITextFieldViewModeAlways];

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
    [sureBtn addTarget:self action:@selector(calculateMoneyBtn) forControlEvents:UIControlEventTouchUpInside];
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
    priceLabel.text = @"单价: 0.80元/kg";
    
    [self.view addSubview:TBheadView];
}

-(void) setAttributeString{
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:priceLabel.text];
    NSRange priceStrRange = NSMakeRange(3, priceLabel.text.length - 6);
    //    [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:priceStrRange];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:priceStrRange];

    priceLabel.attributedText = priceStr;
}


- (void)calculateMoneyBtn{
    moneyLabel.text = [NSString stringWithFormat:@"￥ %.2f",[self getSumMoney]];
}

-(void) showCallView{
    [PublicClass showCallPopupWithTelNo:telNum withWeight:weight inViewController:self];
}

-(CGFloat) getSumMoney{
    return (roundf(AmountTF.text.floatValue * _model.price * 100))/100;
}

-(void) loadData{
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    [params setObject:self.goodsId forKey:@"id"];
    
    [HttpRequest postPath:@"_gooddetail_001" params:params resultBlock:^(id responseObject, NSError *error) {
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            
            NSDictionary *goods = infoDic[@"good"];
            GoodsModel *model = [GoodsModel new];
            model._id = goods[@"real_id"];
            model.name = goods[@"goodlist"];
            model.imgUrl = goods[@"img"];
            model.price = ((NSString *)goods[@"price"]).floatValue;
            model.unit = goods[@"unit"];
            
            [self setModel:model];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
    }];
}

-(void) getTelNum{
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    
    [HttpRequest postPath:@"_setinfo_001" params:params resultBlock:^(id responseObject, NSError *error) {
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            telNum = infoDic[@"phone"];
            weight = infoDic[@"number"];
            [PublicClass addCallButtonInViewContrller:self];
        }
        NSLog(@"error>>>>%@", error);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
    [futureString insertString:string atIndex:range.location];
    
    NSInteger flag = 0;
    // 这个可以自定义,保留到小数点后两位,后几位都可以
    const NSInteger limited = 2;
    
    for (NSInteger i = futureString.length - 1; i >= 0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            // 如果大于了限制的就提示
            if (flag > limited) {
                [ConfigModel mbProgressHUD:@"输入金额请控制在小数点后两位" andView:self.view];
                return NO;
            }
            
            break;
        }
        
        flag++;
    }
    
    return YES;
}
@end
