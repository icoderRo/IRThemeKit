//
//  IRViewController.m
//  IRThemeKit
//
//  Created by icoderRo on 05/10/2018.
//  Copyright (c) 2018 icoderRo. All rights reserved.
//

#import "IRViewController.h"
#import "IRThemeKit.h"

@interface IRViewController ()

@property (nonatomic, weak) UIView *view1;
@end

@implementation IRViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *usingfilePath = [[NSBundle mainBundle] pathForResource:@"IRDefaultTheme" ofType:@"plist"];
    
    IRThemeConfig *config = [IRThemeConfig new];
    config.usingfilePath = usingfilePath;
    config.colorKey = @"Color";
    config.imageKey = @"Image";
    config.hybridKey = @"Hybrid";
    
    config.defaultFilePath = usingfilePath;
    config.isUseDefaultThemeValue = YES;
    
    BOOL success = [[IRThemeMgr manager] ir_themeWithConfig:config];
    
    if (!success) {
        NSLog(@"not find configFile");
    }

    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    CGFloat count = 50000;
    for (int i = 0; i < count; i++) {
        
        UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(100, 100 + 5 , 100, 20)];
        [view setTitle:@"0000" forState:UIControlStateNormal];
        view.tag = i + 1;
        view.ir_backgroundColor(@"home_view_background");
        
        
        if (i == count -1) {
           
            view.frame = CGRectMake(100, 100 + 50 , 100, 20);
            view.ir_backgroundColor(@"home_view_background1");
        }
      
        [self.view addSubview:view];
    }

    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f second", endTime - startTime);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UIView *view in self.view.subviews) {
        if (view.tag % 2  == 0) {
            [view removeFromSuperview];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *usingfilePath = [[NSBundle mainBundle] pathForResource:@"IRNewTheme" ofType:@"plist"];
        IRThemeConfig *config = [IRThemeMgr manager].config.copy;
        config.usingfilePath = usingfilePath;
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        [[IRThemeMgr manager] ir_themeWithConfig:config];
        CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
        NSLog(@"%f second", endTime - startTime);
    });
    
  
}

@end
