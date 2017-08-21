//
//  ZAnnotation.h
//  MAP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@class CustomAnnotationView;
@class CustomCalloutView;
@interface ZAnnotation : NSObject<MAAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property(nonatomic ,copy )NSString *threetitle;
@property(nonatomic,copy)NSString *fourtitle;

@property(nonatomic,copy)UIImage *leftImage;

//@property(nonatomic,copy)UIButton *phoneBtn;
/**大头针的图片名*/
@property (nonatomic, strong)UIImage  *icon;

//tag
@property(nonatomic,strong)NSString *tagg;

@property(nonatomic,strong)CustomAnnotationView *customAnnotationView;

@end
