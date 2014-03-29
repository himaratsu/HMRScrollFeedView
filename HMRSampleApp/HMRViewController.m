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
<HMRScrollFeedViewDelegate, HMRScrollFeedViewDataSource>

@property (nonatomic) HMRScrollFeedView *feedView;

@end

@implementation HMRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.feedView = [[HMRScrollFeedView alloc] init];
    _feedView.hmrDataSource = self;
    _feedView.hmrDelegate = self;
    
    [self.view addSubview:_feedView];
}


#pragma mark - HMRScrollFeedViewDataSource

- (NSInteger)numberOfPages:(HMRScrollFeedView *)scrollFeedView {
    return 9;
}

- (NSArray *)viewsForFeedView:(HMRScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<9; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.frame = self.view.frame;
        
        switch (i%3) {
            case 0:
                vc.view.backgroundColor = [UIColor redColor];
                break;
            case 1:
                vc.view.backgroundColor = [UIColor greenColor];
                break;
            case 2:
                vc.view.backgroundColor = [UIColor blueColor];
                break;
            default:
                break;
        }
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.font = [UIFont systemFontOfSize:100.0f];
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        label.center = vc.view.center;
        [vc.view addSubview:label];
        
        [array addObject:vc];
    }
    
    return [array copy];
}

@end
