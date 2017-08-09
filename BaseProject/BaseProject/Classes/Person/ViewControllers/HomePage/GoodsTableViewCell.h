//
//  GoodsTableViewCell.h
//  BaseProject
//
//  Created by JeroMac on 2017/7/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TableViewImg;
@property (weak, nonatomic) IBOutlet UILabel *leftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *RightPriceLabel;

@end
