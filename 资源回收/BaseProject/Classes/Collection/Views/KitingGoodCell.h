//
//  KitingGoodCell.h
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitingGoodsModel.h"

@protocol KitingGoodCellDelegate <NSObject>

-(void) didSelectKittingId:(NSString *) id isKitting:(BOOL) isKitting;

@end

@interface KitingGoodCell : UICollectionViewCell
@property (retain,nonatomic) KitingGoodsModel *model;
@property (weak,atomic) id<KitingGoodCellDelegate> delegate;
@end
