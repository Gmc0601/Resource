//
//  IntegalViewController.h
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "IntegralHeaderCell.h"

@interface IntegalViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,IntegralHeaderCellDelegate>
@property(retain,nonatomic) NSString *integral;
@end
