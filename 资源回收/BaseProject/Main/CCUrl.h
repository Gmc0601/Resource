//
//  CCUrl.h
//  CarSticker
//
//  Created by cc on 2017/3/21.
//  Copyright © 2017年 cc. All rights reserved.
//

#ifndef CCUrl_h
#define CCUrl_h
/*
 接口文档
 */
#define TokenKey @"1e56c95504a9a846e4c7043704a20f25"

#define UDID     0

/*****************************测试开关*******************************/

#define HHTest   0      // 1 测试  0 上传

/*****************************测试开关*******************************/

#if HHTest

#define    BaseApi       @"http://139.224.70.219:88/index.php"

#else

#define    BaseApi      @"http://116.62.199.91/index.php"

#endif

#pragma mark - 接口地址 -

#define LoginURL @"_login_001"

#define BrandList @"_brandlist_001"


/*
 *   User Info
 */

#define IsLogin @"islogin"

#define UserToken @"userTOken"

#define AMapKey @"a1494e34664564a265a25cf94e05407b"

#endif /* CCUrl_h */
