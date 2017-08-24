//
//  MapViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/2.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "ZAnnotation.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

@interface MapViewController ()<MAMapViewDelegate,CLLocationManagerDelegate, AMapLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSString *currentCity;
    double Strlatitude;
    double Strlongitude;
    CLLocation *currentLocation;
    
    MAMapView *_mapView;
    ZAnnotation *_zAnnotation;
    NSMutableArray *pointArr;
    NSString *phoneNum;
}

@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, retain) AMapLocationManager *locationManager;
@property (nonatomic, assign) BOOL showTraffic;

@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabe;

@property(nonatomic,strong)UILabel *threetitleLabel;
@property(nonatomic,strong)UILabel *fourtitleLabel;

@property (nonatomic, strong) UIImageView *portraitView;
@property(nonatomic,strong)UIImageView *rightimageView;

@property (nonatomic, strong) UIButton *phoneBtn;


@end

@implementation MapViewController

- (void)viewDidLoad {
     pointArr = [NSMutableArray array];
    self.titleLab.text = @"地图";
    self.rightBar.hidden = YES;
    
    //  t
    
    Strlatitude = [[ConfigModel getStringforKey:@"latitudeStr"] doubleValue];
    Strlongitude = [[ConfigModel getStringforKey:@"longitudeStr"] doubleValue];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickMapBackBtn)];
    

    [super viewDidLoad];
    //     self.view.backgroundColor = [UIColor redColor];
    
     [AMapServices sharedServices].enableHTTPS = YES;
    //配置用户Key//2790ab5b9b214a0454170cbc87e32353
    [AMapServices sharedServices].apiKey = @"62a60fd50cc1f6ea510f32a8c7f415df";
    //初始化高德地图对象
    _mapView = [[MAMapView alloc] initWithFrame:FRAME(0, 64, kScreenW, kScreenH - 64)];
    _mapView.delegate = self;
    //    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
//    Strlatitude, Strlongitude
//    30.181756, 120.153775
    self.mapView.showsUserLocation = YES;
    [self.mapView setZoomLevel:11 animated:YES];
    self.mapView.showsCompass = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.mapView.delegate= self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout = 2;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 2;
//    _mapView.centerCoordinate =CLLocationCoordinate2DMake(30.181756, 120.153775);
    [_mapView selectAnnotation:_zAnnotation animated:YES];
    
    [self.view addSubview:_mapView];

    _mapView.userInteractionEnabled=YES;

    //  添加固定View；
    [self createView];
    
    [self setPoints];
    
    
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
    }
}
- (void)createView {
    
    UIView *backView = [[UIView alloc] initWithFrame:FRAME(kScreenW/2 - SizeWidth(150), kScreenH - SizeHeight(140), SizeWidth(300), SizeHeight(120))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    self.portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 80, 80)];
    self.portraitView.layer.cornerRadius=8;
    self.portraitView.clipsToBounds=YES;
    self.portraitView.userInteractionEnabled=YES;
    self.portraitView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:self.portraitView];
    
    self.rightimageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 10, 20, 20)];
    self.rightimageView.clipsToBounds=YES;
    self.rightimageView.layer.cornerRadius=2;
    self.rightimageView.userInteractionEnabled=YES;
//    self.rightimageView.backgroundColor = [UIColor redColor];
    self.rightimageView.image = [UIImage imageNamed:@"icon_nav_dh"];
    [backView addSubview:self.rightimageView];
    
    // 添加标题，即商户名
    self.titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(120 , 40, 170, 50)];
    self.titleLabe.font = [UIFont systemFontOfSize:12];
    self.titleLabe.numberOfLines = 0;
    
    //    self.titleLabel.backgroundColor = [UIColor redColor];
    [backView addSubview:self.titleLabe];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 95, 90, 20)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    //    self.subtitleLabel.backgroundColor = [UIColor greenColor];
    [backView addSubview:self.subtitleLabel];
    
    
    self.threetitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 95, 80, 20)];
    self.threetitleLabel.font=[UIFont systemFontOfSize:10];
    self.threetitleLabel.textAlignment = NSTextAlignmentCenter;
    //    self.threetitleLabel.backgroundColor = [UIColor greenColor];
    [backView addSubview:self.threetitleLabel];
    
    
    self.fourtitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 150, 20)];
    //    self.fourtitleLabel.backgroundColor=[UIColor greenColor];
    self.fourtitleLabel.font=[UIFont systemFontOfSize:12];
    [backView addSubview:self.fourtitleLabel];
    
    UIImageView *addImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 57, 13, 17)];
    [backView addSubview:addImg];
    
    addImg.image =  [UIImage imageNamed:@"fpxq_icon_dw"];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 95, 13, 18)];
    [backView addSubview:phoneImg];
    phoneImg.image =  [UIImage imageNamed:@"fpxq_icon_sj"];
    
    UIButton *call = [[UIButton alloc] initWithFrame:FRAME(0, 0, SizeWidth(300), SizeHeight(120))];
    call.backgroundColor = [UIColor clearColor];
    [call addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:call];
    
}

- (void)callPhone:(UIButton *)sender {
    NSMutableString *str  =[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
}

// 添加数据 
- (void)setPoints{
    for (int i  = 0; i <self.StoreArr.count ; i++) {
        if (i == 0) {
            [self.portraitView sd_setImageWithURL:[NSURL URLWithString:self.StoreArr[i][@"good_img"]] placeholderImage:nil];
            self.threetitleLabel.text = [NSString stringWithFormat:@"距你%@km",self.StoreArr[i][@"distance"]];
            self.fourtitleLabel.text = self.StoreArr[i][@"good_name"];
            self.titleLabe.text = self.StoreArr[i][@"address"];
            self.subtitleLabel.text = self.StoreArr[i][@"mobile"];
            phoneNum = self.StoreArr[i][@"mobile"];
        }
        _zAnnotation = [[ZAnnotation alloc] init];
        _zAnnotation.coordinate = CLLocationCoordinate2DMake([self.StoreArr[i][@"lat"]  doubleValue], [self.StoreArr[i][@"long"]  doubleValue]);
        
        [_zAnnotation setTitle:self.StoreArr[i][@"address"]];
        [_zAnnotation setSubtitle:self.StoreArr[i][@"mobile"]];
        [_zAnnotation setThreetitle:[NSString stringWithFormat:@"距你%@km",self.StoreArr[i][@"distance"]]];
        [_zAnnotation setFourtitle:self.StoreArr[i][@"good_name"]];
        
        [_zAnnotation setLeftImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.StoreArr[i][@"good_img"]]]]];
        
        [pointArr addObject:_zAnnotation];
        
        //显示气泡
        [_mapView selectAnnotation:_zAnnotation animated:NO];
    }
    
    
    
    [_mapView addAnnotations:pointArr];
}


- (void)clickMapBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationItem.title = @"地图";
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
#pragma mark 4.标注自定义
    [super viewDidAppear:animated];
    
    
}



//实现 MAMapViewDelegate 的 mapView:viewForAnnotation:函数,设置标注样式。
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    // 返回nil,意味着交给系统处理
    if ([annotation isKindOfClass:[ZAnnotation class]])
    {
        
        // 创建大头针控件
        static NSString *ID = @"deal";
        CustomAnnotationView *annoView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (annoView == nil) {
            annoView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
            annoView.userInteractionEnabled=YES;
            annoView.canShowCallout = NO;
            annoView.clickBlock = ^(ZAnnotation *model) {
                NSLog(@".....%@", model);
//                [self.portraitView sd_setImageWithURL:[NSURL URLWithString:model.l] placeholderImage:nil];
                self.portraitView.image = model.leftImage;
                self.threetitleLabel.text = model.threetitle;
                self.fourtitleLabel.text = model.fourtitle;
                self.titleLabe.text = model.title;
                phoneNum = model.subtitle;
                NSLog(@"...%@", model.title);
                self.subtitleLabel.text = model.subtitle;
            };
            //添加标题的左视图  视图为： button
//            UIButton *rightbutton=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
//            [rightbutton setTitle:@"右" forState:(UIControlStateNormal)];
//            rightbutton.frame=CGRectMake(0, 0, 25, 25);
//            [rightbutton addTarget:self action:@selector(rightbuttonAction) forControlEvents:(UIControlEventTouchUpInside)];
//            rightbutton.backgroundColor = [UIColor redColor];
            //标题左视图
            //            self.rightimageView.image = [UIImage imageNamed:@"icon_nav_dh"];
//            annoView.rightCalloutAccessoryView = rightbutton;
            [annoView.rightCalloutAccessoryView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_nav_dh"]]];
        }
        // 设置模型(位置\标题\子标题)
        annoView.aannotation = annotation;
        
        //添加工程的项目图标
        annoView.image=[UIImage imageNamed:@"logo.png"];
        
        
        
        
        return annoView;
    }
    return nil;
}


-(void)buttonAction
{
    NSLog(@"左");
}
-(void)rightbuttonAction
{
    NSLog(@"右");
}


@end
