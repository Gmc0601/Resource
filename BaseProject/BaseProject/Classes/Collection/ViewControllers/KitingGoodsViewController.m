//
//  KitingViewController.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingGoodsViewController.h"
#import "Constants.h"
#import "KitingGoodsModel.h"
#import "KitingGoodCell.h"
#import "PublicClass.h"
#import "KitingGoodsRecordViewController.h"
#import <PopupDialog/PopupDialog-Swift.h>
@interface KitingGoodsViewController ()
@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic) UILabel *lblIntergal;
@property(retain,atomic)  UICollectionView *collectionView;
@end

@implementation KitingGoodsViewController
-(void) setIntegral:(int)integral{
    _integral = integral;
    _lblIntergal.text = [NSString stringWithFormat:@"%d",integral];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"积分兑换"];
    [self addCollectionView];
    _models = [NSMutableArray arrayWithCapacity:0];
    [PublicClass setRightTitleOnTargetNav:self action:@selector(gotoRecord) Title:@"兑换记录"];
    
    [self loadKitingGoodsList];
}

-(void) addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, SizeHeight(74));
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self getNavBarHeight], self.view.bounds.size.width, self.view.bounds.size.height - [self getNavBarHeight]) collectionViewLayout:layout];
    [_collectionView registerClass:[KitingGoodCell class] forCellWithReuseIdentifier:@"cell"];
     [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return  SizeWidth(4);
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KitingGoodsModel *mode = _models[indexPath.row];
    PopupDialog *popup = [[PopupDialog alloc] initWithTitle:@""
                                                    message:@"兑换会减掉相应的积分哟\n确定兑换码？"
                                                      image:nil
                                            buttonAlignment:UILayoutConstraintAxisHorizontal
                                            transitionStyle:PopupDialogTransitionStyleBounceUp
                                           gestureDismissal:YES
                                                 completion:nil];

    PopupDialogDefaultViewController *popupViewController = (PopupDialogDefaultViewController *)popup.viewController;
    
    popupViewController.messageColor = [ColorContants userNameFontColor];
    popupViewController.messageFont = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(15)];
    
    
    CancelButton *cancel = [[CancelButton alloc] initWithTitle:@"取消" height:50 dismissOnTap:NO action:^{
        [popup dismiss:^{
            
        }];
    }];
    
    cancel.titleColor = popupViewController.titleColor;
    
    DefaultButton *ok = [[DefaultButton alloc] initWithTitle:@"确认" height:50 dismissOnTap:NO action:^{
        [self kiting:mode];
        [popup dismiss:^{
            
        }];
    }];
    
    ok.titleColor = popupViewController.titleColor;
    
    [popup addButtons: @[cancel,ok]];
    
    [self presentViewController:popup animated:YES completion:nil];
}

-(void) kiting:(KitingGoodsModel *) model{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    [params setObject:model._id forKey:@"id"];
    [ConfigModel showHud:self];
    
    [HttpRequest postPath:@"_exchangegood_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
        NSString *info = datadic[@"info"];
        
        if ([datadic[@"error"] intValue] == 0) {
            self.integral = self.integral - model.needIntergal.intValue;
            _lblIntergal.text = [NSString stringWithFormat:@"%d",self.integral];
            [ConfigModel mbProgressHUD:@"操作成功" andView:self.view];
        }else{
            [ConfigModel mbProgressHUD:@"操作失败" andView:self.view];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ((KitingGoodCell *) cell).model = _models[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(SizeWidth(338/2), SizeHeight(179));
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, SizeWidth(15), 0, SizeWidth(15));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];;
    
    if (header.subviews.count < 1) {
        header.backgroundColor = [UIColor whiteColor];
        UIView *subView = [UIView new];
        subView.backgroundColor = [ColorContants gray];
        subView.layer.cornerRadius = SizeHeight(3);
        [header addSubview:subView];
        
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(SizeHeight(10));
            make.bottom.equalTo(header.mas_bottom).offset(SizeHeight(-10));
            make.centerX.equalTo(header.mas_centerX);
            make.width.equalTo(@(SizeWidth(710/2)));
        }];
        
        UIView *border1 = [UIView new];
        border1.backgroundColor = [ColorContants otherFontColor];
        [header addSubview:border1];
        
        [border1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(header.mas_bottom);
            make.centerX.equalTo(header.mas_centerX);
            make.width.equalTo(subView.mas_width);
            make.height.equalTo(@(SizeHeight(1)));
        }];

        
        UILabel *lblMsg = [[UILabel alloc] init];
        lblMsg.font = [UIFont fontWithName:[FontConstrants pingFang] size:SizeWidth(12)];
        lblMsg.textColor = [ColorContants userNameFontColor];
        lblMsg.textAlignment = NSTextAlignmentRight;
        lblMsg.text = @"我的积分:";
        [header addSubview:lblMsg];
        
        [lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.right.equalTo(header.mas_centerX);
            make.width.equalTo(@(SizeWidth(100)));
            make.height.equalTo(@(SizeHeight(12)));
        }];
        
        _lblIntergal = [[UILabel alloc] init];
        _lblIntergal.font = [UIFont fontWithName:[FontConstrants helveticaNeue] size:SizeWidth(18)];
        _lblIntergal.textColor = [ColorContants userNameFontColor];
        _lblIntergal.textAlignment = NSTextAlignmentLeft;
        _lblIntergal.text = [NSString stringWithFormat:@"%d",_integral];
        [header addSubview:_lblIntergal];
        
        [_lblIntergal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(header.mas_centerX).offset(SizeWidth(2));
            make.width.equalTo(@(SizeWidth(150)));
            make.height.equalTo(@(SizeHeight(18)));
        }];

    }
    
    return header;
}

-(void) gotoRecord{
    KitingGoodsRecordViewController *newViewController = [KitingGoodsRecordViewController new];
    
    [self.navigationController pushViewController:newViewController animated:YES];
}

-(void) loadKitingGoodsList{
    [ConfigModel showHud:self];
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [params setObject:userTokenStr forKey:@"userToken"];
    
    [HttpRequest postPath:@"_exchangegoodlist_001" params:params resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:self];
        NSDictionary *datadic = responseObject;
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

@end
