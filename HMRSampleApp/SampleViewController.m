//
//  SampleViewController.m
//  HMRScrollFeedView
//
//  Created by himara2 on 2014/03/29.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SampleViewController

- (void)setPageTitle:(NSString *)pageTitle {
    _pageTitle = pageTitle;
    _titleLabel.text = pageTitle;
}

@end
