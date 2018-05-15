//
//  IRViewController.m
//  IRThemeKit
//
//  Created by icoderRo on 05/10/2018.
//  Copyright (c) 2018 icoderRo. All rights reserved.
//

#import "IRViewController.h"
#import "IRThemeKit.h"

@interface IRViewController ()<IRThemeProtocol>

@property (nonatomic, weak) UIView *view1;
@end

@implementation IRViewController

+ (BOOL)ir_isUseDefaultThemeValue {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"IRDefaultTheme" ofType:@"plist"];
    
    IRThemeConfig *config = [IRThemeConfig new];
    config.filePath = defaultPath;
    config.colorKey = @"Color";
    config.imageKey = @"Image";
    config.hybridKey = @"Hybrid";
    
    BOOL success = [[IRThemeMgr manager] ir_setupThemeWithConfig:config];
    
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
