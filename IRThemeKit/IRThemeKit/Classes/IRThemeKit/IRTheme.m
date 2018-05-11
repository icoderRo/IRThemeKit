//
//  IRTheme.m
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

#import "IRTheme.h"


@implementation IRTheme

+ (instancetype)themeWithTarget:(id)target {
    IRTheme *theme = [[self alloc] init];
    theme->_target = target;
    return theme;
}





@end

