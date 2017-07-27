//
//  HomeView.h
//  BaseProject
//
//  Created by LeoGeng on 24/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface HomeView : UIView
@property(retain,nonatomic) UserModel *user;
@property(retain,atomic) UICollectionView *collectionView;
@end
