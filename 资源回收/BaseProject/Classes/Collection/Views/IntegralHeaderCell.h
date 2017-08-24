//
//  IntegralHeaderCell.h
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntegralHeaderCellDelegate <NSObject>

-(void) tapKitingButton;
-(void) tapConvertButton;
-(void) tapSend;

@end

@interface IntegralHeaderCell : UITableViewCell
@property (retain,nonatomic) NSString *integral;
@property (atomic,weak) id<IntegralHeaderCellDelegate> delegate;
@end
