//
//  IntegralCell.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingGoodsRecordCell.h"
#import "Constants.h"
#import <Masonry/Masonry.h>

@interface KitingGoodsRecordCell()
@property(retain,atomic) UILabel *lblType;
@property(retain,atomic) UILabel *lblDate;
@property(retain,atomic) UILabel *lblSum;
@property(retain,atomic) UILabel *lblSummery;
@end

@implementation KitingGoodsRecordCell

@synthesize model = _model;
-(void) setModel:(KitingGoodsRecordModel *)model{
    _model = model;
    _lblDate.text = _model.date;
    _lblSum.text = _model.integral;
    _lblSummery.text = _model.type;
    _lblType.text = _model.goodsName;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void) addSubviews{
    
    _lblType = [[UILabel alloc]init];
    _lblType.textColor = [ColorContants userNameFontColor];
    _lblType.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    _lblType.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lblType];
    
    [_lblType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SizeHeight(12));
        make.left.equalTo(self.mas_left).offset(SizeWidth(12));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    _lblSum = [[UILabel alloc]init];
    _lblSum.textColor = [ColorContants userNameFontColor];
    _lblSum.font = [UIFont fontWithName:[FontConstrants pingFangBold] size:SizeWidth(15)];
    _lblSum.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lblSum];
    
    [_lblSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lblType.mas_centerY);
        make.right.equalTo(self.mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    _lblDate = [[UILabel alloc]init];
    _lblDate.textColor = [ColorContants phoneNumerFontColor];
    _lblDate.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
    _lblDate.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lblDate];
    
    [_lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SizeWidth(12));
        make.top.equalTo(_lblType.mas_bottom).offset(SizeWidth(10));
        make.width.equalTo(@(SizeWidth(120)));
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
        make.left.equalTo(_lblDate.mas_right).offset(SizeWidth(20));;
        make.height.equalTo(@(SizeHeight(12)));
    }];
}

@end
