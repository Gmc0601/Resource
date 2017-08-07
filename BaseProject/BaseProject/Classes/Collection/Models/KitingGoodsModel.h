//
//  KitingGoodsModel.h
//  BaseProject
//
//  Created by LeoGeng on 30/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KitingGoodsModel : NSObject
@property(retain,atomic) NSString *_id;
@property(retain,atomic) NSString *imgUrl;
@property(retain,atomic) NSString *name;
@property(retain,atomic) NSString *needIntergal;
@property(assign,nonatomic) int sequence;
@end
