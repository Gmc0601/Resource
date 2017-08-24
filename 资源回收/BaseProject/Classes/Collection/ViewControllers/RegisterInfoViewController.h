//
//  RegisterInfoViewController.h
//  BaseProject
//
//  Created by LeoGeng on 31/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "ImagePickerView.h"

@interface RegisterInfoViewController : CCBaseViewController<ImagePickerViewDelegate,UIImagePickerControllerDelegate>
- (instancetype)initWithTelNo:(NSString *) telNo;
@end
