//
//  IRTheme.m
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import "IRTheme.h"
#import "IRThemeMgr.h"
#import "IRThemeConfig.h"
#import <objc/message.h>

#define IRMgr       [IRThemeMgr manager]
#define IRColorKey  IRMgr.config.colorKey
#define IRImageKey  IRMgr.config.imageKey
#define IRHybridKey IRMgr.config.hybridKey

#define IRThemeCacheProperty(cls) \
@interface cls ()\
@property (strong, nonatomic) NSMutableDictionary * _Nullable ir_cache;\
@end

#define IRThemeCacheImpl \
- (NSMutableDictionary *)ir_cache {\
    NSMutableDictionary *obj = objc_getAssociatedObject(self,  @selector(ir_cache));\
    if (!obj) {\
        obj = [NSMutableDictionary dictionary];\
        objc_setAssociatedObject(self,  @selector(ir_cache), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
        void(*ir_targetSend)(id,SEL,id)=(void(*)(id,SEL,id))objc_msgSend;\
        ir_targetSend(IRMgr,NSSelectorFromString(ir_addTarget), self);\
    }\
    return obj;\
}

#define ir_argUpdateTheme \
[self.ir_cache enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull selStr, NSDictionary *  _Nonnull dict, BOOL * _Nonnull stop) {\
    NSString *keyPath = dict[ir_keyPath];\
    NSString *configKey = dict[ir_configKey];\
    id value = IRKeyPathValue(keyPath, configKey);\
    if (value) {\
        SEL sel = NSSelectorFromString(selStr);\
        IRArgSend(self, sel, value);\
    }\
}];

static NSString * const ir_keyPath = @"keyPath";
static NSString * const ir_configKey = @"configKey";

#pragma mark - Sel
/**
 * No need to waste
 
#define ir_argSelector argSelctor(NSStringFromSelector(_cmd))
static NSString * argSelctor(NSString *sel) {
    if (sel.length <= 3) return nil;
    
    NSString *newSel = [sel substringWithRange:NSMakeRange(3, sel.length - 3)];
    NSString *preStr = [@"set" stringByAppendingString:[[newSel substringToIndex:1] uppercaseString]];
    NSString *subStr = [newSel substringFromIndex:1];
    newSel = [[preStr stringByAppendingString:subStr] stringByAppendingString:@":"];
    return newSel;
}
**/
static NSString * const ir_addTarget = @"_addTarget:";
static NSString * const ir_themeValue = @"_valueForKey:configKey:";
static NSString * const ir_setBackgroundColor = @"setBackgroundColor:";
static NSString * const ir_setTintColor = @"setTintColor:";
static NSString * const ir_setImage = @"setImage:";

#pragma mark - Objc_msgSend
static id (*ir_themeValueSend)(id, SEL, id, id);
static void (*ir_arg1Send)(id, SEL, id);

#pragma mark - Get KeyPath Value
/**
 get image or color
 
 @param  keyPath   keyPath
 @param  configKey colorKey / imageKey / hybridKey
 @return image or color
 */
static id IRKeyPathValue(NSString *keyPath, NSString *configKey) {
    SEL sel = NSSelectorFromString(ir_themeValue);
    if (!IRMgr || !sel || ![IRMgr respondsToSelector:sel]) return nil;
    ir_themeValueSend = (id(*)(id, SEL, id, id))objc_msgSend;
    return ir_themeValueSend(IRMgr, sel, keyPath, configKey);
}

#pragma mark - Private
/**
 * use objc_msgSend or performSelector
 * NSInvocation can Package multiple parameters but it much slower than others
 */

static void IRArgSend(id target, SEL sel, id value) {
    if (!target || !sel || ![target respondsToSelector:sel]) return;
    ir_arg1Send = (void(*)(id, SEL, id))objc_msgSend;
    
    if ([value isKindOfClass:[UIColor class]]) {
        [UIView animateWithDuration:.15 animations:^{
            ir_arg1Send(target, sel, value);
        }];
        return;
    }
    ir_arg1Send(target, sel, value);
}

#pragma mark - UIView
IRThemeCacheProperty(UIView)
@implementation UIView (IRTheme)
IRThemeCacheImpl
- (void)ir_updateTheme {ir_argUpdateTheme}
- (IRThemeArgBlock)ir_backgroundColor {
    return ^UIView *(NSString *keyPath) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[ir_keyPath] = keyPath;
        dict[ir_configKey] = IRColorKey;
        /// sel as key ensure the lastest value
        [self.ir_cache setObject:dict.copy forKey:ir_setBackgroundColor];
        
        id value = IRKeyPathValue(keyPath, IRColorKey);
        if (!value) return self;
        
        SEL sel = NSSelectorFromString(ir_setBackgroundColor);
        IRArgSend(self, sel, value);
        return self;
    };
}

- (IRThemeArgBlock)ir_tintColor {
     return ^UIView *(NSString *keyPath) {
         NSMutableDictionary *dict = [NSMutableDictionary dictionary];
         dict[ir_keyPath] = keyPath;
         dict[ir_configKey] = IRColorKey;
         /// sel as key ensure the lastest value
         [self.ir_cache setObject:dict.copy forKey:ir_setTintColor];
         
         id value = IRKeyPathValue(keyPath, IRColorKey);
         if (!value) return self;
         
         SEL sel = NSSelectorFromString(ir_setTintColor);
         IRArgSend(self, sel, value);
         return self;
     };
}
@end

#pragma mark - UIImageView
IRThemeCacheProperty(UIImageView)
@implementation UIImageView (IRTheme)
IRThemeCacheImpl
- (void)ir_updateTheme {ir_argUpdateTheme}
- (IRThemeArgBlock)ir_image {
    return ^UIImageView *(NSString *keyPath) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[ir_keyPath] = keyPath;
        dict[ir_configKey] = IRImageKey;
        /// sel as key ensure the lastest value
        [self.ir_cache setObject:dict.copy forKey:ir_setImage];
        
        id value = IRKeyPathValue(keyPath, IRImageKey);
        if (!value) return self;
        
        SEL sel = NSSelectorFromString(ir_setImage);
        IRArgSend(self, sel, value);
        return self;
    };
}
@end
