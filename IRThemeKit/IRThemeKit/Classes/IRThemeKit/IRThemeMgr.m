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
@property (nonatomic, strong) NSDictionary *mapValues;
@property (nonatomic, strong) NSDictionary *defaultMapValues;

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
    _mapValues = mapValues;
    
    if (defaultFilePath) {
        NSDictionary *defaultMapValues = [NSDictionary dictionaryWithContentsOfFile:defaultFilePath];
        _defaultMapValues = defaultMapValues;
    }
    
    return YES;
}

#pragma mark - Get KeyPath Value
- (id)_valueForKey:(NSString *)key configKey:(nonnull NSString *)configKey{
    if (!_mapValues) return nil;
    
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
    id colorDict = _mapValues[colorKey];
    if (!colorDict && ![colorDict isKindOfClass:[NSDictionary class]]) {
        NSString *hexStr = ((NSDictionary *)colorDict)[key];
        if (!hexStr || hexStr.length <= 0) return nil;
        return [self _colorWithHexStr:hexStr];
    } else {
        if (!_config.isUseDefaultThemeValue) return nil;
        
        return [UIColor redColor];
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
    
    if (hexStr.length == 6) {
        return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
    } else { /// alpha
        return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:((float)((hex & 0xFF000000) >> 24))/255.0];
    }
}

@end
