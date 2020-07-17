//
//  UIScrollView+WDScrollView.h
//  UU
//
//  Created by 郝鹏飞 on 2020/6/8.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//基于mjrefresh
@interface UIScrollView (PPScrollView)

/// 添加下拉刷新
/// @param beginRefresh 开始刷新回调
- (void)addHeaderRefresh:(void(^)(void))beginRefresh;

/// 添加上拉刷新
/// @param beginRefresh 开始刷新回调
- (void)addFooterRefresh:(void(^)(void))beginRefresh;


/// 添加下拉刷新，并进入刷新状态
/// @param beginRefresh 开始刷新回调
- (void)beginHeaderRefresh:(void(^)(void))beginRefresh;
/// 添加上拉刷新，并进入刷新状态
/// @param beginRefresh 开始刷新回调
- (void)beginFooterRefresh:(void(^)(void))beginRefresh;

/// 结束刷新状态
- (void)endMjRefresh;

//在dealloc和deinit里调用
/// 释放上拉下拉刷新
- (void)freeMjRefresh;

//- (void)addTopAlpaFade;

@end

NS_ASSUME_NONNULL_END
