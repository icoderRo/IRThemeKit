//
//  IRTheme.h
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//
#define IRThemePropertyInterface(Cls, PropertyCls, )\
@interface Cls (IRTheme)\
@property (strong, nonatomic) PropertyCls *theme;\
@end

#define IRThemePropertyImplementation(Cls, PropertyCls)\
@implementation Cls(IRTheme)\
@dynamic theme;\
- (PropertyCls *)theme {\
    PropertyCls *obj = objc_getAssociatedObject(self,  @selector(theme));\
    if (!obj) {\
        objc_setAssociatedObject(self,  @selector(theme), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
    }\
    return obj;\
}\
@end

typedef Class _Nullable *_Nullable(^ClassBlock)(NSString * _Nonnull selStr);

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface IRTheme : NSObject

@property (nonatomic, weak, readonly) id target; // message target



- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (instancetype _Nullable)themeWithTarget:(id)target;

@end
NS_ASSUME_NONNULL_END




//IRThemePropertyInterface(UIView, backgroundColor)



