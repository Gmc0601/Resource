//
//  messageModel.m
//  BaseProject
//
//  Created by JeroMac on 2017/8/15.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "messageModel.h"

@implementation messageModel

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"myID"];
        //        self.myID = value;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}



@end
