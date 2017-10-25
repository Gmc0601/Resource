//
//  SelectKittingTypeViewController.h
//  BaseProject
//
//  Created by LeoGeng on 24/10/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectKittingTypeViewController;
@protocol SelectKittingTypeViewControllerDelegate <NSObject>

-(void) didChangeType:(NSString *) type;

@end

@interface SelectKittingTypeViewController : UIViewController
@property(weak,nonatomic) id<SelectKittingTypeViewControllerDelegate> delegate;
@end
