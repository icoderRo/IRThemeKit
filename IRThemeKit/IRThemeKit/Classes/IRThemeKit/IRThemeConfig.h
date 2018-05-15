//
//  IRThemeConfigMapper.h
//  IRThemeKit_Example
//
//  Created by 聪 on 2018/5/15.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IRThemeConfigHybrid;

@interface IRThemeConfig : NSObject

/**< must set defaultFilePath and  */
@property (nonatomic, copy, nonnull) NSString *defaultFilePath;
@property (nonatomic, copy, nonnull) NSString *filePath;

/**< colorKey use to get colorValue */
@property (nonatomic, copy, nullable) NSString *colorKey;
/**< imageKey use to get imageValue */
@property (nonatomic, copy, nullable) NSString *imageKey;
/**< hybridKey use to get image or color */
@property (nonatomic, copy, nullable) NSString *hybridKey;
/**< hybrid must set hybridKey  */
@property (nonatomic, copy, nullable) IRThemeConfigHybrid *hybrid;

@end

/**
 * can not sure wheter it is image or color
 */
@interface IRThemeConfigHybrid : NSObject

@end
