//
//  IRThemeConfigMapper.h
//  IRThemeKit_Example
//
//  Created by 聪 on 2018/5/15.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IRThemeConfigHybrid;

@interface IRThemeConfig : NSObject <NSCopying, NSCoding>

/**< must set usingfilePath !!! */
@property (nonatomic, copy, nonnull) NSString *usingfilePath;

/**< colorKey mapper to colorDict */
@property (nonatomic, copy, nullable) NSString *colorKey;
/**< imageKey use to get imageValue */
@property (nonatomic, copy, nullable) NSString *imageKey;
/**< hybridKey use to get image or color */
@property (nonatomic, copy, nullable) NSString *hybridKey;
/**< hybrid must set hybridKey  */
@property (nonatomic, copy, nullable) IRThemeConfigHybrid *hybrid;


/**
 if isUseDefaultThemeValue = Yes, must set defaultFilePath, otherwise it no affect.
 
 @discussion if current using theme has no value then you want to use default theme value
    Example:
 
    @code
        config.defaultFilePath = defaultPath;
        config.isUseDefaultThemeValue = YES;
    @endcode
 
 */
@property (nonatomic) BOOL isUseDefaultThemeValue;
@property (nonatomic, copy, nullable) NSString *defaultFilePath;

@end

/**
 * can not sure wheter it is image or color
 */
@interface IRThemeConfigHybrid : NSObject <NSCoding>

@end
