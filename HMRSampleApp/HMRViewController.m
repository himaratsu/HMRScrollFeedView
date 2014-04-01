#import "HMRViewController.h"
#import "HMRScrollFeedView.h"
#import "HMRSampleViewController.h"
#import "HMRColorPalette.h"

static const NSInteger MenuWidth = 80;
static const NSInteger MenuHeight = 45;

@interface HMRViewController ()
<HMRScrollFeedViewDelegate, HMRScrollFeedViewDataSource>

@property (nonatomic) HMRScrollFeedView *feedView;

@end


@implementation HMRViewController

- (void)loadView {
    self.view = self.feedView;
}

- (HMRScrollFeedView *)feedView {
    if (_feedView == nil) {
        self.feedView = [[HMRScrollFeedView alloc] initWithStyle:UIPageViewControllerTransitionStyleScroll];
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
    return CGSizeMake(MenuWidth, MenuHeight);
}

- (NSArray *)viewsForMenuView:(HMRScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<9; i++) {
        // create view controller
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MenuWidth, MenuHeight)];
        v.backgroundColor = [HMRColorPalette colorWithIndex:i];
        [array addObject:v];
    }
    
    return [array copy];
}

- (NSArray *)viewsForFeedView:(HMRScrollFeedView *)scrollFeedView {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<9; i++) {
        // create rview controller
        HMRSampleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SampleViewController"];
        [vc view];
        vc.titleLabel.text = [NSString stringWithFormat:@"%d", i];
        vc.view.backgroundColor = [HMRColorPalette colorWithIndex:i];
                
        [array addObject:vc];
    }
    
    return [array copy];
}


#pragma mark - HMRScrollFeedViewDelegate

- (void)scrollFeedView:(HMRScrollFeedView *)scrollFeedView didChangeCurrentPage:(NSInteger)page {
    NSLog(@"ページ遷移Done. page: %ld", page);
}



#pragma mark - Status bar hidden

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
