//
//  ImagPickerView.h
//  BaseProject
//
//  Created by LeoGeng on 03/08/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagePickerView;
@protocol ImagePickerViewDelegate <NSObject>

-(void) chooseImage:(ImagePickerView *) sender;

@end

@interface ImagePickerView : UIView
@property(weak,nonatomic) id<ImagePickerViewDelegate> delegate;
-(NSData *) getImage;
-(void) setImage:(NSData *) img;
- (instancetype)initWithImage:(NSData *) img withRemaindText:(NSString *) remmaindText;
@end
