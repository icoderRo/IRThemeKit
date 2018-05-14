//
//  IRViewController.m
//  IRThemeKit
//
//  Created by icoderRo on 05/10/2018.
//  Copyright (c) 2018 icoderRo. All rights reserved.
//

#import "IRViewController.h"
#import "IRTheme.h"

@interface IRViewController ()

@property (nonatomic, weak) UIView *view1;
@end

@implementation IRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + 5 , 100, 20)];
//    view.ir_backgroundColor(@"dddd");
//    [self.view addSubview:view];

    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + 100 , 100, 20)];
//    view1.backgroundColor = view.backgroundColor;
//    [self.view addSubview:view1];
    
            CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 50000; i++) {
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + 5 , 100, 20)];
        view.ir_backgroundColor(@"dddd");
        [self.view addSubview:view];
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + 5 , 100, 20)];
//    view.backgroundColor = [UIColor redColor];
//    [view.backgroundColor.theme ir_setName:@"11111"];
//    view.backgroundColor.theme.name = @"2222";
//        [self.view addSubview:view];
//
//    self.view1 = view;
    
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
