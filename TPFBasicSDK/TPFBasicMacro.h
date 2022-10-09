//
//  TPFBasicMacro.h
//  TPFBasicSDK
//
//  Created by 呼啦 on 2022/8/23.
//  Copyright © 2022 尚游网络. All rights reserved.
//

#ifndef TPFBasicMacro_h
#define TPFBasicMacro_h

//#import "UIColor+Conver.h"
#import "NSObject+Null.h"
#import "UIView+YYAdd.h"
#import "YYText.h"

///屏幕的全部宽度
#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
///屏幕的全部高度
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height
///RGB
#define kRGB(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 安全区
#define SAFE_AREA_BOTTOM    ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom)
#define SAFE_AREA_TOP       ([UIApplication sharedApplication].keyWindow.safeAreaInsets.top < 20 ? 20 : [UIApplication sharedApplication].keyWindow.safeAreaInsets.top)
#define SAFE_AREA_LEFT      ([UIApplication sharedApplication].keyWindow.safeAreaInsets.left)
#define SAFE_AREA_RIGHT     ([UIApplication sharedApplication].keyWindow.safeAreaInsets.right)

// 引用
#define SYWeakSelf(weakSelf)   __weak  typeof(self) weakSelf  = self
#define SYBlockSelf(blockSelf) __block typeof(self) blockSelf = self

//正式环境
static NSString *BASIC_UNIFY_DOMAIN             = @"https://ios-common-proxy.syyx.com";
//数据上报
static NSString *BASIC_DATA_REPORT              = @"https://tpfdata.syyx.com:35002";
//服务器的命名空间
static NSString *BASIC_UNIFY_NAMESPACE          = @"0";

#endif /* TPFBasicMacro_h */
