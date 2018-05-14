//
//  IRTheme.h
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#define IRThemeCacheProperty \
@property (strong, nonatomic) NSMutableDictionary * _Nullable ir_cache;

#define IRThemeCacheImplementation \
@dynamic ir_cache;\
- (NSMutableDictionary *)ir_cache {\
    NSMutableDictionary *obj = objc_getAssociatedObject(self,  @selector(ir_cache));\
    if (!obj) {\
        obj = [NSMutableDictionary dictionary];\
        objc_setAssociatedObject(self,  @selector(ir_cache), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
    }\
    return obj;\
}\


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface IRTheme : NSObject

@property (nonatomic, weak, readonly) id target; // message target



- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (instancetype _Nullable)themeWithTarget:(id)target;

@end
NS_ASSUME_NONNULL_END

typedef UIView *_Nullable(^ _Nullable IRThemeArg1Block)(NSString * _Nullable keyPath);


@interface UIView (IRTheme)
IRThemeCacheProperty
- (IRThemeArg1Block)ir_backgroundColor;
@end

