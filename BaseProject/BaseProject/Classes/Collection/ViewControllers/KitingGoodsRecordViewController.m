//
//  KitingGoodsRecordViewController.m
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingGoodsRecordViewController.h"
#import "KitingGoodsRecordCell.h"
@interface KitingGoodsRecordViewController ()
@property(retain,atomic) NSMutableArray *models;
@end

@implementation KitingGoodsRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [_models addObject:model16];}

-(void) addTableView{
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, [self getNavBarHeight], self.view.bounds.size.width, self.view.bounds.size.height - [self getNavBarHeight]) style:UITableViewStylePlain];
    tb.backgroundColor = [UIColor whiteColor];
    tb.separatorColor = [ColorContants integralSeperatorColor];
    [tb registerClass:[KitingGoodsRecordCell class] forCellReuseIdentifier:@"cell"];
    tb.allowsSelection = NO;
    tb.clipsToBounds=YES;
    tb.dataSource = self;
    tb.rowHeight = SizeHeight(50);
    tb.tableFooterView = [UIView new];
    
    [self.view addSubview:tb];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        ((KitingGoodsRecordCell *) cell).model = _models[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ 
        return  _models.count;
}

@end
