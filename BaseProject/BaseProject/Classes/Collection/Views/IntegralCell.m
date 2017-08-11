//
//  IntegralCell.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "IntegralCell.h"
#import "Constants.h"
#import <Masonry/Masonry.h>
#import "NSString+Category.h"

@interface IntegralCell()
@property(retain,atomic) UILabel *lblType;
@property(retain,atomic) UILabel *lblDate;
@property(retain,atomic) UILabel *lblTime;
@property(retain,atomic) UILabel *lblSum;
@property(retain,atomic) UILabel *lblSummery;
@end

@implementation IntegralCell

@synthesize model = _model;
-(void) setModel:(IntegralRecordModel *)model{
    _model = model;
    NSArray *arr = [_model.date componentsSeparatedByString:@" "];
    _lblDate.text = arr[0];
    _lblTime.text = arr[1];
    _lblSum.text = _model.sum;
    _lblSummery.text = _model.summery;
    _lblType.text = _model.type;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void) addSubviews{
    
    
    _lblSum = [[UILabel alloc]init];
    _lblSum.textColor = [ColorContants BlueFontColor];
    _lblSum.font = [UIFont fontWithName:[FontConstrants pingFangBold] size:SizeWidth(15)];
    _lblSum.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lblSum];
    
    [_lblSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SizeHeight(16));
        make.right.equalTo(self.mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _lblType = [[UILabel alloc]init];
    _lblType.textColor = [ColorContants kitingFontColor];
    _lblType.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(14)];
    _lblType.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lblType];
    
    [_lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SizeHeight(16));
        make.left.equalTo(self.mas_left).offset(SizeWidth(12));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    _lblDate = [[UILabel alloc]init];
    _lblDate.textColor = [ColorContants phoneNumerFontColor];
    _lblDate.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(14)];
    _lblDate.textAlignment = NSTextAlignmentLeft;
    _lblDate.text = @"2017-08-28";
    [self addSubview:_lblDate];
    
    CGFloat width = [_lblDate.text widthWithFontSize:SizeWidth(14) height:SizeHeight(14)] + SizeWidth(3);
    [_lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SizeWidth(12));
        make.top.equalTo(_lblType.mas_bottom).offset(SizeWidth(10));
        make.width.equalTo(@(width));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    _lblTime = [[UILabel alloc]init];
    _lblTime.textColor = [ColorContants phoneNumerFontColor];
    _lblTime.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(14)];
    _lblTime.textAlignment = NSTextAlignmentLeft;

    [self addSubview:_lblTime];
    
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblDate.mas_right).offset(SizeWidth(13));
        make.centerY.equalTo(_lblDate);
        make.width.equalTo(@(SizeWidth(80)));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    _lblSummery = [[UILabel alloc]init];
    _lblSummery.textColor = [ColorContants integralWhereFontColor];
    _lblSummery.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
    _lblSummery.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lblSummery];
    
    [_lblSummery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_lblSum.mas_right).offset(0);
        make.top.equalTo(_lblSum.mas_bottom).offset(SizeHeight(11));
        make.left.equalTo(_lblTime.mas_right).offset(SizeWidth(20));;
        make.height.equalTo(@(SizeHeight(12)));
    }];
}

@end
