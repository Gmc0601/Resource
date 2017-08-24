//
//  NearbyTableViewCell.h
//  BaseProject
//
//  Created by JeroMac on 2017/7/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonPageTableViewDelegate <NSObject>

- (void)ClickPersonHomePageBtn:(NSString *)str;

@end

@interface NearbyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *personHomePageImage;
@property (weak, nonatomic) IBOutlet UILabel *personHomePageTitle;
@property (weak, nonatomic) IBOutlet UILabel *personHomePageAddress;
@property (weak, nonatomic) IBOutlet UILabel *personHomePagePhone;
@property (weak, nonatomic) IBOutlet UILabel *personHomePageDistance;


@property (assign, nonatomic) id<PersonPageTableViewDelegate> delegate;

@end
