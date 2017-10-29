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
#import "RegisterInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "GoodsListViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "PersonMessageViewController.h"
#import "KitingGoodCell.h"

@interface HomeViewController ()<KitingGoodCellDelegate>
@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic) UILabel *lblIntegral;
@property(retain,atomic) UILabel *lblName;
@property(retain,atomic) UIImageView *avatar;
@property(retain,atomic) UILabel *lblTelNumber;
@property(retain,atomic) UICollectionView *collectionView;
@property(retain,atomic) UIView *backgroundView;
@property(retain,atomic) UIButton *btnMessage;
@property(retain,atomic) UIButton *btnSetting;
@property(retain,atomic) UserModel *user;
@property(retain,atomic) NSString *strTel;
@property(retain,atomic) NSString *weight;
@property(retain,atomic)  UIButton *btnRecycle;
@property(retain,atomic)  UIButton *btnOrderAndKitting;
@property(retain,atomic)  UIView *blueBorder;
@property(assign,atomic)  BOOL isKitting;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _models = [NSMutableArray arrayWithCapacity:0];
    [self addCollectionView];
    [self addSubviews];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getTelNum];
    if (_isKitting) {
        [self loadKitingGoodsList];
    }else{
        [self loadRecycleData];
    }
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
}

-(void) addSubviews{
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), [self getNavBarHeight])];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.alpha  = 0;
    [self.view addSubview:_backgroundView];
    
    _btnMessage = [[UIButton alloc] init];
    [_btnMessage setImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
    [_btnMessage addTarget:self action:@selector(tapMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:_btnMessage];
    [_btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view .mas_top).offset(SizeHeight(31.5));
        make.leading.equalTo(self.view .mas_leading).offset(SizeWidth(16));
        make.width.equalTo(@(SizeWidth(22)));
        make.height.equalTo(@(SizeHeight(19)));
    }];
    
    _btnSetting = [[UIButton alloc] init];
    [_btnSetting setImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
    [_btnSetting addTarget:self action:@selector(tapSettingButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:_btnSetting];
    [_btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view .mas_top).offset(SizeHeight(30));
        make.right.equalTo(self.view .mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(20.4)));
        make.height.equalTo(@(SizeHeight(22)));
    }];
    
    [_btnMessage setImage:[UIImage imageNamed:@"icon_tab_zxh"] forState:UIControlStateHighlighted];
    [_btnSetting setImage:[UIImage imageNamed:@"grzx_icon_szh"] forState:UIControlStateHighlighted];
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
    UICollectionViewCell *cell;
    if (_isKitting) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kittingGoodCell" forIndexPath:indexPath];
        ((KitingGoodCell *) cell).model = _models[indexPath.row];
        ((KitingGoodCell *) cell).delegate = self;
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self setCell:cell withMode:_models[indexPath.row]];
        
    }
    
    
    return cell;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return SizeHeight(7);
}


-(void) setCell:(UICollectionViewCell *)cell withMode:(GoodsModel *)model{
    int tag = 1001;
    UIImageView *bg = [UIImageView new];
    [bg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        cell.backgroundView = bg;
    }];
    
    UILabel *lblName = [cell viewWithTag:tag];
    
    cell.layer.cornerRadius = SizeHeight(5);
    
    if (lblName == nil) {
        UIView *bgView = [[UIView alloc] initWithFrame:cell.bounds];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#61000000"];
        bgView.layer.cornerRadius = SizeWidth(10);
        bgView.alpha = 0.49;
        [cell addSubview:bgView];
        
        lblName = [[UILabel alloc] init];
        lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
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
    
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, SizeHeight(538/2 + 23));
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[KitingGoodCell class] forCellWithReuseIdentifier:@"kittingGoodCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    ((UIScrollView *) _collectionView).delegate = self;
    
    [self.view addSubview:self.collectionView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isKitting) {
        return CGSizeMake(SizeWidth(338/2), SizeHeight(222));
    }else{
        return CGSizeMake(SizeWidth(113), SizeHeight(113));
    }
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
        
        return headerView;
    }
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2" forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
    
    if (header.subviews.count > 1) {
        return header;
    }
    
    header.backgroundColor = [ColorContants gray];
    CGFloat width = SizeWidth(139);
    CGFloat margin = SizeWidth(87.5);
    
    _btnRecycle = [[UIButton alloc]init];
    [_btnRecycle setTitle:@"回收再生资源区" forState:UIControlStateNormal];
    [_btnRecycle setTitleColor:[ColorContants phoneNumerFontColor] forState:UIControlStateNormal] ;
//    [_btnRecycle setTitleColor:[ColorContants BlueFontColor] forState:UIControlStateSelected];
    _btnRecycle.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    _btnRecycle.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_btnRecycle addTarget:self action:@selector(tapRecycleButton) forControlEvents:UIControlEventTouchUpInside];
    [_btnRecycle setSelected:YES];
    [header addSubview:_btnRecycle];
    
    [_btnRecycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.mas_centerY);
        make.centerX.equalTo(header.mas_centerX).offset(-margin);
        make.height.equalTo(header.mas_height);
        make.width.equalTo(@(width));
    }];
    
    _btnOrderAndKitting = [[UIButton alloc]init];
    [_btnOrderAndKitting setTitle:@"订购兑换区" forState:UIControlStateNormal];
    [_btnOrderAndKitting setTitleColor:[ColorContants phoneNumerFontColor] forState:UIControlStateNormal] ;
//    [_btnOrderAndKitting setTitleColor:[ColorContants BlueFontColor] forState:UIControlStateSelected];
    _btnOrderAndKitting.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    _btnOrderAndKitting.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_btnOrderAndKitting addTarget:self action:@selector(tapOrderAndKittingButton) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:_btnOrderAndKitting];
    
    [_btnOrderAndKitting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header.mas_centerY);
        make.centerX.equalTo(header.mas_centerX).offset(margin);
        make.height.equalTo(header.mas_height);
        make.width.equalTo(@(width));
    }];
    
    UIView *border = [[UIView alloc] init];
    border.backgroundColor = [ColorContants integralSeperatorColor];
    [header addSubview:border];
    
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.right.equalTo(header.mas_right);
        make.bottom.equalTo(header.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    _blueBorder = [[UIView alloc] init];
    _blueBorder.backgroundColor = [ColorContants BlueFontColor];
    [header addSubview:_blueBorder];
    _blueBorder.frame = CGRectMake(0, 0, SizeWidth(278/2), SizeHeight(1.5));
    _blueBorder.center = CGPointMake(self.view.center.x - margin, SizeHeight(42)-SizeHeight(0));
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.view.bounds.size.width, SizeHeight(538/2 + 10));
    }else{
        return CGSizeMake(self.view.bounds.size.width, SizeHeight(53));;
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
    if (_isKitting) {
        return;
    }
    
    GoodsListViewController *newViewController = [[GoodsListViewController alloc] init];
    newViewController.goodListID = ((GoodsModel *)_models[indexPath.row])._id;
    newViewController.titleListStr =  ((GoodsModel *)_models[indexPath.row]).name;
    [self.navigationController pushViewController:newViewController animated:YES];
}

-(void) setHeaderView:(UICollectionReusableView *) headerView{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height-SizeHeight(10))];
    header.image = [UIImage imageNamed:@"sgd_bg_sy"];
    
    [headerView addSubview:header];
    
    
    UIButton *btnCheck = [[UIButton alloc] init];
    [btnCheck setTitle:@"点击查看" forState:UIControlStateNormal];
    [btnCheck setTitleColor:[ColorContants orange] forState:UIControlStateNormal];
    btnCheck.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(11)];
    btnCheck.layer.borderColor = [ColorContants orange].CGColor;
    btnCheck.layer.borderWidth = 1;
    btnCheck.layer.cornerRadius = SizeHeight(9.5);
    
    [btnCheck addTarget:self action:@selector(showIntegralDetail) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    //    UITapGestureRecognizer *tapIntegral = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIntegralDetail:)];
    //    tapIntegral.numberOfTapsRequired = 1;
    //    [_lblIntegral addGestureRecognizer:tapIntegral];
    
    
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
    lblTag.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(11)];
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
    _lblTelNumber.font = [UIFont fontWithName:[FontConstrants helveticaNeue] size:SizeWidth(13)];
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
    _lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    [headerView addSubview:_lblName];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.bottom.equalTo(_lblTelNumber.mas_top).offset(SizeHeight(-13));
        make.width.equalTo(@(SizeWidth(300)));
        make.height.equalTo(@(SizeHeight(14)));
    }];
    
    
    _avatar  = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"mrtx144"];
    _avatar.userInteractionEnabled = YES;
    _avatar.layer.cornerRadius = SizeWidth(72/2);
    _avatar.clipsToBounds = YES;
    [headerView addSubview:_avatar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPersonMessBtn)];
    tap.numberOfTapsRequired = 1;
    [_avatar addGestureRecognizer:tap];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX).offset(0);
        make.bottom.equalTo(_lblName.mas_top).offset(SizeHeight(-36));
        make.width.equalTo(@(SizeWidth(72)));
        make.height.equalTo(@(SizeHeight(72)));
    }];
}

-(void) setIntergral:(NSString *) strIntegral{
    UIFont *font1 = [UIFont fontWithName:[FontConstrants helveticaNeue] size:SizeWidth(15)];
    UIFont *font2 = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
    _lblIntegral.attributedText = [NSMutableAttributedString attributeString:strIntegral prefixFont:font1 prefixColor:[ColorContants orange] suffixString:@" 积分" suffixFont:font2 suffixColor:[ColorContants orange] ];
    [_lblIntegral sizeToFit];
}

-(void) tapMessageButton{
    MessageViewController *personMessVC = [[MessageViewController alloc ] init];
    [self.navigationController pushViewController:personMessVC animated:YES];
}

-(void) tapSettingButton{
    SettingViewController  *setVC = [[SettingViewController alloc] init];
    setVC.from = Home_Setting;
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void) showCallView{
    [PublicClass showCallPopupWithTelNo:_strTel withWeight:_weight inViewController:self];
}

-(void) showIntegralDetail{
    IntegalViewController *newViewController = [[IntegalViewController alloc] init];
    newViewController.integral = _user.integral;
    [self.navigationController pushViewController:newViewController animated:YES];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self changeBackground:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self changeBackground:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self changeBackground:scrollView];
}

-(void) changeBackground:(UIScrollView *) scrollView{
    if (scrollView.contentOffset.y > SizeHeight(80)) {
        [UIView animateWithDuration:0.5 animations:^{
            _backgroundView.alpha = 1;
            [_btnMessage setHighlighted:YES];
            [_btnSetting setHighlighted:YES];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _backgroundView.alpha = 0;
            [_btnMessage setHighlighted:NO];
            [_btnSetting setHighlighted:NO];
        }];
    }
}

-(void) loadRecycleData{
    NSMutableDictionary *params = [NSMutableDictionary new];
    //    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    //    [params setObject:userTokenStr forKey:@"userToken"];
    [ConfigModel showHud:self];
    
    [HttpRequest postPath:@"_homepage_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        _models = [NSMutableArray arrayWithCapacity:0];
        
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            NSDictionary *userInfo = infoDic[@"userinfo"];
            
            _user = [UserModel new];
            _user.name =  userInfo[@"nickname"];
            [ConfigModel saveString:_user.name forKey:NickName];
            _user.avatarUrl =  userInfo[@"avatar_url"];
            [ConfigModel saveString:_user.avatarUrl forKey:HeadImage];
            _user.telNumber =  userInfo[@"mobile"];
            _user.type =  userInfo[@"user_type"];
            if (userInfo[@"integral"] == nil) {
                _user.integral = @"0";
            }else{
                _user.integral =  userInfo[@"integral"];
            }
            
            NSDictionary *goodsList = infoDic[@"goodlist"];
            for (NSDictionary *dict in goodsList) {
                GoodsModel *model = [GoodsModel new];
                model._id = dict[@"id"];
                model.name = dict[@"good"];
                model.imgUrl = dict[@"img"];
                model.sequence = [dict[@"sort_num"] intValue];
                
                [_models addObject:model];
            }
            
            [_models sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                GoodsModel *model1 = (GoodsModel *) obj1;
                GoodsModel *model2 = (GoodsModel *) obj2;
                return model1.sequence > model2.sequence;
            }];
            
            [self setUser:_user];
            [_collectionView reloadData];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
}

-(void) setUser:(UserModel *) user{
    _lblName.text = user.name;
    _lblTelNumber.text = user.telNumber;
    [self setIntergral:user.integral];
    [_avatar sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageNamed:@"mrtx144"]];
}

-(void) getTelNum{
    NSMutableDictionary *params = [NSMutableDictionary new];
    //    [params setObject:@"5" forKey:@"real_id"];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    
    [HttpRequest postPath:@"_setinfo_001" params:params resultBlock:^(id responseObject, NSError *error) {
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            _strTel = infoDic[@"phone"];
            _weight = infoDic[@"number"];
            [PublicClass addCallButtonInViewContrller:self];
        }
        NSLog(@"error>>>>%@", error);
    }];
}

- (void)pushPersonMessBtn{
    
    PersonMessageViewController *personMessVC = [[PersonMessageViewController alloc ] init];
    personMessVC.protraitImage = _avatar.image;
    [self.navigationController pushViewController:personMessVC animated:YES];
}

-(void) getIntegral{
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    //        [ConfigModel showHud:self];
    
    [HttpRequest postPath:@"_usernum_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            [self setIntergral:infoDic[@"jifen"]];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
}

-(void) tapRecycleButton{
    _isKitting = NO;
    [_btnRecycle setSelected:YES];
    [_btnOrderAndKitting setSelected:NO];
    [self addConstraintsForHightlight:_btnRecycle];
    [self loadRecycleData];
}

-(void) tapOrderAndKittingButton{
    _isKitting = YES;
    [_btnRecycle setSelected:NO];
    [_btnOrderAndKitting setSelected:YES];
    [self addConstraintsForHightlight:_btnOrderAndKitting];
    [self loadKitingGoodsList];
}


-(void) addConstraintsForHightlight:(UIView *) center{
    _blueBorder.center = CGPointMake(center.center.x, center.superview.bounds.size.height-SizeHeight(13));
}

-(void) loadKitingGoodsList{
    [ConfigModel showHud:self];
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    
    [HttpRequest postPath:@"_exchangegoodlist_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        _models = [NSMutableArray arrayWithCapacity:0];
        
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            for (NSDictionary *dict in infoDic) {
                KitingGoodsModel *model = [KitingGoodsModel new];
                model.needIntergal = dict[@"num"];
                model.name = dict[@"name"];
                model.imgUrl = dict[@"img"];
                model._id = dict[@"id"];
                [_models addObject:model];
            }
            
            [_models sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                KitingGoodsModel *model1 = (KitingGoodsModel *) obj1;
                KitingGoodsModel *model2 = (KitingGoodsModel *) obj2;
                return model1.sequence < model2.sequence;
            }];
            
            [_collectionView reloadData];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
    }];
}

-(void) didSelectKittingId:(NSString *)_id isKitting:(BOOL)isKitting{
    NSString *title = @"积分兑换";
    NSString *message = @"兑换积分会减掉相应的积分";
    if (!isKitting) {
        title = @"订购";
        message = @"订购商品线下付款";
    }
    PopupDialog *popup = [[PopupDialog alloc] initWithTitle:title
                                                    message:message
                                                      image:nil
                                            buttonAlignment:UILayoutConstraintAxisHorizontal
                                            transitionStyle:PopupDialogTransitionStyleBounceUp
                                           gestureDismissal:YES
                                                 completion:nil];
    
    PopupDialogDefaultViewController *popupViewController = (PopupDialogDefaultViewController *)popup.viewController;
    
    

    popupViewController.messageColor = [ColorContants userNameFontColor];
    popupViewController.messageFont = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    
    PopupDialogDefaultView *dialogAppearance = [PopupDialogDefaultView appearance];
    dialogAppearance.titleFont            = [UIFont fontWithName:[FontConstrants pingFangBold] size:SizeWidth(18)];
    dialogAppearance.titleColor           = [ColorContants userNameFontColor];
    dialogAppearance.messageFont          = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    dialogAppearance.messageColor         = [ColorContants kitingFontColor];
    
    CancelButton *cancel = [[CancelButton alloc] initWithTitle:@"取消" height:50 dismissOnTap:NO action:^{
        [popup dismiss:^{
            
        }];
    }];
    
    cancel.titleColor = popupViewController.titleColor;
    
    DefaultButton *ok = [[DefaultButton alloc] initWithTitle:@"确认" height:50 dismissOnTap:NO action:^{
        [self kiting:_id isKitting:isKitting];
        [popup dismiss:^{
            
        }];
    }];
    
    ok.titleColor = popupViewController.titleColor;
    
    [popup addButtons: @[cancel,ok]];
    
    [self presentViewController:popup animated:YES completion:nil];

}

-(void) kiting:(NSString *) kittingId isKitting:(BOOL) isKitting{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    [params setObject:kittingId forKey:@"id"];
    [params setObject:@"1" forKey:@"good_type"];
    if(!isKitting){
        [params setObject:@"2" forKey:@"good_type"];
    }
    [ConfigModel showHud:self];
    
    [HttpRequest postPath:@"_exchangegood_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        NSString *info = datadic[@"info"];
        
        if ([datadic[@"error"] intValue] == 0) {
            if(isKitting){
                [self setIntergral:[NSString stringWithFormat:@"%@",info]];
            }
            [ConfigModel mbProgressHUD:@"操作成功" andView:self.view];
        }else{
            [ConfigModel mbProgressHUD:@"积分不够" andView:self.view];
        }
    }];
}

@end
