//
//  UserModel.h
//  BaseProject
//
//  Created by LeoGeng on 23/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(retain,atomic) NSString *name;
@property(retain,atomic) NSString *telNumber;
@property(retain,atomic) NSString *idNumber;
@property(retain,atomic) NSString *purchaseName;
@property(retain,atomic) NSString *purchaseAddress;
@property(retain,atomic) NSString *purchaseDetailAddress;
@property(retain,atomic) NSArray *credentialImages;
@property(retain,atomic) NSString *avatarUrl;
@property(retain,atomic) NSString *integral;
@property(retain,atomic) NSString *type;
@end
