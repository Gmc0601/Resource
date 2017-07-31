//
//  HomeViewController.m
//  BaseProject
//
//  Created by LeoGeng on 24/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodsModel.h"
#import "Constants.h"
#import <Masonry/Masonry.h>
#import "NSMutableAttributedString+Category.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"
#import "GoodsCategoryModel.h"
#import "RecycleDetailViewController.h"
#import "IntegalViewController.h"
#import "PublicClass.h"

@interface HomeViewController ()
    @property(retain,atomic) NSMutableArray *models;
    @property(retain,atomic) UILabel *lblIntegral;
    @property(retain,atomic) UILabel *lblName;
    @property(retain,atomic) UIImageView *avatar;
    @property(retain,atomic) UILabel *lblTelNumber;
    @property(retain,atomic) UICollectionView *collectionView;
    @end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _models = [NSMutableArray arrayWithCapacity:0];
    [self addCollectionView];
    [self addCallButton];
    GoodsCategoryModel *model1 = [GoodsCategoryModel new];
    model1.name = @"废纸";
    [_models addObject:model1];
    
    
    GoodsCategoryModel *model2 = [GoodsCategoryModel new];
    model2.name = @"废塑料";
    [_models addObject:model2];
    
    GoodsCategoryModel *model3 = [GoodsCategoryModel new];
    model3.name = @"废品车辆";
    [_models addObject:model3];
    
    GoodsCategoryModel *model4 = [GoodsCategoryModel new];
    model4.name = @"小家电";
    [_models addObject:model4];
    
    GoodsCategoryModel *model5 = [GoodsCategoryModel new];
    model5.name = @"电视机";
    [_models addObject:model5];
    
    GoodsCategoryModel *model6 = [GoodsCategoryModel new];
    model6.name = @"冰箱";
    [_models addObject:model6];
    
    GoodsCategoryModel *model7 = [GoodsCategoryModel new];
    model7.name = @"空调";
    [_models addObject:model7];
    
    GoodsCategoryModel *model8 = [GoodsCategoryModel new];
    model8.name = @"电脑";
    [_models addObject:model8];
    
    GoodsCategoryModel *model9 = [GoodsCategoryModel new];
    model9.name = @"手机";
    [_models addObject:model9];
    
    GoodsCategoryModel *model10 = [GoodsCategoryModel new];
    model10.name = @"汽车";
    [_models addObject:model10];
}
    
    //-(void) viewWillAppear:(BOOL)animated{
    //    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES];
    //}
    //
    //-(void) viewWillDisappear:(BOOL)animated{
    //    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
    //}
    
-(void) addCallButton{
    UIButton *btnShowCall = [[UIButton alloc] init];
    [btnShowCall setImage:[UIImage imageNamed:@"icon_nav_dh"] forState:UIControlStateNormal];
    [btnShowCall addTarget:self action:@selector(showCallView) forControlEvents:UIControlEventTouchUpInside];
    [btnShowCall setTitle:@"平台" forState:UIControlStateNormal];
    [btnShowCall setTitleColor:[ColorContants userNameFontColor] forState:UIControlStateNormal];
    btnShowCall.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:12];
    btnShowCall.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnShowCall.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btnShowCall.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    btnShowCall.imageEdgeInsets = UIEdgeInsetsMake(0, 0, SizeHeight(20), SizeWidth(-40));
    btnShowCall.contentEdgeInsets = UIEdgeInsetsMake(0, SizeWidth(-20), SizeHeight(5), 0);
    [self.view addSubview:btnShowCall];
    
    [btnShowCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(SizeWidth(-30));
        make.bottom.equalTo(self.view.mas_bottom).offset(SizeHeight(-45));
        make.height.equalTo(@(SizeHeight(52)));
        make.width.equalTo(@(SizeWidth(52)));
    }];
}
    
#pragma UICollection Delegate
    
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return _models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [self setCell:cell withMode:_models[indexPath.row]];
    return cell;
}
    
    
    //设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
    {
        return 7;
    }
    
    
-(void) setCell:(UICollectionViewCell *)cell withMode:(GoodsModel *)model{
    int tag = 1001;
    //    cell.backgroundView = [UIImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
    cell.backgroundColor = [UIColor blueColor];
    UILabel *lblName = [cell viewWithTag:tag];
    
    cell.layer.cornerRadius = SizeHeight(5);
    
    if (lblName == nil) {
        lblName = [[UILabel alloc] init];
        lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
        lblName.textColor = [ColorContants whiteFontColor];
        lblName.textAlignment = NSTextAlignmentCenter;
        lblName.tag = tag;
        [cell addSubview:lblName];
        
        [lblName mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat height = SizeHeight(15);
            make.width.equalTo(cell.mas_width);
            make.height.equalTo(@(height));
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left);
        }];
    }
    
    lblName.text = model.name;
}
    
-(void) addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SizeWidth(113), SizeHeight(113));
    
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, SizeHeight(538/2 + 10));
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}
    
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
    {
        UICollectionReusableView *headerView;
        
        if (indexPath.section == 0) {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1" forIndexPath:indexPath];
            if (headerView.subviews.count == 0) {
                headerView.backgroundColor = [ColorContants gray];
                [self setHeaderView:headerView];
            }
        }else{
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
            headerView.backgroundColor = [ColorContants gray];
            if (headerView.subviews.count == 0) {
                UILabel *lblTitile = [[UILabel alloc] init];
                lblTitile.text = @"回收商品种类";
                lblTitile.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
                lblTitile.textColor = [ColorContants userNameFontColor];
                headerView.backgroundColor = self.collectionView.backgroundColor;
                [headerView addSubview:lblTitile];
                
                [lblTitile mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(headerView.mas_left).offset(16);
                    make.top.equalTo(headerView.mas_top).offset(15);
                    make.bottom.equalTo(headerView.mas_bottom).offset(-15);
                    make.right.equalTo(headerView.mas_right).offset(0);
                }];
            }
        }
        
        return headerView;
    }
    
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.view.bounds.size.width, SizeHeight(538/2 + 10));
    }else{
        return CGSizeMake(self.view.bounds.size.width, 40);;
    }
}
    
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
    {
        if (section == 1) {
            return UIEdgeInsetsMake(0, SizeWidth(10), SizeHeight(10), SizeWidth(10));
        }
        
        return UIEdgeInsetsZero;
    }
    
    //设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
    {
        return SizeWidth(8);
    }
    
    //点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
        RecycleDetailViewController *newViewController = [[RecycleDetailViewController alloc] init];
        [self.navigationController pushViewController:newViewController animated:YES];
    }
    
-(void) setHeaderView:(UICollectionReusableView *) headerView{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height-SizeHeight(10))];
    header.image = [UIImage imageNamed:@"sgd_bg_sy"];
    
    [headerView addSubview:header];
    
    UIButton *btnMessage = [[UIButton alloc] init];
    [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
    [btnMessage addTarget:self action:@selector(tapMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:btnMessage];
    [btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(SizeHeight(31.5));
        make.leading.equalTo(headerView.mas_leading).offset(SizeWidth(16));
        make.width.equalTo(@(SizeWidth(22)));
        make.height.equalTo(@(SizeHeight(19)));
    }];
    
    UIButton *btnSetting = [[UIButton alloc] init];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(tapMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:btnSetting];
    [btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(SizeHeight(30));
        make.right.equalTo(headerView.mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(20.4)));
        make.height.equalTo(@(SizeHeight(22)));
    }];
    
    
    UIButton *btnCheck = [[UIButton alloc] init];
    [btnCheck setTitle:@"点击查看" forState:UIControlStateNormal];
    [btnCheck setTitleColor:[ColorContants orange] forState:UIControlStateNormal];
    btnCheck.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:11];
    btnCheck.layer.borderColor = [ColorContants orange].CGColor;
    btnCheck.layer.borderWidth = 1;
    btnCheck.layer.cornerRadius = SizeHeight(9.5);
    
    [btnCheck addTarget:self action:@selector(tapCheckButton) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:btnCheck];
    [btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headerView.mas_bottom).offset(SizeHeight(-27));
        make.centerX.equalTo(headerView.mas_centerX).offset(SizeWidth(38));
        make.width.equalTo(@(SizeWidth(73)));
        make.height.equalTo(@(SizeHeight(19)));
    }];
    
    _lblIntegral  = [[UILabel alloc] init];
    [self setIntergral:@"1000"];
    _lblIntegral.textAlignment = NSTextAlignmentRight;
    _lblIntegral.userInteractionEnabled = YES;
    [headerView addSubview:_lblIntegral];
    
    UITapGestureRecognizer *tapIntegral = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIntegralDetail:)];
    tapIntegral.numberOfTapsRequired = 1;
    [_lblIntegral addGestureRecognizer:tapIntegral];
    
    
    [_lblIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnCheck.mas_centerY).offset(0);
        make.width.equalTo(@(SizeHeight(100)));
        make.right.equalTo(btnCheck.mas_left).offset(SizeWidth(-30));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    UILabel *lblTag  = [[UILabel alloc] init];
    lblTag.text = @"回收点";
    lblTag.textColor = [ColorContants red];
    lblTag.textAlignment = NSTextAlignmentCenter;
    lblTag.layer.borderColor = [ColorContants red].CGColor;
    lblTag.layer.borderWidth = 1;
    lblTag.layer.cornerRadius = SizeHeight(7);
    lblTag.font = [UIFont fontWithName:[FontConstrants pingFang] size:11];
    [headerView addSubview:lblTag];
    
    [lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btnCheck.mas_centerX).offset(0);
        make.bottom.equalTo(btnCheck.mas_top).offset(SizeWidth(-26));
        make.height.equalTo(@(SizeHeight(14)));
        make.width.equalTo(@(SizeWidth(44)));
        
    }];
    
    _lblTelNumber  = [[UILabel alloc] init];
    _lblTelNumber.text = @"18192061844";
    _lblTelNumber.textAlignment = NSTextAlignmentCenter;
    _lblTelNumber.textColor = [ColorContants phoneNumerFontColor];
    _lblTelNumber.font = [UIFont fontWithName:[FontConstrants helveticaNeue] size:13];
    [headerView addSubview:_lblTelNumber];
    
    [_lblTelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblTag.mas_left).offset(SizeWidth(5));
        make.centerY.equalTo(lblTag.mas_centerY);
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(lblTag.mas_height);
    }];
    
    _lblName  = [[UILabel alloc] init];
    _lblName.text = @"我只是个名字";
    _lblName.textAlignment = NSTextAlignmentCenter;
    
    _lblName.textColor = [ColorContants userNameFontColor];
    _lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    [headerView addSubview:_lblName];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.bottom.equalTo(_lblTelNumber.mas_top).offset(SizeHeight(-13));
        make.width.equalTo(@(SizeWidth(300)));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    
    _avatar  = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"mrtx144"];
    [headerView addSubview:_avatar];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX).offset(0);
        make.bottom.equalTo(_lblName.mas_top).offset(SizeHeight(-36));
        make.width.equalTo(@(SizeWidth(72)));
        make.height.equalTo(@(SizeHeight(72)));
    }];
}
    
-(void) setIntergral:(NSString *) strIntegral{
    UIFont *font1 = [UIFont fontWithName:[FontConstrants helveticaNeue] size:15];
    UIFont *font2 = [UIFont fontWithName:[FontConstrants pingFang] size:12];
    _lblIntegral.attributedText = [NSMutableAttributedString attributeString:strIntegral prefixFont:font1 prefixColor:[ColorContants orange] suffixString:@" 积分" suffixFont:font2 suffixColor:[ColorContants orange] ];
    [_lblIntegral sizeToFit];
}
    
-(void) addGoodsList{
    
}
    
-(void) tapMessageButton{
    
}
    
-(void) tapSettingButton{
    
}
    
-(void) tapCheckButton{
    
}
    
-(void) showCallView{
    [PublicClass showCallPopupWithTelNo:@"400-800-2123" inViewController:self];
}
    
-(void) showIntegralDetail:(UITapGestureRecognizer *) sender{
    IntegalViewController *newViewController = [[IntegalViewController alloc] init];
    [self.navigationController pushViewController:newViewController animated:YES];
    
}
    @end
