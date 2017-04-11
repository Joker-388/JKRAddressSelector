//
//  Header.h
//  JKRAddressSelector
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Joker. All rights reserved.
//


#ifndef Header_h
#define Header_h
#import "UIColor+JKRColor.h"
#define JKRColor(r,g,b,a) [UIColor jkr_colorWithRed:r green:g blue:b alpha:a]
#define JKRColorHex(_hex_) [UIColor jkr_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
#define singleton_interface(class_name) + (instancetype)shared##class_name;
#define singleton_implementation(class_name) \
static class_name *__singleton; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
__singleton = [super allocWithZone:zone]; \
}); \
return __singleton; \
} \
+ (instancetype)shared##class_name { \
if (!__singleton) __singleton = [[class_name alloc] init]; \
return __singleton; \
}
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#import "JKRAddressStore.h"
#import "UIView+JKR_Frame.h"
#import "UIView+JKRViewController.h"
#import "UIView+JKRTapGestureRecognizer.h"
#endif /* Header_h */
