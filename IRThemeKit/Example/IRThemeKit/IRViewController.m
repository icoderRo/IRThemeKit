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
    
    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"IRDefaultTheme" ofType:@"plist"];
    
    IRThemeConfig *config = [IRThemeConfig new];
    config.usingfilePath = defaultPath;
    config.colorKey = @"Color";
    config.imageKey = @"Image";
    config.hybridKey = @"Hybrid";
    
    config.defaultFilePath = defaultPath;
    config.isUseDefaultThemeValue = YES;
    
    BOOL success = [[IRThemeMgr manager] ir_themeWithConfig:config];
    
    if (!success) {
        NSLog(@"not find configFile");
    }
    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    for (int i = 0; i < 50000; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + 5 , 100, 20)];
        view.ir_backgroundColor(@"home_view_background");
        [self.view addSubview:view];
    }
    
    
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f second", endTime - startTime);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
