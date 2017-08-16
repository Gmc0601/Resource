//
//  MessageTableViewCell.h
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messageModel.h"
@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UILabel *messagetitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *messageTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

- (void)setCellWithModel:(messageModel *)model;

@end
