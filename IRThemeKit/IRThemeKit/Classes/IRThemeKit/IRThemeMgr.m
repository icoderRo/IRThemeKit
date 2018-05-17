//
//  IRThemeMgr.m
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import "IRThemeMgr.h"
#import "IRThemeConfig.h"

@interface IRThemeMgr()
///< Key --> Value
@property (nonatomic, strong) NSDictionary *usingMapValues;
@property (nonatomic, strong) NSDictionary *defaultMapValues;
@property (nonatomic, strong) NSHashTable *targets;
@end

@implementation IRThemeMgr

+ (instancetype)manager {
    static IRThemeMgr *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (BOOL)ir_themeWithConfig:(IRThemeConfig *)config {
    _config = config;
    return [self _valuesWithDefaultPath:config.defaultFilePath usingPath:config.usingfilePath];
}

- (BOOL)_valuesWithDefaultPath:(NSString *)defaultFilePath usingPath:(NSString *)usingfilePath {
    if (!usingfilePath) return NO;
    NSDictionary *mapValues = [NSDictionary dictionaryWithContentsOfFile:usingfilePath];
    if (!mapValues) return NO;
    _usingMapValues = mapValues;
    
    if (defaultFilePath) {
        NSDictionary *defaultMapValues = [NSDictionary dictionaryWithContentsOfFile:defaultFilePath];
        if (defaultMapValues) _defaultMapValues = defaultMapValues;
    }
    
    [self _update];
    return YES;
}

#pragma mark - Get KeyPath Value
- (id)_valueForKey:(NSString *)key configKey:(nonnull NSString *)configKey{
    if (!_usingMapValues || !key || !configKey) return nil;
    
    if ([configKey isEqualToString:_config.colorKey]) {
       return [self _colorWithKey:key];
    } else if ([configKey isEqualToString:_config.imageKey]) {
        return [self _imageWithKey:key];
    } else if ([configKey isEqualToString:_config.hybridKey]) {
        return [self _hybridWithKey:key];
    }
    return nil;
}

#pragma mark - Private
- (id)_colorWithKey:(NSString *)key {
    NSString *colorKey = _config.colorKey;
    id colorDict = _usingMapValues[colorKey];
    if (colorDict && [colorDict isKindOfClass:[NSDictionary class]]) {
        NSString *hexStr = ((NSDictionary *)colorDict)[key];
        if (!hexStr || hexStr.length <= 0) return nil;
        return [self _colorWithHexStr:hexStr];
    } else {
        if (!_config.isUseDefaultThemeValue) return nil;
        if (!_defaultMapValues) return nil;
        colorDict = _defaultMapValues[colorKey];
        if (!colorDict || ![colorDict isKindOfClass:[NSDictionary class]]) return nil;
        NSString *hexStr = ((NSDictionary *)colorDict)[key];
        if (!hexStr || hexStr.length <= 0) return nil;
        return [self _colorWithHexStr:hexStr];
    }
}

- (id)_imageWithKey:(NSString *)key {
    
    return nil;
}
- (id)_hybridWithKey:(NSString *)key {
    
     return nil;
}

- (UIColor *)_colorWithHexStr:(NSString *)hexStr {
    hexStr = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if([hexStr hasPrefix:@"0x"]) hexStr = [hexStr substringFromIndex:2];
    if([hexStr hasPrefix:@"#"]) hexStr = [hexStr substringFromIndex:1];
    if (hexStr.length != 6 && hexStr.length != 8) return nil;
    
    unsigned int hex = 0;
    [[NSScanner scannerWithString:hexStr] scanHexInt:&hex];
    
    CGFloat red = ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0;
    CGFloat green = ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0;
    CGFloat blue = ((CGFloat)(hex & 0xFF)) / 255.0;
    
    if (hexStr.length == 6) {
        return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    } else { /// alpha
        CGFloat alpha = ((float)((hex & 0xFF000000) >> 24)) / 255.0;
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
}

/// Update All Objects
- (void)_update {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    for (id target in self.targets) {
        [target performSelector:NSSelectorFromString(@"ir_updateTheme")];
    }
#pragma clang diagnostic pop
}

- (void)_addTarget:(id)obj {
    if (obj) [self.targets addObject:obj];
}

- (NSHashTable *)targets {
    if (_targets) return _targets;
    _targets = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    return _targets;
}
@end
