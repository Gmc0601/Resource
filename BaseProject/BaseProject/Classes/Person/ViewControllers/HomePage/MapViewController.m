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

@interface MapViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSString *currentCity;
    NSString *Strlatitude;
    NSString *Strlongitude;
    CLLocation *currentLocation;
}

@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, assign) BOOL showTraffic;

@end

@implementation MapViewController

- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_fh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickMapBackBtn)];
    
    [self  locatemap];
    [super viewDidLoad];
    //     self.view.backgroundColor = [UIColor redColor];
    
    
    //配置用户Key
    [AMapServices sharedServices].apiKey = @"2790ab5b9b214a0454170cbc87e32353";
    //初始化高德地图对象
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
    
    // Do any additional setup after loading the view.
}

- (void)clickMapBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationItem.title = @"地图";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)locatemap{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0) {
            [locationManager requestAlwaysAuthorization];
        }else{
            [locationManager startUpdatingLocation];
        }
    }
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"222请打开定位按钮");
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    currentLocation  = [locations lastObject];
    CLGeocoder *geoCode = [[CLGeocoder alloc] init];
    
    Strlongitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    Strlatitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    
    NSLog(@"%f---%f", currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    [geoCode reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //            NSLog(@"aaaa%@", placemarks);
        //        NSLog(@"333------%@", self.location.timestamp);
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"%@---%@", placemark.name, placemark.addressDictionary);
            
            //            _DetailPosition.text = placemark.name;
            NSLog(@"22222%@", placemark.addressDictionary[@"FormattedAddressLines"]);
            
        }
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        _mapView.centerCoordinate =  CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        pointAnnotation.title = @"方恒国际";
        pointAnnotation.subtitle = @"阜通东大街6号";
        [_mapView addAnnotation:pointAnnotation];
        
    }];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
#pragma mark 4.标注自定义
    [super viewDidAppear:animated];
    
    
    //
    //    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    //    pointAnnotation.coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    //    _mapView.centerCoordinate =  CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    //    pointAnnotation.title = @"方恒国际";
    //    pointAnnotation.subtitle = @"阜通东大街6号";
    //    [_mapView addAnnotation:pointAnnotation];
    
}



//实现 MAMapViewDelegate 的 mapView:viewForAnnotation:函数,设置标注样式。
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES; //设置气泡可以弹出,默认为 NO annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO
        annotationView.draggable = YES; //设置标注可以拖动,默认为 NO annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
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
