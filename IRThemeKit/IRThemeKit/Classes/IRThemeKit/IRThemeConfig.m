//
//  IRThemeConfigMapper.m
//  IRThemeKit_Example
//
//  Created by 聪 on 2018/5/15.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import "IRThemeConfig.h"

@implementation IRThemeConfig

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_usingfilePath forKey:@"usingfilePath"];
    [aCoder encodeObject:_colorKey forKey:@"colorKey"];
    [aCoder encodeObject:_imageKey forKey:@"imageKey"];
    [aCoder encodeObject:_hybridKey forKey:@"hybridKey"];
    [aCoder encodeObject:_hybrid forKey:@"hybrid"];
    [aCoder encodeBool:_isUseDefaultThemeValue forKey:@"isUseDefaultThemeValue"];
    [aCoder encodeObject:_defaultFilePath forKey:@"defaultFilePath"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    _usingfilePath = [aDecoder decodeObjectForKey:@"usingfilePath"];
    _colorKey = [aDecoder decodeObjectForKey:@"colorKey"];
    _imageKey = [aDecoder decodeObjectForKey:@"imageKey"];
    _hybridKey = [aDecoder decodeObjectForKey:@"hybridKey"];
    _hybridKey = [aDecoder decodeObjectForKey:@"hybridKey"];
    _defaultFilePath = [aDecoder decodeObjectForKey:@"defaultFilePath"];
    _isUseDefaultThemeValue = [aDecoder decodeBoolForKey:@"isUseDefaultThemeValue"];
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    typeof(self) config = [self.class new];
    config.usingfilePath = self.usingfilePath;
    config.colorKey = self.colorKey;
    config.imageKey = self.imageKey;
    config.hybridKey = self.hybridKey;
    config.hybrid = self.hybrid;
    config.isUseDefaultThemeValue = self.isUseDefaultThemeValue;
    config.defaultFilePath = self.defaultFilePath;
    return config;
}


@end

@implementation IRThemeConfigHybrid
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

}
@end
