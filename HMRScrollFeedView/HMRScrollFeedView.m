//
//  HMRScrollFeedView.m
//  HMRScrollFeedView
//
//  Created by himara2 on 2014/03/29.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "HMRScrollFeedView.h"

@interface HMRScrollFeedView ()
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// for menu
@property (nonatomic) UIScrollView *menuScrollView;

// for feed
@property (nonatomic) NSArray *viewControllers;
@property (nonatomic) UIPageViewController *pageViewController;

@end


@implementation HMRScrollFeedView

+ (NSString *)helloWorld {
    return @"Hello!";
}

- (id)init
{
    return [self initWithFrame:[UIScreen mainScreen].applicationFrame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.menuScrollView = [[UIScrollView alloc] init];
    [self addSubview:_menuScrollView];
    
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;

    [self insertSubview:_pageViewController.view belowSubview:_menuScrollView];
}

- (void)setHmrDataSource:(id<HMRScrollFeedViewDataSource>)hmrDataSource {
    _hmrDataSource = hmrDataSource;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    NSLog(@"layoutSubviews");
    CGSize menuSize = [_hmrDataSource sizeOfMenuView:self];
    _menuScrollView.frame = CGRectMake(self.frame.origin.x,
                                       self.frame.origin.x,
                                       self.frame.size.width,
                                       menuSize.height);
    [self layoutMenuScrollView];
    
    _pageViewController.view.frame = CGRectMake(self.frame.origin.x,
                                                menuSize.height,
                                                self.frame.size.width,
                                                self.frame.size.height - menuSize.height);
    
    self.viewControllers = [_hmrDataSource viewsForFeedView:self];
    if ([_viewControllers count] > 0) {
        [_pageViewController setViewControllers:@[_viewControllers[0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    }
    
}

- (void)layoutMenuScrollView {
    CGSize menuSize = [_hmrDataSource sizeOfMenuView:self];
    NSArray *menuViews = [_hmrDataSource viewsForMenuView:self];
    
    NSInteger index = 0;
    for (UIView *v in menuViews) {
        v.frame = CGRectMake(menuSize.width * index, 0, menuSize.width, menuSize.height);
        [_menuScrollView addSubview:v];
        
        index++;
    }
    _menuScrollView.contentSize = CGSizeMake(menuSize.width * index, menuSize.height);
}

- (void)dealloc
{
    
}


#pragma mark - UIPageViewControlDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger page = [self indexOfViewController:viewController];

    if (page == NSNotFound) {
        return nil;
    }
    if (page == 0) {
        return nil;
    }
    
    page--;
    
    return _viewControllers[page];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger page = [self indexOfViewController:viewController];
    
    if (page == NSNotFound) {
        return nil;
    }
    if (page == [_hmrDataSource numberOfPages:self] - 1) {
        return nil;
    }
    page++;
    
    return _viewControllers[page];
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    return [_viewControllers indexOfObject:viewController];
}


@end
