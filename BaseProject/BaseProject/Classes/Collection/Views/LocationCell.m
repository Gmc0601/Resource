//
//  LocationCell.m
//  BaseProject
//
//  Created by LeoGeng on 01/08/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "LocationCell.h"
#import "Constants.h"
#import <Masonry/Masonry.h>
#import "UIColor+BGHexColor.h"

@interface LocationCell()
@property(retain,atomic) UILabel *lblName;
@property(retain,atomic) UILabel *lblAddress;
@end

@implementation LocationCell
@synthesize name = _name;

-(void) setName:(NSString *)name{
    _name = name;
    _lblName.text = _name;
}

-(void) setAddress:(NSString *)address{
    _address = address;
    _lblAddress.text = address;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void) addSubviews{
    _lblName = [[UILabel alloc]init];
    _lblName.textColor = [ColorContants userNameFontColor];
    _lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    _lblName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lblName];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SizeHeight(15));
        make.left.equalTo(self.mas_left).offset(SizeWidth(16));
        make.right.equalTo(self.mas_right).offset(SizeWidth(-16));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _lblAddress = [[UILabel alloc]init];
    _lblAddress.textColor = [ColorContants phoneNumerFontColor];
    _lblAddress.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(13)];
    _lblAddress.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lblAddress];
    
    [_lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblName.mas_bottom).offset(SizeHeight(7));
        make.left.equalTo(_lblName.mas_left);
        make.right.equalTo(_lblName.mas_right);
        make.height.equalTo(@(SizeHeight(13)));
    }];
}

-(void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        _lblName.textColor = [UIColor colorWithHexString:@"34a2f1"];
    }else{
        _lblName.textColor = [ColorContants userNameFontColor];
    }
}


@end
