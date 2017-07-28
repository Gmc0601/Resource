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
#import "IntegralHeaderCell.h"

@interface IntegalViewController ()
@property(retain,atomic) NSArray *models;
@end

@implementation IntegalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.text = @"积分";
    lab.textColor = [ColorContants whiteFontColor];
    lab.font = [UIFont fontWithName:@"PingFang-SC" size:18];
    [lab sizeToFit];
    self.navigationItem.titleView = lab;
    [self addTableView];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) addTableView{
    UITableView *tb = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tb.backgroundColor = [UIColor whiteColor];
    [tb registerClass:[IntegralHeaderCell class] forCellReuseIdentifier:@"cell"];
    [tb registerClass:[IntegralCell class] forCellReuseIdentifier:@"integralCell.h"];
    [tb registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    tb.allowsSelection = NO;
    tb.clipsToBounds=YES;
    tb.separatorStyle = UITableViewCellSelectionStyleNone;

    tb.dataSource = self;
    tb.delegate = self;
    
    [self.view addSubview:tb];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"integralCell"];

    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return SizeHeight(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SizeHeight(262);
    }else{
        return SizeHeight(66);
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

@end
