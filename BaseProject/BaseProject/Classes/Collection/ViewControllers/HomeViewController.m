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

@interface HomeViewController ()
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
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _models = [NSMutableArray arrayWithCapacity:0];
    [self addCollectionView];
    [self addSubviews];
    [self getTelNum];
    [self loadData];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(void) addSubviews{
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.view.bounds), [self getNavBarHeight])];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.alpha  = 0;
    [self.view addSubview:_backgroundView];
    
    _btnMessage = [[UIButton alloc] init];
    [_btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
    [_btnMessage addTarget:self action:@selector(tapMessageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:_btnMessage];
    [_btnMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view .mas_top).offset(SizeHeight(31.5));
        make.leading.equalTo(self.view .mas_leading).offset(SizeWidth(16));
        make.width.equalTo(@(SizeWidth(22)));
        make.height.equalTo(@(SizeHeight(19)));
    }];
    
    _btnSetting = [[UIButton alloc] init];
    [_btnSetting setBackgroundImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
    [_btnSetting addTarget:self action:@selector(tapSettingButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:_btnSetting];
    [_btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view .mas_top).offset(SizeHeight(30));
        make.right.equalTo(self.view .mas_right).offset(SizeWidth(-16));
        make.width.equalTo(@(SizeWidth(20.4)));
        make.height.equalTo(@(SizeHeight(22)));
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
    return _models.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if(_models.count > 0 && (indexPath.row + 1) <= _models.count){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self setCell:cell withMode:_models[indexPath.row]];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"otherCell" forIndexPath:indexPath];
        
        int tag = 30011;
        cell.backgroundColor = [ColorContants gray];
        if ([cell viewWithTag:tag] == nil) {
            UILabel *lblName = [[UILabel alloc] init];
            lblName.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
            lblName.textColor = [ColorContants otherFontColor];
            lblName.textAlignment = NSTextAlignmentCenter;
            lblName.text = @"其他";
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
    layout.itemSize = CGSizeMake(SizeWidth(113), SizeHeight(113));
    
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, SizeHeight(538/2 + 10));
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"otherCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    ((UIScrollView *) _collectionView).delegate = self;
    
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
        headerView.backgroundColor = [UIColor whiteColor];
        if (headerView.subviews.count == 0) {
            UILabel *lblTitile = [[UILabel alloc] init];
            lblTitile.text = @"回收商品种类";
            lblTitile.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
            lblTitile.textColor = [ColorContants userNameFontColor];
            headerView.backgroundColor = self.collectionView.backgroundColor;
            [headerView addSubview:lblTitile];
            
            [lblTitile mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(headerView.mas_left).offset(SizeWidth(16));
                make.top.equalTo(headerView.mas_top).offset(SizeHeight(15));
                make.bottom.equalTo(headerView.mas_bottom).offset(SizeHeight(-15));
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
        return CGSizeMake(self.view.bounds.size.width, SizeHeight(40));;
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
    GoodsListViewController *newViewController = [[GoodsListViewController alloc] init];
    newViewController.goodListID = ((GoodsModel *)_models[indexPath.row])._id;
    newViewController.title =  ((GoodsModel *)_models[indexPath.row]).name;
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

-(void) addGoodsList{
    
}

-(void) tapMessageButton{
    MessageViewController *personMessVC = [[MessageViewController alloc ] init];
    [self.navigationController pushViewController:personMessVC animated:YES];
}

-(void) tapSettingButton{
    SettingViewController  *setVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void) tapCheckButton{
    
}

-(void) showCallView{
    [PublicClass showCallPopupWithTelNo:_strTel inViewController:self];
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

-(void) changeBackground:(UIScrollView *) scrollView{
    if (scrollView.contentOffset.y > SizeHeight(20)) {
        [UIView animateWithDuration:1 animations:^{
            _backgroundView.alpha = 1;
            [_btnMessage setImage:[UIImage imageNamed:@"icon_tab_zxh"] forState:UIControlStateNormal];
            [_btnSetting setImage:[UIImage imageNamed:@"grzx_icon_szh"] forState:UIControlStateNormal];
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            _backgroundView.alpha = 0;
            [_btnMessage setImage:[UIImage imageNamed:@"icon_tab_zx"] forState:UIControlStateNormal];
            [_btnSetting setImage:[UIImage imageNamed:@"grzx_icon_sz"] forState:UIControlStateNormal];
        }];
    }
}

-(void) loadData{
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    [ConfigModel showHud:self];
    
    [HttpRequest postPath:@"_homepage_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            NSDictionary *userInfo = infoDic[@"userinfo"];
            
            _user = [UserModel new];
            _user.name =  userInfo[@"nickname"];
            _user.avatarUrl =  userInfo[@"avatar_url"];
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
                return model1.sequence < model2.sequence;
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

@end
