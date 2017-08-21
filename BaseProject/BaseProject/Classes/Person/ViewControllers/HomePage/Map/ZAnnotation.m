//
//  ZAnnotation.m
//  MAP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ZAnnotation.h"



@implementation ZAnnotation
- (BOOL)isEqual:(ZAnnotation *)other
{
    return [self.title isEqual:other.title];
}


@end
