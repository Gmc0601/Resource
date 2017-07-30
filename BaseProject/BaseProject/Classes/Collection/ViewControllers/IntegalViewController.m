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
    
    IntegralRecordModel *model1 = [IntegralRecordModel new];
    model1.type = @"提现";
    model1.sum = @"-1000";
    model1.summery = @"提现";
    model1.date = @"2019-10-01";
    [_models addObject:model1];
    
    IntegralRecordModel *model2 = [IntegralRecordModel new];
    model2.type = @"提现";
    model2.sum = @"-1000";
    model2.summery = @"提现";
    model2.date = @"2019-10-01";
    [_models addObject:model2];
    
    IntegralRecordModel *model3 = [IntegralRecordModel new];
    model3.type = @"提现";
    model3.sum = @"-1000";
    model3.summery = @"提现";
    model3.date = @"2019-10-01";
    [_models addObject:model3];
    
    IntegralRecordModel *model4 = [IntegralRecordModel new];
    model4.type = @"提现";
    model4.sum = @"-1000";
    model4.summery = @"提现";
    model4.date = @"2019-10-01";
    [_models addObject:model4];
    
    IntegralRecordModel *model5 = [IntegralRecordModel new];
    model5.type = @"提现";
    model5.sum = @"-1000";
    model5.summery = @"提现";
    model5.date = @"2019-10-01";
    [_models addObject:model5];
    
    IntegralRecordModel *model6 = [IntegralRecordModel new];
    model6.type = @"提现";
    model6.sum = @"-1000";
    model6.summery = @"提现";
    model6.date = @"2019-10-01";
    [_models addObject:model6];
    
    IntegralRecordModel *model7 = [IntegralRecordModel new];
    model7.type = @"提现";
    model7.sum = @"-1000";
    model7.summery = @"提现";
    model7.date = @"2019-10-01";
    [_models addObject:model7];
    
    IntegralRecordModel *model8 = [IntegralRecordModel new];
    model8.type = @"提现";
    model8.sum = @"-1000";
    model8.summery = @"提现";
    model8.date = @"2019-10-01";
    [_models addObject:model8];
    
    IntegralRecordModel *model9 = [IntegralRecordModel new];
    model9.type = @"提现";
    model9.sum = @"-1000";
    model9.summery = @"提现";
    model9.date = @"2019-10-01";
    [_models addObject:model9];
    
    IntegralRecordModel *model16 = [IntegralRecordModel new];
    model16.type = @"提现";
    model16.sum = @"-1000";
    model16.summery = @"提现";
    model16.date = @"2019-10-01";
    [_models addObject:model16];
    
    IntegralRecordModel *model10 = [IntegralRecordModel new];
    model10.type = @"提现";
    model10.sum = @"-1000";
    model10.summery = @"提现";
    model10.date = @"2019-10-01";
    [_models addObject:model10];
    [self.navigationItem setLeftBarButtonItem:nil];
     [PublicClass setLeftButtonItemOnTargetNav:self action:@selector(backAction) image:[UIImage imageNamed:@"icon_nav_fhb.png"]];}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

-(void) addTableView{
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    tb.backgroundColor = [UIColor whiteColor];
    tb.separatorColor = [ColorContants integralSeperatorColor];
    tb.separatorInset = UIEdgeInsetsMake(0, SizeWidth(12), 0, SizeWidth(12));
    [tb registerClass:[IntegralHeaderCell class] forCellReuseIdentifier:@"cell"];
    [tb registerClass:[IntegralCell class] forCellReuseIdentifier:@"integralCell"];
    [tb registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    tb.allowsSelection = NO;
    tb.clipsToBounds=YES;

    tb.dataSource = self;
    tb.delegate = self;
    
    [self.view addSubview:tb];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        ((IntegralHeaderCell *) cell).delegate = self;
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
    KitingViewController *newViewController = [KitingViewController new];
    [self.navigationController pushViewController:newViewController animated:YES];
}
-(void) tapConvertButton{
    KitingGoodsViewController *newViewController = [KitingGoodsViewController new];
    [self.navigationController pushViewController:newViewController animated:YES];
}
-(void) tapSend{
    SendIntegralViewController *newViewController = [SendIntegralViewController new];
    
    [self.navigationController pushViewController:newViewController animated:NO];
}

@end
