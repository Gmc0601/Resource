//
//  CustomAnnotationView.m
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#import "ZAnnotation.h"



#define kCalloutWidth       300.0
#define kCalloutHeight      70.0

@interface CustomAnnotationView ()

@property (nonatomic, retain) ZAnnotation *model;

@end

@implementation CustomAnnotationView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.model = annotation;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.clickBlock) {
            self.clickBlock(self.model);
        }
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

@end
