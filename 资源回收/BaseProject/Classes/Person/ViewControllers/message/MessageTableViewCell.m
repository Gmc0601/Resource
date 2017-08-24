//
//  MessageTableViewCell.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "messageModel.h"
@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCellWithModel:(messageModel *)model{
    self.messageTimeLabel.text = model.create_time;
    self.messagetitlelabel.text = model.title;

}

@end
