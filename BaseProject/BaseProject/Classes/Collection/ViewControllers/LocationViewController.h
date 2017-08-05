//
//  LocationViewController.h
//  BaseProject
//
//  Created by LeoGeng on 01/08/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@protocol LocationViewControllerDelegate<NSObject>
-(void) chooseAddress:(AMapGeoPoint *) point;
@end


@interface LocationViewController : BaseViewController
@property(atomic,weak) id<LocationViewControllerDelegate> delegate;
@end
