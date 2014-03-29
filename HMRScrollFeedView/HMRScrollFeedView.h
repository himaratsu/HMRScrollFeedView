//
//  HMRScrollFeedView.h
//  HMRScrollFeedView
//
//  Created by himara2 on 2014/03/29.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HMRScrollFeedView;

@protocol HMRScrollFeedViewDataSource <NSObject>
@required
- (NSInteger)numberOfPages:(HMRScrollFeedView *)scrollFeedView;
- (CGSize)sizeOfMenuView:(HMRScrollFeedView *)scrollFeedView;
- (CGSize)sizeOfFeedView:(HMRScrollFeedView *)scrollFeedView;
- (NSArray *)viewsForMenuView:(HMRScrollFeedView *)scrollFeedView;
- (NSArray *)viewsForFeedView:(HMRScrollFeedView *)scrollFeedView;

@end

@protocol HMRScrollFeedViewDelegate <NSObject>

// TODO: to create

@end



@interface HMRScrollFeedView : UIView

@property (nonatomic, assign) id<HMRScrollFeedViewDataSource> hmrDataSource;
@property (nonatomic, assign) id<HMRScrollFeedViewDelegate> hmrDelegate;

@property (nonatomic, readonly) NSInteger currentPageIndex;

@end
