//
//  PagegeCollectionViewCell.m
//  BaseProject
//
//  Created by JeroMac on 2017/7/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "PagegeCollectionViewCell.h"

@implementation PagegeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView.image = [UIImage imageNamed:@"backGroud"];
        self.imageView.layer.cornerRadius = 2.5;
        [self.contentView addSubview:self.imageView];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        view1.backgroundColor = [UIColor blackColor];
        view1.layer.cornerRadius = 2.5;
        view1.alpha = 0.5;
        [self.contentView addSubview:view1];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = @"回收站";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0];
        self.titleLabel.layer.cornerRadius = 2.5;
        [self.contentView addSubview:self.titleLabel];
        
        
        
    }
    return self;
    
}




@end
