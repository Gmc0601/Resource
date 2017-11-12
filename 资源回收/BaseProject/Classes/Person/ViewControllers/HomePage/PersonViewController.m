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

#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,PersonPageTableViewDelegate,UIScrollViewDelegate>
{
    UITableView *myTableView;
    UICollectionView  *collectionView;
    UIView *headerView;
    UIView *signView;
    UIButton *GoodsBtn;
    UIView *lastView;
    
    UIImage * imgP;
    
    CLLocationManager *locationManager;
//    NSString *currentCity;
    NSString *Strlatitude;
    NSString *Strlongitude;
    CLLocation *currentLocation;
    
    
    NSMutableArray *GoodsArr;
    NSMutableArray *potsArr;
    NSMutableArray *allPersonArr;
}



@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic) UILabel *lblIntegral;
@property(retain,atomic) UILabel *lblName;
@property(retain,atomic) UIImageView *avatar;
@property(retain,atomic) UILabel *lblTelNumber;
@property(retain,atomic) UICollectionView *collectionView;

@property (retain, nonatomic) UIView *headView;

@property (nonatomic, retain) UIButton *leftBtn;

@property (nonatomic, retain) UIButton *rightBtn;


@property(retain,atomic) UIButton *avatarBtn;
@end

@implementation PersonViewController

NSString *identifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    GoodsArr = [NSMutableArray new];
    potsArr = [NSMutableArray new];
    allPersonArr = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self locatemap];
    [self CreateUI];
    _models = [NSMutableArray arrayWithCapacity:0];
    [self initCollection];
    [self initTableView];
    
//   [self getPersonHomeData];

}

- (void)locatemap{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 500.0;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0) {
            [locationManager requestWhenInUseAuthorization];
        }else{
            [locationManager startUpdatingLocation];
        }
    }
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        NSLog(@"授权成功");
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"授权失败");
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"222请打开定位按钮");
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    currentLocation  = [locations lastObject];
    Strlongitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    Strlatitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    NSLog(@"%f---%f", currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [ConfigModel saveString:Strlongitude forKey:@"longitudeStr"];
    [ConfigModel saveString:Strlatitude forKey:@"latitudeStr"];
    
    [self getPersonHomeData];
   
}


- (void)initCollection{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = SizeWidth(5);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(SizeWidth(105), SizeWidth(105));

    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

     flowLayout.sectionInset = UIEdgeInsetsMake(SizeWidth(15), SizeWidth(10), SizeWidth(15), SizeWidth(15));
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];

    collectionView.backgroundColor = [UIColor whiteColor];

    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
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
    [GoodsBtn addTarget:self action:@selector(calculateBtn) forControlEvents:UIControlEventTouchUpInside];;
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

- (void)getAllPersonHomeData{
    NSMutableDictionary *AllpersonDIc = [NSMutableDictionary new];
    [AllpersonDIc setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [HttpRequest postPath:@"_allgood_001" params:AllpersonDIc resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSDictionary *datadic = responseObject;
      
        NSLog(@"login>>%@",datadic);
        
        if ([datadic[@"error"] intValue] == 0) {
            
            allPersonArr = datadic[@"info"];
           
            
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
            
        }
        NSLog(@"error>>>>%@", error);
    }];
}

-(void)getPersonHomeData{
    NSMutableDictionary *personDIc = [NSMutableDictionary new];
//     NSLog(@"%@---%@", Strlongitude,Strlatitude);
//    [personDIc setObject:[ConfigModel getStringforKey:UserToken] forKey:@"userToken"];
    [personDIc setObject:Strlongitude forKey:@"long"];
    [personDIc setObject:Strlatitude forKey:@"lat"];
    [HttpRequest postPath:@"_homepage_001" params:personDIc resultBlock:^(id responseObject, NSError *error) {
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"999%@", responseObject);
        NSDictionary *datadic = responseObject;
//         NSArray *gosssArr = datadic[@"info"][@"goodlist"];
//        NSLog(@"%lulogin>>%@", (unsigned long)gosssArr.count,gosssArr);

        if ([datadic[@"error"] intValue] == 0) {

            GoodsArr = datadic[@"info"][@"goodlist"];
            potsArr = datadic[@"info"][@"merchantlist"];
            NSDictionary *dic = datadic[@"info"][@"userinfo"];
            NSString *nickname = dic[@"nickname"];
            NSString *headImage = dic[@"avatar_url"];
            
            [ConfigModel saveString:nickname forKey:NickName];
            [ConfigModel saveString:headImage forKey:HeadImage];
            _lblName.text = nickname;
            
            dispatch_queue_t xrQueue = dispatch_queue_create("loadImae", NULL); // 创建GCD线程队列
            dispatch_async(xrQueue, ^{
                // 异步下载图片
                imgP = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headImage]]];
                // 主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (imgP) {
                        [_avatarBtn setImage:imgP forState:UIControlStateNormal];
                    }else{
                        [_avatarBtn setImage:[UIImage imageNamed:@"mrtx144"] forState:UIControlStateNormal];
                    }
                    
                });
                
                
                
            });
            
            [myTableView reloadData];
            [collectionView reloadData];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];

        }
        NSLog(@"error>>>>%@", error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return potsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NearbyTableViewCell" owner:self options:nil] lastObject];
    }
   [cell.personHomePageImage sd_setImageWithURL:[NSURL URLWithString: potsArr[indexPath.row][@"good_img"]]placeholderImage:[UIImage imageNamed:@"backGroud"]];
    cell.personHomePagePhone.text = potsArr[indexPath.row][@"mobile"];
    cell.personHomePageTitle.text = potsArr[indexPath.row][@"good_name"];
    cell.personHomePageAddress.text = potsArr[indexPath.row][@"address"];
    cell.personHomePageDistance.text = [NSString stringWithFormat:@"%@ km",potsArr[indexPath.row][@"distance"]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)CreateUI{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,SizeHeight(135)+ SizeHeight(269)+2*SizeHeight(52))];
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, SizeHeight(269))];
    header.image = [UIImage imageNamed:@"bg_grsy"];
    [headerView addSubview:header];
    
    
    UIButton *btnMessage = [[UIButton alloc] init];
//    [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
     [btnMessage setImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
    [btnMessage addTarget:self action:@selector(ClickMessageButton) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnMessage];
    [btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(SizeHeight(30));
        make.leading.equalTo(headerView.mas_leading).offset(SizeWidth(16));
        make.width.equalTo(@(SizeWidth(32)));
        make.height.equalTo(@(SizeHeight(29)));
    }];
     [btnMessage setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    
    
    UIButton *btnSetting = [[UIButton alloc] init];
     [btnSetting setImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
//    [btnSetting setBackgroundImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(ClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnSetting];
    [btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(SizeHeight(25));
        make.right.equalTo(headerView.mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(30.4)));
        make.height.equalTo(@(SizeHeight(32)));
    }];
    [btnSetting setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    

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
        make.centerX.equalTo(header.mas_centerX).offset(50);
        make.bottom.equalTo(header.mas_bottom).offset(SizeWidth(-18));
        make.height.equalTo(@(SizeHeight(16)));
        make.width.equalTo(@(SizeWidth(44)));
        
    }];
    
    _lblTelNumber  = [[UILabel alloc] init];
//    _lblTelNumber.text = @"18192061844";
    _lblTelNumber.textAlignment = NSTextAlignmentLeft;
    _lblTelNumber.textColor = [ColorContants phoneNumerFontColor];
    _lblTelNumber.font = [UIFont fontWithName:[FontConstrants helveticaNeue] size:13];
    [headerView addSubview:_lblTelNumber];
    
    [_lblTelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblTag.mas_left).offset(SizeWidth(5));
        make.centerY.equalTo(lblTag.mas_centerY);
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(lblTag.mas_height);
    }];
    
//    _lblTelNumber.text = [ConfigModel getStringforKey:@"PersonPhone"];
    
    
    _lblName  = [[UILabel alloc] init];
//    _lblName.text = @"我只是个名字";
    _lblName.textAlignment = NSTextAlignmentCenter;
    _lblName.textColor = [ColorContants userNameFontColor];
    _lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    [headerView addSubview:_lblName];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.bottom.equalTo(_lblTelNumber.mas_top).offset(SizeHeight(-13));
        make.width.equalTo(@(SizeWidth(300)));
        make.height.equalTo(@(SizeHeight(18)));
    }];
//     _lblName.text = [ConfigModel getStringforKey:@"PersonNickName"];
    
    _avatarBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.cornerRadius = SizeWidth(72)/2;
    [_avatarBtn setBackgroundImage:[UIImage imageNamed:@"mrtx144"] forState:UIControlStateNormal];
    [_avatarBtn addTarget:self action:@selector(pushPersonMessBtn) forControlEvents:UIControlEventTouchUpInside];
//    _avatar.image = [UIImage imageNamed:@"mrtx144"];
    [headerView addSubview:_avatarBtn];
    [_avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX).offset(0);
        make.bottom.equalTo(_lblName.mas_top).offset(SizeHeight(-36));
        make.width.equalTo(@(SizeWidth(72)));
        make.height.equalTo(@(SizeWidth(72)));
    }];

    
    
//    [_avatarBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[ConfigModel getStringforKey:@"PersonPortrait"]]]] forState:UIControlStateNormal];
    
    
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
    collectVC.goodsTypeArr = allPersonArr;
    [self.navigationController pushViewController:collectVC animated:YES];
}



- (void)calculateBtn{
    MapViewController *mapVC = [[MapViewController alloc] init];
    mapVC.StoreArr = potsArr;
    [self.navigationController pushViewController:mapVC animated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self getAllPersonHomeData];
//    [self getPersonHomeData];
    _lblTelNumber.text = [ConfigModel getStringforKey:@"PersonPhone"];
//     _lblTelNumber.text = self.phoneStr;
     _lblName.text = [ConfigModel getStringforKey:@"PersonNickName"];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImae", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        // 异步下载图片
        imgP = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[ConfigModel getStringforKey:@"PersonPortrait"]]]];
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (imgP) {
                [_avatarBtn setImage:imgP forState:UIControlStateNormal];
            }else{
                [_avatarBtn setImage:[UIImage imageNamed:@"mrtx144"] forState:UIControlStateNormal];
            }
            
        });
        
        
        
    });
}





-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
     [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


- (void)ClickPersonHomePageBtn:(NSString *)str{

    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",str];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    
}


#pragma UICollection Delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return GoodsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PagegeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imaView sd_setImageWithURL:[NSURL URLWithString:GoodsArr[indexPath.item][@"img"]]];
    cell.titleLabel.text = GoodsArr[indexPath.item][@"good"];
    return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListViewController *newViewController = [[GoodsListViewController alloc] init];
    newViewController.titleListStr = GoodsArr[indexPath.item][@"good"];
    newViewController.goodListID = GoodsArr[indexPath.item][@"id"];
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
    personMessVC.protraitImage = imgP;
    [self.navigationController pushViewController:personMessVC animated:YES];
}




-(void) addGoodsList{
    
}

-(void) ClickMessageButton{
    MessageViewController *personMessVC = [[MessageViewController alloc ] init];
    [self.navigationController pushViewController:personMessVC animated:YES];

}

-(void) ClickSettingButton{
    SettingViewController  *setVC = [[SettingViewController alloc] init];
    setVC.from = Person_Setting;
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void) tapCheckButton{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y >200) {
        
        self.headView.alpha = 1;
        
    }else{
        
        if (scrollView.contentOffset.y >100) {
            [self.view addSubview:self.headView];
            self.headView.alpha = (scrollView.contentOffset.y - 100)/100;
            [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
        }else {
            [self.headView removeFromSuperview];
            [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
        }
       
    }
    
    
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:FRAME(0, 0, kScreenW, 64)];
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:self.leftBtn];
        [_headView addSubview:self.rightBtn];
        
    }
    return _headView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:FRAME(SizeWidth(10), SizeHeight(20), SizeWidth(30), SizeHeight(30))];
        [_leftBtn setImage:[UIImage imageNamed:@"icon_tab_zxh"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(ClickMessageButton) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.backgroundColor = [UIColor clearColor];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:FRAME(kScreenW - SizeWidth(40), SizeHeight(20), SizeWidth(30), SizeHeight(30))];
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn setImage:[UIImage imageNamed:@"grzx_icon_szh"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(ClickSettingButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

@end
