//
//  LocationViewController.m
//  BaseProject
//
//  Created by LeoGeng on 01/08/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface LocationViewController()<CLLocationManagerDelegate,
UIAlertViewDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(retain,atomic) AMapSearchAPI *search;
@property(retain,atomic) AMapPOIAroundSearchRequest *request;
@property(retain,atomic) NSMutableArray *orginalDataSource;
@property(retain,atomic) NSMutableArray *dataSource;
@property(retain,atomic) UITableView *tb;
@property(retain,atomic) UIView *header;
@property(retain,atomic) UITextField *txtKeyword;
@property(assign,nonatomic) CLLocationCoordinate2D location;
@property(retain,atomic) NSString *city;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"所在位置"];
    [AMapServices sharedServices].apiKey = @"292c0fdfe3e1facb67a1e743303426bb";
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    _orginalDataSource =[NSMutableArray arrayWithCapacity:0];
    [self addHeaderView];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initLocation];
}

-(void) addHeaderView{
    _header = [UIView new];
    _header.backgroundColor = [ColorContants gray];
    [self.view addSubview:_header];
    
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([self getNavBarHeight]);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.equalTo(@(SizeHeight(96/2)));
    }];
    
    UIFont *placeHolderFont = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
    UIColor *placeHolderColor = [ColorContants integralWhereFontColor];
    UIFont *font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    UIColor *color = [ColorContants userNameFontColor];
    
    _txtKeyword = [UITextField new];
    _txtKeyword.font = font;
    _txtKeyword.textColor = color;
    _txtKeyword.delegate = self;
    _txtKeyword.returnKeyType = UIReturnKeySearch;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"搜索附近位置" attributes:@{ NSForegroundColorAttributeName : placeHolderColor,NSFontAttributeName:placeHolderFont,
                                                                                                 NSParagraphStyleAttributeName:style}];
    _txtKeyword.attributedPlaceholder = str;
    _txtKeyword.backgroundColor = [UIColor whiteColor];
    [_txtKeyword addTarget:self action:@selector(tapSearchButton) forControlEvents:UIControlEventEditingChanged];
    
    [_header addSubview:_txtKeyword];
    [_txtKeyword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_header.mas_centerY);
        make.left.equalTo(_header.mas_left).offset(SizeWidth(16));
        make.width.equalTo(@(SizeWidth(574/2)));
        make.height.equalTo(@(SizeHeight(56/2)));
    }];
    
    UIButton *btnSearch = [[UIButton alloc] init];
    btnSearch.backgroundColor = [ColorContants BlueButtonColor];
    btnSearch.layer.cornerRadius = SizeHeight(3);
    [btnSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [btnSearch setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnSearch.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    
    [btnSearch addTarget:self action:@selector(tapSearchButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_header addSubview:btnSearch];
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_header.mas_centerY);
        make.left.equalTo(_txtKeyword.mas_right).offset(SizeWidth(8));
        make.width.equalTo(@(SizeWidth(96/2)));
        make.height.equalTo(@(SizeHeight(56/2)));
    }];
}

-(void) addTableView{
    _tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor whiteColor];
    _tb.separatorColor = [ColorContants integralSeperatorColor];
    [_tb registerClass:[LocationCell class] forCellReuseIdentifier:@"LocationCell"];
    [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tb.allowsSelection = YES;
    _tb.clipsToBounds=YES;
    _tb.dataSource = self;
    _tb.delegate = self;
    _tb.tableFooterView = [UIView new];
    
    [self.view addSubview:_tb];
    
    [_tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_header.mas_bottom);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataSource.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        UILabel *lblMsg = [[UILabel alloc]init];
        lblMsg.textColor = [ColorContants phoneNumerFontColor];
        lblMsg.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
        lblMsg.textAlignment = NSTextAlignmentCenter;
        lblMsg.text = @"没有找到该位置，请重新搜索";
        [cell addSubview:lblMsg];
        
        [lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.mas_centerX);
            make.centerY.equalTo(cell.mas_centerY).offset(SizeHeight(-50));
            make.height.equalTo(@(SizeHeight(15)));
            make.width.equalTo(@(SizeWidth(250)));
        }];
        return cell;
    }else{
        LocationCell *cell = (LocationCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
        AMapPOI *p = _dataSource[indexPath.row];
        cell.name = p.name;
        cell.address = p.address;
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource.count == 0) {
        return 1;
    }
    return  _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataSource.count == 0) {
        return CGRectGetHeight(tableView.bounds);
    }
    return  SizeHeight(52);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *poi = (AMapPOI *) _dataSource[indexPath.row];
    AMapGeoPoint *point = poi.location;
    [self.delegate chooseAddress:point withName:poi.name];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initLocation{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 500;
    [_locationManager requestWhenInUseAuthorization];
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[资源回收]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" , nil];
        alertView.delegate = self;
        alertView.tag = 1;
        [alertView show];
    }else{
        [_locationManager startUpdatingLocation];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    _location = location.coordinate;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    _orginalDataSource =[NSMutableArray arrayWithCapacity:0];

    if (response.pois.count != 0)
    {
        for (AMapPOI *p in response.pois) {
            [_orginalDataSource addObject:p];
            _city = p.city;
        }
    }
    
    _dataSource = _orginalDataSource;
    if (_tb == nil) {
        [self addTableView];
    }
    
    [_tb reloadData];
}

-(void) tapSearchButton{

    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = _txtKeyword.text;
    request.requireExtension    = YES;
    request.city = _city;
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tb reloadData];

    NSLog(@"%@",error);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self tapSearchButton];
    return YES;
}

@end
