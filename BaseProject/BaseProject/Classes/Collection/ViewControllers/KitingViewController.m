//
//  KitingViewController.m
//  BaseProject
//
//  Created by LeoGeng on 28/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "KitingViewController.h"
#import "Constants.h"
#import "BankCardModel.h"
#import "KitingModel.h"
#import "KitingCell.h"
#import "BankCardCell.h"
#import "BankCarInfoViewController.h"

@interface KitingViewController ()
@property(retain,atomic) NSMutableArray *models;
@property(retain,atomic) BankCardModel *bankCard;
@property(retain,atomic) UIScrollView *scrollView;
@property(retain,atomic) UIView *bankCardView;
@property(retain,atomic) UILabel *lblIntergal;
@property(retain,atomic)  UICollectionView *collectionView;
@property(nonatomic,assign)  NSInteger selectIndex;
@end

@implementation KitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"提现"];
    [self addCollectionView];
    [self addSubviews];
    _selectIndex = -1;
    _models = [NSMutableArray arrayWithCapacity:0];
    
    KitingModel *model1 = [KitingModel new];
    model1.money = 102;
    model1.integral = 100;
    [_models addObject:model1];
    
    KitingModel *model2 = [KitingModel new];
    model2.money = 102;
    model2.integral = 102;
    [_models addObject:model2];
    
    KitingModel *model3 = [KitingModel new];
    model3.money = 102;
    model3.integral = 102;
    [_models addObject:model3];
    
    KitingModel *model4 = [KitingModel new];
    model4.money = 102;
    model4.integral = 102;
    [_models addObject:model4];
    
    KitingModel *model5 = [KitingModel new];
    model5.money = 102;
    model5.integral = 102;
    [_models addObject:model5];
    
    
}

-(void) addSubviews{
    UIButton *btnKiting = [[UIButton alloc] init];
    btnKiting.backgroundColor = [ColorContants BlueButtonColor];
    [btnKiting setTitle:@"提现" forState:UIControlStateNormal];
    [btnKiting setTitleColor:[ColorContants whiteFontColor] forState:UIControlStateNormal];
    btnKiting.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:16];
    
    [btnKiting addTarget:self action:@selector(tapKitingButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnKiting];
    [btnKiting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(SizeHeight(-20));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(SizeWidth(690/2)));
        make.height.equalTo(@(SizeHeight(40)));
    }];
    
    _lblIntergal = [[UILabel alloc] init];
    _lblIntergal.font = [UIFont fontWithName:[FontConstrants pingFang] size:13];
    _lblIntergal.textColor = [ColorContants phoneNumerFontColor];
    _lblIntergal.textAlignment = NSTextAlignmentLeft;
    _lblIntergal.text = @"我的积分：1000";
    [self.view addSubview:_lblIntergal];
    
    [_lblIntergal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btnKiting.mas_top).offset(SizeHeight(-25));
        make.left.equalTo(btnKiting.mas_left).offset(SizeWidth(-5));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(13)));
    }];
//    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SizeHeight(64));
        make.bottom.equalTo(_lblIntergal.mas_top).offset(SizeHeight(-20));
        make.left.equalTo(self.view.mas_left).offset(SizeWidth(10));
        make.right.equalTo(self.view.mas_right).offset(SizeWidth(-10));
    }];
}

-(void) addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[BankCardCell class] forCellWithReuseIdentifier:@"cell"];
     [_collectionView registerClass:[KitingCell class] forCellWithReuseIdentifier:@"KitingCell"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return UIEdgeInsetsMake(0, SizeWidth(0), 0, SizeWidth(0));
    }
    
    return UIEdgeInsetsZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return SizeWidth(11);
    }
    
    return  0;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && _selectIndex >=0) {
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:_selectIndex inSection:1 ];
        [UIView animateWithDuration:0 animations:^{
            [collectionView performBatchUpdates:^{
                [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:newIndex]];
            } completion:nil];
        }];
        
        [UIView animateWithDuration:0 animations:^{
            [collectionView performBatchUpdates:^{
                [collectionView selectItemAtIndexPath:newIndex animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            } completion:nil];
        }];
        
        return NO;
    }else{
        return YES;
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    }else{
        _selectIndex = indexPath.row;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    return _models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
    if (indexPath.section == 0) {
       cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        if (cell.subviews.count < 3) {
            [self setCell:cell];
        }
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KitingCell" forIndexPath:indexPath];
        ((KitingCell *) cell).model = _models[indexPath.row];
    }
    
    return cell;
}

-(void) setCell:(UICollectionViewCell *) cell{
    _bankCardView = [UIView new];
    _bankCardView.backgroundColor = [ColorContants gray];
    _bankCardView.layer.cornerRadius = 5;
    [cell addSubview:_bankCardView];
    
    [_bankCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.mas_centerX);
        make.top.equalTo(cell.mas_top).offset(SizeHeight(10));
        make.height.equalTo(@(SizeHeight(164/2)));
        make.width.equalTo(@(SizeHeight(710/2)));
    }];
    
    UIButton *btnAdd = [[UIButton alloc] init];
    [btnAdd setTitle:@"新增银行卡" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor colorWithHexString:@"#379ff2"] forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    
    [btnAdd addTarget:self action:@selector(addNewBankCard) forControlEvents:UIControlEventTouchUpInside];
    
    [_bankCardView addSubview:btnAdd];
    [btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bankCardView.mas_centerY);
        make.centerX.equalTo(_bankCardView.mas_centerX);
        make.width.equalTo(@(SizeWidth(100)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    
    _bankCard = [BankCardModel new];
    _bankCard.cardNumber = @"**** **** **** 1177";
    _bankCard.bankName = @"招商银行";
    _bankCard.userName = @"招商银行";
    [self setBankCard:_bankCard];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat kitingCellHeight = SizeHeight(72);
    if (indexPath.section == 0) {
        CGFloat count = ceil(((CGFloat)_models.count)/3);
        CGFloat height  = 0;
        if (count > 0) {
            height = collectionView.bounds.size.height - count * kitingCellHeight - (count - 1) * SizeHeight(15);
        }
        
        height = SizeHeight(82) < height ? height : SizeHeight(82);
        return  CGSizeMake(collectionView.bounds.size.width, height);
    }else{
        return CGSizeMake(SizeWidth(111), kitingCellHeight);
    }
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return SizeHeight(15);
    }
    return 0;
}

-(void) addKitingCell:(KitingModel *) model{
    
}

-(void) addNewBankCard{
    BankCarInfoViewController *newViewController = [BankCarInfoViewController new];
    [self.navigationController pushViewController:newViewController animated:YES];
}

-(void) tapKitingButton{
    KitingModel *mode = _models[_selectIndex];
    
    if (self.integral > mode.integral) {
        
    }
}

-(void) setBankCard:(BankCardModel *) bankCard{
    _bankCardView.backgroundColor = [ColorContants bankCardColor];
    for (UIView *v in _bankCardView.subviews) {
        [v removeFromSuperview];
        [v setHidden:YES];
    }
    
    UILabel *cardName = [[UILabel alloc] init];
    cardName.font = [UIFont fontWithName:[FontConstrants pingFang] size:15];
    cardName.textColor = [ColorContants whiteFontColor];
    cardName.textAlignment = NSTextAlignmentLeft;
    cardName.text = bankCard.bankName;
    [_bankCardView addSubview:cardName];
    
    [cardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankCardView.mas_top).offset(SizeHeight(20));
        make.left.equalTo(_bankCardView.mas_left).offset(SizeWidth(15));
        make.width.equalTo(@(SizeWidth(200)));
        make.height.equalTo(@(SizeHeight(15)));
    }];
    
    UILabel *cardNumber = [[UILabel alloc] init];
    cardNumber.font = [UIFont fontWithName:[FontConstrants helveticaNeue] size:17];
    cardNumber.textColor = [ColorContants whiteFontColor];
    cardNumber.textAlignment = NSTextAlignmentRight;
    cardNumber.text = bankCard.cardNumber;
    [_bankCardView addSubview:cardNumber];
    
    [cardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bankCardView.mas_right).offset(SizeWidth(-20));
        make.bottom.equalTo(_bankCardView.mas_bottom).offset(SizeHeight(-15));
        make.width.equalTo(@(SizeWidth(400)));
        make.height.equalTo(@(SizeHeight(17)));
    }];
    
    UIButton *btnEdit = [[UIButton alloc] init];
    btnEdit.backgroundColor = [ColorContants BlueFontColor];
    [btnEdit setBackgroundImage:[UIImage imageNamed:@"tx_icon_bj"] forState:UIControlStateNormal];
    [btnEdit addTarget:self action:@selector(gotoEditView) forControlEvents:UIControlEventTouchUpInside];
    
    [_bankCardView addSubview:btnEdit];
    
    [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bankCardView.mas_right).offset(SizeWidth(-20));
        make.top.equalTo(_bankCardView.mas_top).offset(SizeHeight(10));
        make.width.equalTo(@(SizeWidth(27/2)));
        make.height.equalTo(@(SizeHeight(34/2)));
    }];
}

-(void) gotoEditView{
    BankCarInfoViewController *newViewController = [BankCarInfoViewController new];
    [self.navigationController pushViewController:newViewController animated:YES];
    newViewController.model = _bankCard;

}

@end
