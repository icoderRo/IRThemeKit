//
//  IRTheme.h
//  IRThemeKit
//
//  Created by 聪 on 2018/5/10.
//  Copyright © 2018年 icoderRo. All rights reserved.
//

typedef id _Nullable(^ _Nullable IRThemeArgBlock)(NSString * _Nullable keyPath);
typedef id _Nullable(^ _Nullable IRThemeArgStateBlock)(NSString * _Nullable keyPath, UIControlState state);
typedef id _Nullable(^ _Nullable IRThemeArgFloatBlock)(NSString * _Nullable keyPath, CGFloat f);

#pragma mark - Methods

@interface UIView (IRTheme)
- (IRThemeArgBlock)ir_backgroundColor;
- (IRThemeArgBlock)ir_tintColor NS_AVAILABLE_IOS(7_0);
@end

@interface UIImageView (IRTheme)
- (IRThemeArgBlock)ir_image;
@end

@interface UILabel (IRTheme)
- (IRThemeArgBlock)ir_textColor;
- (IRThemeArgBlock)ir_shadowColor;
- (IRThemeArgBlock)ir_highlightedTextColor;
@end

@interface UINavigationBar (IRtheme)
- (IRThemeArgBlock)ir_barTintColor;
- (IRThemeArgBlock)ir_tintColor NS_AVAILABLE_IOS(7_0);
@end

@interface UIBarButtonItem (IRtheme)
- (IRThemeArgBlock)ir_tintColor NS_AVAILABLE_IOS(7_0);
@end

@interface UIToolbar (IRTheme)
- (IRThemeArgBlock)ir_barTintColor;
@end

