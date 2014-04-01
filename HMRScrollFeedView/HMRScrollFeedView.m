#import "HMRScrollFeedView.h"

@interface HMRScrollFeedView ()
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) UIPageViewControllerTransitionStyle transitionStyle;

// for menu
@property (nonatomic) UIScrollView *menuScrollView;
@property (nonatomic) CGSize menuSize;

// for feed
@property (nonatomic) NSArray *viewControllers;
@property (nonatomic) UIPageViewController *pageViewController;

@end


@implementation HMRScrollFeedView

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

- (id)initWithStyle:(UIPageViewControllerTransitionStyle)transitionStyle
{
    self = [self init];
    _transitionStyle = transitionStyle;
    
    if (self) {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
              style:(UIPageViewControllerTransitionStyle)transitionStyle
{
    self = [self initWithFrame:frame];
    _transitionStyle = transitionStyle;
    
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    self.menuScrollView = [[UIScrollView alloc] init];
    _menuScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_menuScrollView];
    
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:_transitionStyle
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;

    [self insertSubview:_pageViewController.view belowSubview:_menuScrollView];
}

- (void)setHmrDataSource:(id<HMRScrollFeedViewDataSource>)hmrDataSource {
    _hmrDataSource = hmrDataSource;
    [self reloadData];
}

- (void)reloadData {
    _menuSize = [_hmrDataSource sizeOfMenuView:self];
    _menuScrollView.frame = CGRectMake(self.frame.origin.x,
                                       self.frame.origin.x,
                                       self.frame.size.width,
                                       _menuSize.height);
    [self layoutMenuScrollView];
    
    _pageViewController.view.frame = CGRectMake(self.frame.origin.x,
                                                _menuSize.height,
                                                self.frame.size.width,
                                                self.frame.size.height - _menuSize.height);
    
    self.viewControllers = [_hmrDataSource viewsForFeedView:self];
    if ([_viewControllers count] > 0) {
        [_pageViewController setViewControllers:@[_viewControllers[0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    }
}

- (void)layoutMenuScrollView {
    NSArray *menuViews = [_hmrDataSource viewsForMenuView:self];
    
    NSInteger index = 0;
    
    for (UIView *v in menuViews) {
        v.frame = CGRectMake(_menuSize.width * index, 0, _menuSize.width, _menuSize.height);
        v.tag = index;
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(didTapMenuView:)];
        [v addGestureRecognizer:tapGesture];
        
        [_menuScrollView addSubview:v];
        index++;
    }
    _menuScrollView.contentSize = CGSizeMake(_menuSize.width * index, _menuSize.height);
}

- (UIPageViewControllerTransitionStyle)transitionStyle {
    return _pageViewController.transitionStyle;
}

- (UIPageViewControllerNavigationOrientation)navigationOrientation {
    return _pageViewController.navigationOrientation;
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
    
    [self moveToPageIndexInMenuScrollViewWithIndex:page];
    _currentPageIndex = page;
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
    
    [self moveToPageIndexInMenuScrollViewWithIndex:page];
    _currentPageIndex = page;
    return _viewControllers[page];
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    return [_viewControllers indexOfObject:viewController];
}


#pragma mark - MenuScrollView Methods

- (void)moveToPageIndexInMenuScrollViewWithIndex:(NSInteger)index {
    CGRect destFrame = CGRectMake(index * _menuSize.width + _menuSize.width/2 - 160,
                                  0,
                                  _menuScrollView.frame.size.width,
                                  _menuScrollView.frame.size.height);
    [_menuScrollView scrollRectToVisible:destFrame animated:YES];
}

- (void)didTapMenuView:(UITapGestureRecognizer *)gesture {
    UIView *view = [gesture view];
    NSInteger destIndex = view.tag;
    
    if (_currentPageIndex == destIndex) {
        return;
    }
    
    UIPageViewControllerNavigationDirection direction;
    if (_currentPageIndex > destIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    else if (_currentPageIndex < destIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    
    [_pageViewController setViewControllers:@[_viewControllers[destIndex]]
                                  direction:direction
                                   animated:YES
                                 completion:nil];
    _currentPageIndex = destIndex;
    
    [self moveToPageIndexInMenuScrollViewWithIndex:destIndex];
}

@end
