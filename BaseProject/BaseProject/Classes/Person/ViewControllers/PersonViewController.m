//
//  PersonViewController.m
//  BaseProject
//
//  Created by cc on 2017/7/23.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodsModel.h"
#import "Constants.h"
#import <Masonry/Masonry.h>
#import "NSMutableAttributedString+Category.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"
#import "GoodsCategoryModel.h"
#import "RecycleDetailViewController.h"
#import "IntegalViewController.h"


#import "PersonViewController.h"
#import "NearbyTableViewCell.h"
#import "PagegeCollectionViewCell.h"
#import "GoodsListViewController.h"
#import "CollectionViewController.h"
#import "SettingViewController.h"

#import "fixPhoneViewController.h"
#import "PersonMessageViewController.h"
#import "MessageViewController.h"
@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UITableView *myTableView;
    UIView *headerView;
    UIView *signView;
    UIButton *GoodsBtn;
    UIView *lastView;
}



@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic) UILabel *lblIntegral;
@property(retain,atomic) UILabel *lblName;
@property(retain,atomic) UIImageView *avatar;
@property(retain,atomic) UILabel *lblTelNumber;
@property(retain,atomic) UICollectionView *collectionView;


@property(retain,atomic) UIButton *avatarBtn;
@end

@implementation PersonViewController

NSString *identifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self CreateUI];
    _models = [NSMutableArray arrayWithCapacity:0];
    [self initCollection];
    [self initTableView];

}

- (void)initCollection{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = SizeWidth(5);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(SizeWidth(105), SizeWidth(105));

    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

     flowLayout.sectionInset = UIEdgeInsetsMake(SizeWidth(15), SizeWidth(10), SizeWidth(15), SizeWidth(15));
    
    UICollectionView  *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];

    collectionView.backgroundColor = [UIColor whiteColor];

    collectionView.showsVerticalScrollIndicator = NO;

    collectionView.bounces = NO;

    collectionView.delegate = self;
    collectionView.dataSource = self;

    [collectionView registerClass:[PagegeCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [headerView addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(signView.mas_top).offset(2);
        make.leading.equalTo(headerView.mas_leading).offset(0);
        make.width.equalTo(headerView.mas_width);
        make.height.equalTo(@(SizeHeight(135)));
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [headerView addSubview:bottomView];
    bottomView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(0);
        make.top.equalTo(collectionView.mas_bottom).offset(0);
        make.width.equalTo(headerView.mas_width);
        make.height.equalTo(@(SizeHeight(10)));
    }];
    
    GoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    GoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [GoodsBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
    GoodsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [GoodsBtn setImageEdgeInsets:UIEdgeInsetsMake(SizeHeight(15), kScreenW-SizeWidth(20), SizeHeight(15), SizeWidth(10))];
    [GoodsBtn setImage:[[UIImage imageNamed:@"icon_gds"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    GoodsBtn.backgroundColor = [UIColor whiteColor];
    [GoodsBtn setTitle:@"附近的回收点" forState:UIControlStateNormal];
    [GoodsBtn addTarget:self action:@selector(calculateMoneyBtn) forControlEvents:UIControlEventTouchUpInside];;
    [headerView addSubview:GoodsBtn];
    [GoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(0);
        make.top.equalTo(bottomView.mas_bottom).offset(0);
        make.width.equalTo(bottomView.mas_width);
        make.height.equalTo(@(SizeHeight(42)));
    }];
    
    lastView = [[UIView alloc] init];
    [headerView addSubview:lastView];
    lastView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset((kScreenW-SizeHeight(355))/2);
        make.top.equalTo(GoodsBtn.mas_bottom).offset(0);
        make.width.equalTo(@(SizeHeight(355)));
        make.height.equalTo(@(SizeHeight(1)));
    }];

}
- (void)initTableView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 123;
    myTableView.tableHeaderView = headerView;
    [self.view addSubview:myTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NearbyTableViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

- (void)CreateUI{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,SizeHeight(135)+ SizeHeight(269)+2*SizeHeight(52))];
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, SizeHeight(269))];
    header.image = [UIImage imageNamed:@"bg_grsy"];
    [headerView addSubview:header];
    
    
    UIButton *btnMessage = [[UIButton alloc] init];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
    [btnMessage addTarget:self action:@selector(ClickMessageButton) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnMessage];
    [btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(SizeHeight(25));
        make.leading.equalTo(headerView.mas_leading).offset(SizeWidth(16));
        make.width.equalTo(@(SizeWidth(22)));
        make.height.equalTo(@(SizeHeight(19)));
    }];
    
    
    
    UIButton *btnSetting = [[UIButton alloc] init];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(ClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnSetting];
    [btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(SizeHeight(20));
        make.right.equalTo(headerView.mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(20.4)));
        make.height.equalTo(@(SizeHeight(22)));
    }];
    
    

    UILabel *lblTag  = [[UILabel alloc] init];
    lblTag.text = @"个人";
    lblTag.textColor = [ColorContants red];
    lblTag.textAlignment = NSTextAlignmentCenter;
    lblTag.layer.borderColor = [ColorContants red].CGColor;
    lblTag.layer.borderWidth = 1;
    lblTag.layer.cornerRadius = SizeHeight(7);
    lblTag.font = [UIFont fontWithName:[FontConstrants pingFang] size:11];
    [headerView addSubview:lblTag];
    
    [lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX).offset(40);
        make.bottom.equalTo(header.mas_bottom).offset(SizeWidth(-18));
        make.height.equalTo(@(SizeHeight(14)));
        make.width.equalTo(@(SizeWidth(44)));
        
    }];
    
    _lblTelNumber  = [[UILabel alloc] init];
    _lblTelNumber.text = @"18192061844";
    _lblTelNumber.textAlignment = NSTextAlignmentCenter;
    _lblTelNumber.textColor = [ColorContants phoneNumerFontColor];
    _lblTelNumber.font = [UIFont fontWithName:[FontConstrants helveticaNeue] size:13];
    [headerView addSubview:_lblTelNumber];
    
    [_lblTelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblTag.mas_left).offset(SizeWidth(5));
        make.centerY.equalTo(lblTag.mas_centerY);
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(lblTag.mas_height);
    }];
    
    _lblName  = [[UILabel alloc] init];
    _lblName.text = @"我只是个名字";
    _lblName.textAlignment = NSTextAlignmentCenter;
    _lblName.textColor = [ColorContants userNameFontColor];
    _lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    [headerView addSubview:_lblName];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.bottom.equalTo(_lblTelNumber.mas_top).offset(SizeHeight(-13));
        make.width.equalTo(@(SizeWidth(300)));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    
    _avatarBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_avatarBtn setBackgroundImage:[UIImage imageNamed:@"mrtx144"] forState:UIControlStateNormal];
    [_avatarBtn addTarget:self action:@selector(pushPersonMessBtn) forControlEvents:UIControlEventTouchUpInside];
//    _avatar.image = [UIImage imageNamed:@"mrtx144"];
    [headerView addSubview:_avatarBtn];
    [_avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX).offset(0);
        make.bottom.equalTo(_lblName.mas_top).offset(SizeHeight(-36));
        make.width.equalTo(@(SizeWidth(72)));
        make.height.equalTo(@(SizeHeight(72)));
    }];
    
    
//    _avatar  = [[UIImageView alloc] init];
//    _avatar.image = [UIImage imageNamed:@"mrtx144"];
//    [headerView addSubview:_avatar];
//    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(header.mas_centerX).offset(0);
//        make.bottom.equalTo(_lblName.mas_top).offset(SizeHeight(-36));
//        make.width.equalTo(@(SizeWidth(72)));
//        make.height.equalTo(@(SizeHeight(72)));
//    }];
    
    
    UIView *topView = [[UIView alloc] init];
    [headerView addSubview:topView];
    topView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(0);
        make.top.equalTo(header.mas_bottom).offset(0);
        make.width.equalTo(header.mas_width);
        make.height.equalTo(@(SizeHeight(10)));
    }];
    
    
    UIButton *nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nearbyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nearbyBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
    nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nearbyBtn setImageEdgeInsets:UIEdgeInsetsMake(SizeHeight(15), kScreenW-SizeWidth(20), SizeHeight(15), SizeWidth(10))];
    [nearbyBtn setImage:[[UIImage imageNamed:@"icon_gds"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    nearbyBtn.backgroundColor = [UIColor whiteColor];
//    nearbyBtn.frame = CGRectMake(0, 349, kScreenW, 42);
    [nearbyBtn setTitle:@"回收商品分类" forState:UIControlStateNormal];
    [nearbyBtn addTarget:self action:@selector(getBackGoodsBtn) forControlEvents:UIControlEventTouchUpInside];;
    [headerView addSubview:nearbyBtn];
    [nearbyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(0);
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.width.equalTo(topView.mas_width);
        make.height.equalTo(@(SizeHeight(42)));
    }];
    
    
    signView = [[UIView alloc] init];
    [headerView addSubview:signView];
    signView.backgroundColor = UIColorFromHex(0xf1f2f2);
    [signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset((kScreenW-SizeHeight(355))/2);
        make.top.equalTo(nearbyBtn.mas_bottom).offset(0);
        make.width.equalTo(@(SizeHeight(355)));
        make.height.equalTo(@(SizeHeight(1)));
    }];

    
}


- (void)getBackGoodsBtn{
    
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = SizeWidth(10);
    flowLayout.itemSize = CGSizeMake((kScreenW-4.6*SizeWidth(10))/3, (kScreenW-4.6*SizeWidth(10))/3);
    flowLayout.sectionInset = UIEdgeInsetsMake(SizeWidth(10), SizeWidth(10), SizeWidth(10), SizeWidth(10));

    CollectionViewController *collectVC = [[CollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    [self.navigationController pushViewController:collectVC animated:YES];
}



- (void)calculateMoneyBtn{
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


-(void)  showCallView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打平台电话"
                                                    message:@"400-800-1234"
                                                   delegate:nil
                                          cancelButtonTitle:@"拨打"
                                          otherButtonTitles:@"取消",nil];
    
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",@"13377892977"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

#pragma UICollection Delegate

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}
//
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PagegeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListViewController *newViewController = [[GoodsListViewController alloc] init];
    [self.navigationController pushViewController:newViewController animated:YES];
}


//-(void) setCell:(UICollectionViewCell *)cell withMode:(GoodsModel *)model{
//    int tag = 1001;
//    //    cell.backgroundView = [UIImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
//    cell.backgroundColor = [UIColor blueColor];
//    UILabel *lblName = [cell viewWithTag:tag];
//    
//    cell.layer.cornerRadius = SizeHeight(5);
//    
//    if (lblName == nil) {
//        lblName = [[UILabel alloc] init];
//        lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
//        lblName.textColor = [ColorContants whiteFontColor];
//        lblName.textAlignment = NSTextAlignmentCenter;
//        lblName.tag = tag;
//        [cell addSubview:lblName];
//        
//        [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
//            CGFloat height = SizeHeight(15);
//            make.width.equalTo(cell.mas_width);
//            make.height.equalTo(@(height));
//            make.centerY.equalTo(cell.mas_centerY);
//            make.left.equalTo(cell.mas_left);
//        }];
//    }
//    
//    lblName.text = model.name;
//}



- (void)pushPersonMessBtn{
    
    PersonMessageViewController *personMessVC = [[PersonMessageViewController alloc ] init];
    [self.navigationController pushViewController:personMessVC animated:YES];
}




-(void) addGoodsList{
    
}

-(void) ClickMessageButton{
    MessageViewController *personMessVC = [[MessageViewController alloc ] init];
    [self.navigationController pushViewController:personMessVC animated:YES];
//    fixPhoneViewController *fixVC = [[fixPhoneViewController alloc ] init];
//    [self.navigationController pushViewController:fixVC animated:YES];
}

-(void) ClickSettingButton{
    SettingViewController  *setVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void) tapCheckButton{
    
}


@end
