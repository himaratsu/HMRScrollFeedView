//
//  HMRViewController.m
//  HMRSampleApp
//
//  Created by himara2 on 2014/03/29.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "HMRViewController.h"
#import "HMRScrollFeedView.h"
#import "SampleViewController.h"

static const NSInteger MenuHeight = 45;

@interface HMRViewController ()
<HMRScrollFeedViewDelegate, HMRScrollFeedViewDataSource>

@property (nonatomic) HMRScrollFeedView *feedView;

@end

@implementation HMRViewController

- (void)loadView {
    self.view = self.feedView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (HMRScrollFeedView *)feedView {
    if (_feedView == nil) {
        self.feedView = [[HMRScrollFeedView alloc] init];
        _feedView.hmrDataSource = self;
        _feedView.hmrDelegate = self;
    }
    return _feedView;
}


#pragma mark - HMRScrollFeedViewDataSource

- (NSInteger)numberOfPages:(HMRScrollFeedView *)scrollFeedView {
    return 9;
}

- (CGSize)sizeOfMenuView:(HMRScrollFeedView *)scrollFeedView {
    return CGSizeMake(80, MenuHeight);
}

- (NSArray *)viewsForMenuView:(HMRScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<9; i++) {
        // create view controller
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, MenuHeight)];
        
        switch (i%3) {
            case 0:
                v.backgroundColor = [UIColor yellowColor];
                break;
            case 1:
                v.backgroundColor = [UIColor purpleColor];
                break;
            case 2:
                v.backgroundColor = [UIColor orangeColor];
                break;
            default:
                break;
        }
        [array addObject:v];
    }
    
    return [array copy];

}

- (NSArray *)viewsForFeedView:(HMRScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<9; i++) {
        // create rview controller
        SampleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SampleViewController"];
        [vc view];
        vc.titleLabel.text = [NSString stringWithFormat:@"%d", i];
        
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
        
        [array addObject:vc];
    }
    
    return [array copy];
}

@end
