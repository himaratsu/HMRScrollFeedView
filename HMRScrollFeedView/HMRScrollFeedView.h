#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HMRScrollFeedView;

@protocol HMRScrollFeedViewDataSource <NSObject>
@required
- (NSInteger)numberOfPages:(HMRScrollFeedView *)scrollFeedView;
- (CGSize)sizeOfMenuView:(HMRScrollFeedView *)scrollFeedView;
- (NSArray *)viewsForMenuView:(HMRScrollFeedView *)scrollFeedView;
- (NSArray *)viewsForFeedView:(HMRScrollFeedView *)scrollFeedView;

@end

@protocol HMRScrollFeedViewDelegate <NSObject>

- (void)scrollFeedView:(HMRScrollFeedView *)scrollFeedView didChangeCurrentPage:(NSInteger)page;

@end


@interface HMRScrollFeedView : UIView

@property (nonatomic, assign) id<HMRScrollFeedViewDataSource> hmrDataSource;
@property (nonatomic, assign) id<HMRScrollFeedViewDelegate> hmrDelegate;

@property (nonatomic, readonly) NSInteger currentPageIndex;
@property (nonatomic, readonly) UIPageViewControllerTransitionStyle transitionStyle;

- (id)initWithStyle:(UIPageViewControllerTransitionStyle)transitionStyle;
- (id)initWithFrame:(CGRect)frame
              style:(UIPageViewControllerTransitionStyle)transitionStyle;

- (void)reloadData;

@end
