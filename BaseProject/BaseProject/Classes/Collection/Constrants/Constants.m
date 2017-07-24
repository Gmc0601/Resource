//
//  Constants.m
//  BaseProject
//
//  Created by LeoGeng on 24/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "Constants.h"
#import "UIColor+BGHexColor.h"

@implementation FontConstrants
+(NSString *) pingFang{
    return @"PingFang-SC-Medium";
}

+(NSString *) helveticaNeue{
    return @"HelveticaNeue";
}

+(NSString *) helveticaNeue_pingFang{
    return @"HelveticaNeue,PingFang-SC-Medium";
}
@end

@implementation ColorContants
+(UIColor *) red{
    return [UIColor colorWithHexString:@"#f45d7a"];
}

+(UIColor *) orange{
    return [UIColor colorWithHexString:@"#f7b178"];
}

+(UIColor *) gray{
    return [UIColor colorWithHexString:@"#f1f2f2"];
}

+(UIColor *) phoneNumerFontColor{
    return [UIColor colorWithHexString:@"#999999"];
}

+(UIColor *) userNameFontColor{
    return [UIColor colorWithHexString:@"#333333"];
}

+(UIColor *) otherFontColor{
    return [UIColor colorWithHexString:@"#e0e0e0"];
}

@end
