//
//  UIScrollView+WDScrollView.m
//  UU
//
//  Created by 郝鹏飞 on 2020/6/8.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import "UIScrollView+WDScrollView.h"
#import <MJRefresh/MJRefresh.h>
#import <objc/runtime.h>
@interface UIScrollView ()

@property (nonatomic ,strong) MJRefreshHeader *refreshHeaderView;

@property (nonatomic ,strong) MJRefreshFooter *refreshFooterView;

@end

static char refreshHeaderView_key,refreshFooterView_key;

@implementation UIScrollView (PPScrollView)

#pragma 添加属性set get 方法
- (void)setRefreshHeaderView:(MJRefreshHeader *)refreshHeaderView {

    objc_setAssociatedObject(self, &refreshHeaderView_key, refreshHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRefreshFooterView:(MJRefreshFooter *)refreshFooterView {

    objc_setAssociatedObject(self, &refreshFooterView_key, refreshFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MJRefreshHeader *)refreshHeaderView {

    return objc_getAssociatedObject(self, &refreshHeaderView_key);
}

- (MJRefreshFooter *)refreshFooterView {

    return objc_getAssociatedObject(self, &refreshFooterView_key);
}

- (void)addHeaderRefresh:(void (^)(void))beginRefresh {
    
    if (!self.refreshHeaderView) {
        self.refreshHeaderView = [[MJRefreshHeader alloc] init];
    }
    
    self.refreshHeaderView.beginRefreshingCompletionBlock = ^{
        beginRefresh();
    };

}

- (void)beginHeaderRefresh:(void (^)(void))beginRefresh {
    
    [self addHeaderRefresh:beginRefresh];
    [self.refreshHeaderView beginRefreshing];
}

- (void)beginFooterRefresh:(void (^)(void))beginRefresh {
    
    [self addFooterRefresh:beginRefresh];
    [self.refreshFooterView beginRefreshing];
}

- (void)addFooterRefresh:(void (^)(void))beginRefresh {
    
    if (!self.refreshFooterView) {
        self.refreshFooterView = [[MJRefreshFooter alloc] init];
    }
    self.refreshFooterView.beginRefreshingCompletionBlock = ^{
      
        beginRefresh();
    };
}



- (void)endMjRefresh {
    if (self.refreshHeaderView) {
        [self.refreshHeaderView endRefreshing];
    }
    if (self.refreshFooterView) {
        [self.refreshFooterView endRefreshing];
    }
}

- (void)freeMjRefresh {
    
//    if (self.refreshHeaderView) {
//        [self.refreshHeaderView dealloc];
//    }
//
//    if (self.refreshFooterView) {
//        [self.refreshFooterView dealloc];
//    }
}

//- (void)addTopAlpaFade {
//    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.bounds;
//    gradient.colors = [NSArray arrayWithObjects:
//                       (__bridge id)UIColor.clearColor.CGColor,
//                       UIColor.whiteColor.CGColor,
//                       nil];
//    gradient.locations = [NSArray arrayWithObjects:
//                          [NSNumber numberWithFloat:0],
//                          [NSNumber numberWithFloat:1.0/10],
//                          nil];
//    self.layer.mask = gradient;
//}

@end
