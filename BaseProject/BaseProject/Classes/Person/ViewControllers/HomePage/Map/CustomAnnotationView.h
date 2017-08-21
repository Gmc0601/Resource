//
//  CustomAnnotationView.h
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
@class CustomCalloutView;
@class ZAnnotation;
@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, strong,readwrite) CustomCalloutView *calloutView;

@property(nonatomic,strong,readwrite)ZAnnotation *aannotation;


@end;
