//
//  IntegalViewController.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "IntegalViewController.h"
#import "Constants.h"
#import "IntegralCell.h"
#import "KitingViewController.h"
#import "IntegralRecordModel.h"
#include "FactorySet.h"
#include "PublicClass.h"
#import "KitingGoodsViewController.h"
#import "SendIntegralViewController.h"

@interface IntegalViewController ()
@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic)  UITableView *tb;
@end

@implementation IntegalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.text = @"积分";
    lab.textColor = [ColorContants whiteFontColor];
    lab.font = [UIFont fontWithName:[FontConstrants pingFang] size:18];
    [lab sizeToFit];
    self.navigationItem.titleView = lab;
    [self addTableView];
    
    _models = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
    [self.navigationItem setLeftBarButtonItem:nil];
     [PublicClass setLeftButtonItemOnTargetNav:self action:@selector(backAction) image:[UIImage imageNamed:@"icon_nav_fhb.png"]];}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
    [self getIntegral];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

-(void) addTableView{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor whiteColor];
    _tb.separatorColor = [ColorContants integralSeperatorColor];
    _tb.separatorInset = UIEdgeInsetsMake(0, SizeWidth(12), 0, SizeWidth(12));
    [_tb registerClass:[IntegralHeaderCell class] forCellReuseIdentifier:@"cell"];
    [_tb registerClass:[IntegralCell class] forCellReuseIdentifier:@"integralCell"];
    [_tb registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    _tb.allowsSelection = NO;
    _tb.clipsToBounds=YES;

    _tb.dataSource = self;
    _tb.delegate = self;
    
    [self.view addSubview:_tb];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        ((IntegralHeaderCell *) cell).delegate = self;
        ((IntegralHeaderCell *) cell).integral = self.integral;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"integralCell"];
        ((IntegralCell *) cell).model = _models[indexPath.row];
    }
    
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (header.subviews.count > 1) {
        return header;
    }
    header.backgroundColor = [ColorContants gray];
    CGFloat width = SizeWidth(100);
    CGFloat height = SizeHeight(15);
    CGFloat margin = SizeWidth(87.5);


    UILabel * lblInput = [[UILabel alloc]init];
    lblInput.text = @"收入";
    lblInput.textColor = [ColorContants phoneNumerFontColor];
    lblInput.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    lblInput.textAlignment = NSTextAlignmentRight;
    [header addSubview:lblInput];
    
    [lblInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.mas_centerY);
        make.right.equalTo(header.mas_centerX).offset(-margin);
        make.height.equalTo(@(height));
        make.width.equalTo(@(width));
    }];
    
    UILabel * lblOutput = [[UILabel alloc]init];
    lblOutput.text = @"支出";
    lblOutput.textColor = [ColorContants BlueFontColor];
    lblOutput.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    lblOutput.textAlignment = NSTextAlignmentLeft;
    [header addSubview:lblOutput];
    
    [lblOutput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.mas_centerY);
        make.left.equalTo(header.mas_centerX).offset(margin);
        make.height.equalTo(@(height));
        make.width.equalTo(@(width));
    }];
    
    UIView *border = [[UIView alloc] init];
    border.backgroundColor = [ColorContants integralSeperatorColor];
    [header addSubview:border];
    
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.right.equalTo(header.mas_right);
        make.bottom.equalTo(header.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    UIView *blueBorder = [[UIView alloc] init];
    blueBorder.backgroundColor = [ColorContants BlueFontColor];
    [header addSubview:blueBorder];
    
    [blueBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblOutput.mas_right).offset(-16);
        make.bottom.equalTo(header.mas_bottom);
        make.height.equalTo(@(SizeHeight(1.5)));
        make.width.equalTo(@(SizeHeight(278/2)));
    }];

    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return SizeHeight(42);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SizeHeight(192);
    }else{
        return SizeHeight(64);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return  _models.count;
    }
}

-(void) tapKitingButton{
    KitingViewController *newViewController = [[KitingViewController alloc] initWithIntegral:_integral.intValue];
    [self.navigationController pushViewController:newViewController animated:YES];
}
-(void) tapConvertButton{
    KitingGoodsViewController *newViewController = [KitingGoodsViewController new];
    newViewController.integral = _integral.intValue;
    [self.navigationController pushViewController:newViewController animated:YES];
}
-(void) tapSend{
    SendIntegralViewController *newViewController = [[SendIntegralViewController alloc] initWithIntegral:_integral.intValue];
    
    [self.navigationController pushViewController:newViewController animated:NO];
}


-(void) loadData{
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    [params setObject:@"2" forKey:@"type"];
//    [ConfigModel showHud:self];
    
    [HttpRequest postPath:@"_userintegrallist_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            
            for (NSDictionary *dict in infoDic) {
                IntegralRecordModel *model = [IntegralRecordModel new];
                model.sum = dict[@"amount"];
                model.type = [dict[@"type"]  isEqual: @"1"] ? @"收入":@"支出";
                model.summery = dict[@"action_type"];
                model.date = dict[@"create_time"];
                
                [_models addObject:model];
            }
            
            [_tb reloadData];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
}

-(void) getIntegral{
        NSMutableDictionary *params = [NSMutableDictionary new];
        NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
        [params setObject:userTokenStr forKey:@"userToken"];
        [ConfigModel showHud:self];
    
        [HttpRequest postPath:@"_usernum_001" params:params resultBlock:^(id responseObject, NSError *error) {
            [ConfigModel hideHud:self];
            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] == 0) {
                NSDictionary *infoDic = responseObject[@"info"];
                self.integral =  infoDic[@"jifen"];
            }else {
                NSString *info = datadic[@"info"];
                [ConfigModel mbProgressHUD:info andView:nil];
            }
            NSLog(@"error>>>>%@", error);
        }];
}


@end
