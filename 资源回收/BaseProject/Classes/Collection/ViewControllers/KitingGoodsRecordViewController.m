//
//  KitingGoodsRecordViewController.m
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingGoodsRecordViewController.h"
#import "KitingGoodsRecordCell.h"
#import "KitingGoodsRecordModel.h"
#import "TBRefresh.h"

@interface KitingGoodsRecordViewController ()
@property(retain,atomic) NSMutableArray *models;
@property(assign,nonatomic) int pageIndex;
@property(assign,nonatomic) int limit;
@property(retain,atomic) UITableView *tb;
@end

@implementation KitingGoodsRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _limit = 10;
    _pageIndex = 0;
    [self setNavTitle:@"积分兑换记录"];
    [self addTableView];
    _models = [NSMutableArray arrayWithCapacity:0];
    
    __weak KitingGoodsRecordViewController *weakSelf = self;
    [_tb addRefreshHeaderWithBlock:^{
        _pageIndex = 0;
        _models = [NSMutableArray arrayWithCapacity:0];
        [weakSelf loadKitingRecord];
        [weakSelf.tb.header endHeadRefresh];
    }];
    
    [_tb addRefreshFootWithBlock:^{
        [weakSelf loadKitingRecord];
        [weakSelf.tb.footer endFooterRefreshing];
    }];
    
    [_tb.header beginRefreshing];
}

-(void) addTableView{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, [self getNavBarHeight], self.view.bounds.size.width, self.view.bounds.size.height - [self getNavBarHeight]) style:UITableViewStylePlain];
    _tb.backgroundColor = [UIColor whiteColor];
    _tb.separatorColor = [ColorContants integralSeperatorColor];
    [_tb registerClass:[KitingGoodsRecordCell class] forCellReuseIdentifier:@"cell"];
    _tb.allowsSelection = NO;
    _tb.clipsToBounds=YES;
    _tb.dataSource = self;
    _tb.rowHeight = SizeHeight(50);
    _tb.tableFooterView = [UIView new];
    
    [self.view addSubview:_tb];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ((KitingGoodsRecordCell *) cell).model = _models[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _models.count;
}

-(void) loadKitingRecord{
    _pageIndex++;
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    [params setObject:[NSString stringWithFormat:@"%d",_pageIndex] forKey:@"page"];
    [params setObject:[NSString stringWithFormat:@"%d",_limit] forKey:@"size"];
    
    [HttpRequest postPath:@"_exchangeguserlist_001" params:params resultBlock:^(id responseObject, NSError *error) {
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            if (infoDic.count == 0) {
                _pageIndex--;
                return;
            }
            
            for (NSDictionary *dict in infoDic) {
                KitingGoodsRecordModel *model = [KitingGoodsRecordModel new];
                model.integral = [NSString stringWithFormat:@"-%@",  dict[@"amount"]];
                model.goodsName = dict[@"good_name"];
                model.date = (NSDate *)dict[@"create_time"];
                model.type = dict[@"type"] ;
                if([model.type isEqualToString:@"订购"]){
                    model.integral = @"";
                }
                [_models addObject:model];
            }
            [_models sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                KitingGoodsRecordModel *mode1l = (KitingGoodsRecordModel *) obj1;
                KitingGoodsRecordModel *mode12 = (KitingGoodsRecordModel *) obj2;
                return [mode12.date compare:mode1l.date] == NSOrderedDescending;
            }];
            [_tb reloadData];
        }else {
            _pageIndex--;
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
    }];
}

@end
