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

+(NSString *) pingFangBold{
    return @"PingFang-SC-Bold";
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

+(UIColor *) whiteFontColor{
    return [UIColor colorWithHexString:@"#ffffff"];
}

+(UIColor *) otherFontColor{
    return [UIColor colorWithHexString:@"#e0e0e0"];
}

+(UIColor *) silverColor{
    return [UIColor colorWithHexString:@"#80ffff"];
}

+(UIColor *) integralSummeryFontColor{
    return [UIColor colorWithHexString:@"#d9ffff"];
}

+(UIColor *) BlueFontColor{
    return [UIColor colorWithHexString:@"#78b4f7"];
}

+(UIColor *) kitingFontColor{
    return [UIColor colorWithHexString:@"#666666"];
}

+(UIColor *) integralWhereFontColor{
    return [UIColor colorWithHexString:@"#cccccc"];
}

+(UIColor *) integralSeperatorColor{
    return [UIColor colorWithHexString:@"#f0f0f0"];
}

@end
