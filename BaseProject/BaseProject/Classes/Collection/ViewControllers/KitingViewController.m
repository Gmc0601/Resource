//
//  KitingViewController.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingViewController.h"
#import "Constants.h"
#import "BankCardModel.h"
#import "KitingModel.h"

@interface KitingViewController ()
@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic) BankCardModel *backCard;
@end

@implementation KitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.text = @"提现";
    lab.textColor = [ColorContants whiteFontColor];
    lab.font = [UIFont fontWithName:[FontConstrants pingFang] size:18];
    [lab sizeToFit];
    self.navigationItem.titleView = lab;
    
    _models = [NSMutableArray arrayWithCapacity:0];
}

@end
