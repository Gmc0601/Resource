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


#import "ZAnnotation.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
@interface MapViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSString *currentCity;
    double Strlatitude;
    double Strlongitude;
    CLLocation *currentLocation;
    
    MAMapView *_mapView;
    ZAnnotation *_zAnnotation;
    NSMutableArray *pointArr;
}

@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, assign) BOOL showTraffic;

@end

@implementation MapViewController

- (void)viewDidLoad {
     pointArr = [NSMutableArray array];
    Strlatitude = [[ConfigModel getStringforKey:@"latitudeStr"] doubleValue];
    Strlongitude = [[ConfigModel getStringforKey:@"longitudeStr"] doubleValue];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickMapBackBtn)];
    

    [super viewDidLoad];
    //     self.view.backgroundColor = [UIColor redColor];
    
    
    //配置用户Key
    [AMapServices sharedServices].apiKey = @"2790ab5b9b214a0454170cbc87e32353";
    //初始化高德地图对象
    _mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    _mapView.delegate = self;
    //    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
//    Strlatitude, Strlongitude
//    30.181756, 120.153775
    _mapView.centerCoordinate =CLLocationCoordinate2DMake(30.181756, 120.153775);
    [_mapView selectAnnotation:_zAnnotation animated:YES];
    
    [self.view addSubview:_mapView];

    _mapView.userInteractionEnabled=YES;

    [self setPoints];
    
}

- (void)setPoints{
    for (int i  = 0; i <self.StoreArr.count ; i++) {
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

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationItem.title = @"地图";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}




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
            
            //添加标题的左视图  视图为： button
            UIButton *rightbutton=[UIButton buttonWithType:(UIButtonTypeRoundedRect)];
            [rightbutton setTitle:@"右" forState:(UIControlStateNormal)];
            rightbutton.frame=CGRectMake(0, 0, 25, 25);
            [rightbutton addTarget:self action:@selector(rightbuttonAction) forControlEvents:(UIControlEventTouchUpInside)];
            rightbutton.backgroundColor = [UIColor redColor];
            //标题左视图
            //            self.rightimageView.image = [UIImage imageNamed:@"icon_nav_dh"];
            annoView.rightCalloutAccessoryView = rightbutton;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
