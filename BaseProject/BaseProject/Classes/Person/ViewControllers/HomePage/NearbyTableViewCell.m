//
//  NearbyTableViewCell.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NearbyTableViewCell.h"

@implementation NearbyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickPhoneCellBtn:(UIButton *)sender {
    [self.delegate ClickPersonHomePageBtn:self.personHomePagePhone.text];
}
@end
