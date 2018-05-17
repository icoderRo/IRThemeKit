//
//  IRThemeMgr.h
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class IRThemeConfig;

@interface IRThemeMgr : NSObject
///< current using theme config
@property (nonatomic, copy, readonly) IRThemeConfig *config;

+ (instancetype _Nullable )manager;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (id)mutableCopy UNAVAILABLE_ATTRIBUTE;
- (id)copy UNAVAILABLE_ATTRIBUTE;

#pragma mark - Manager Theme Configuration
/**
 * use in initialize or set a new theme
 * when set a new theme
    Example:
    @code
        IRThemeConfig *config = [IRThemeMgr manager].config.copy;
        config.usingfilePath = @"";
        [[IRThemeMgr manager] ir_themeWithConfig:config];
    @endcode
 
 @param config IRThemeConfig
 @return success / failure
 */
- (BOOL)ir_themeWithConfig:(IRThemeConfig *)config;

@end

NS_ASSUME_NONNULL_END


