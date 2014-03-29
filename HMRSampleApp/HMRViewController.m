//
//  HMRViewController.m
//  HMRSampleApp
//
//  Created by himara2 on 2014/03/29.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "HMRViewController.h"
#import "HMRScrollFeedView.h"

@interface HMRViewController ()

@end

@implementation HMRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"hello world: %@", [HMRScrollFeedView helloWorld]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
