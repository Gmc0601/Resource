//
//  messageModel.h
//  BaseProject
//
//  Created by JeroMac on 2017/8/15.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messageModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *myID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *to_user;

@end
