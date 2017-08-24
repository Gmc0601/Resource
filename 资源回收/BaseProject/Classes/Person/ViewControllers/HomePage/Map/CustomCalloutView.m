//
//  CustomCalloutView.m
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import "CustomCalloutView.h"


#define kArrorHeight        10

#define kPortraitMargin     5
#define kPortraitWidth     100   //leftimage宽
#define kPortraitHeight     25

#define kTitleWidth         180
#define kTitleHeight        20



@interface CustomCalloutView ()


@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic,strong)UILabel *threetitleLabel;
@property(nonatomic,strong)UILabel *fourtitleLabel;

@end
@implementation CustomCalloutView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame=CGRectMake(0, -20, 300, 120);
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    
    self.userInteractionEnabled=YES;
    // 添加图片，即商户图
    
    self.portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 20, 80, 80)];
    self.portraitView.layer.cornerRadius=8;
    self.portraitView.clipsToBounds=YES;
    self.portraitView.userInteractionEnabled=YES;
    self.portraitView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.portraitView];
    
    self.rightimageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 10, 20, 20)];
    self.rightimageView.clipsToBounds=YES;
    self.rightimageView.layer.cornerRadius=2;
    self.rightimageView.userInteractionEnabled=YES;
    self.rightimageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.rightimageView];
    

    
    
    // 添加标题，即商户名
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 , 40, 170, 50)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    self.titleLabel.numberOfLines = 0;
//    self.titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 95, 90, 20)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
//    self.subtitleLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:self.subtitleLabel];
    
    
    self.threetitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 95, 80, 20)];
    self.threetitleLabel.font=[UIFont systemFontOfSize:10];
    self.threetitleLabel.textAlignment = NSTextAlignmentCenter;
//    self.threetitleLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:self.threetitleLabel];
    
    
    self.fourtitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 150, 20)];
//    self.fourtitleLabel.backgroundColor=[UIColor greenColor];
    self.fourtitleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:self.fourtitleLabel];
    
    UIImageView *addImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 57, 13, 17)];
    [self addSubview:addImg];
 
    addImg.image =  [UIImage imageNamed:@"fpxq_icon_dw"];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 95, 13, 18)];
    [self addSubview:phoneImg];
    phoneImg.image =  [UIImage imageNamed:@"fpxq_icon_sj"];
    
}


- (void)playPhone:(NSString *)str{
    [self.delegate playMapPhone:str];
}
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    //背景颜色
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 0.0;   //北背景图片的圆角
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

- (void)setLeftimage:(UIImage *)leftimage
{
    self.portraitView.image = leftimage;
}
-(void)setRightimage:(UIImage *)rightimage
{
    self.rightimageView.image=rightimage;
}
-(void)setThreetitle:(NSString *)threetitle
{
    self.threetitleLabel.text=threetitle;
}
-(void)setFourtitle:(NSString *)fourtitle
{
    self.fourtitleLabel.text=fourtitle;
}


@end
