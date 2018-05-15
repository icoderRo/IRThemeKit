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

@implementation IRTheme

//static

+ (instancetype)themeWithTarget:(id)target {
    IRTheme *theme = [[self alloc] init];
    theme->_target = target;
    return theme;
}
@end

#pragma mark - selectorName
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

/// only several sel
#pragma mark - Get KeyPath Value
static NSString * const ir_themeValue = @"_valueForKey:configKey:";
static NSString * const ir_setBackgroundColor = @"setBackgroundColor:";

#pragma mark - Objc_msgSend
static id (*ir_themeValueSend)(id, SEL, id, id);
static void (*ir_arg1Send)(id, SEL, id);

#pragma mark - Private
static id IRKeyPathValue(NSString *keyPath, NSString *configKey) {
    SEL sel = NSSelectorFromString(ir_themeValue);;
    if (!IRMgr || !sel || ![IRMgr respondsToSelector:sel]) return nil;
    ir_themeValueSend = (id(*)(id, SEL, id, id))objc_msgSend;
    return ir_themeValueSend(IRMgr, sel, keyPath, configKey);
}

/**
 * use objc_msgSend or performSelector
 * NSInvocation can Package multiple parameters but it much slower than others
 */
static void IRArg1Send(id target, SEL sel, id value) {
    if (!target || !sel || ![target respondsToSelector:sel]) return;
    ir_arg1Send = (void(*)(id, SEL, id))objc_msgSend;
    ir_arg1Send(target, sel, value);
}

@implementation UIView (IRTheme)
IRThemeCacheImplementation

- (IRThemeArg1Block)ir_backgroundColor {
    return ^UIView *(NSString *keyPath) {
//        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
 
        id obj = IRKeyPathValue(keyPath, IRColorKey);
        if (!obj) return self;
        
        SEL sel = NSSelectorFromString(ir_setBackgroundColor);;
        IRArg1Send(self, sel, obj);
        
//        CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
//        NSLog(@"%f", endTime - startTime);
        return self;
    };
}

@end
