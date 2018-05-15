//
//  IRThemeMgr.h
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol IRThemeProtocol <NSObject>
@optional

/**
 if current theme has no value whether use default theme value
 @return Yes --> use default theme
 */
+ (BOOL)ir_isUseDefaultThemeValue;

@end


@class IRThemeConfig;

@interface IRThemeMgr : NSObject
///< urrent using theme config
@property (nonatomic, copy, readonly) IRThemeConfig *config;

+ (instancetype _Nullable )manager;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark - Manager Theme Configuration
/**
 use in initializeC

 @param config IRThemeConfig
 @return success / failure
 */
- (BOOL)ir_setupThemeWithConfig:(IRThemeConfig *)config;


/**
 use new theme

 @param config IRThemeConfig
 @return success / failure
 */
- (BOOL)ir_setNewThemeWithConfig:(IRThemeConfig *)config;


/**
 use new theme

 @param filePath filePath
 @return success / failure
 */
- (BOOL)ir_setNewThemeWithFilePath:(NSString *)filePath;

@end



NS_ASSUME_NONNULL_END


