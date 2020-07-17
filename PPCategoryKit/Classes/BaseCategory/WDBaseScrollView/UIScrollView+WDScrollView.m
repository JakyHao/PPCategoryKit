//
//  UIScrollView+WDScrollView.m
//  UU
//
//  Created by 郝鹏飞 on 2020/6/8.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import "UIScrollView+WDScrollView.h"
#import <objc/runtime.h>
@interface UIScrollView ()

//@property (nonatomic ,strong) MJRefreshHeaderView *refreshHeaderView;
//
//@property (nonatomic ,strong) MJRefreshFooterView *refreshFooterView;

@end

static char refreshHeaderView_key,refreshFooterView_key;

@implementation UIScrollView (WDScrollView)

#pragma 添加属性set get 方法
//- (void)setRefreshHeaderView:(MJRefreshHeaderView *)refreshHeaderView {
//
//    objc_setAssociatedObject(self, &refreshHeaderView_key, refreshHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (void)setRefreshFooterView:(MJRefreshFooterView *)refreshFooterView {
//
//    objc_setAssociatedObject(self, &refreshFooterView_key, refreshFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (MJRefreshHeaderView *)refreshHeaderView {
//
//    return objc_getAssociatedObject(self, &refreshHeaderView_key);
//}
//
//- (MJRefreshFooterView *)refreshFooterView {
//
//    return objc_getAssociatedObject(self, &refreshFooterView_key);
//}

- (void)addHeaderRefresh:(void (^)())beginRefresh {
    
//    if (!self.refreshHeaderView) {
//        self.refreshHeaderView = [MJRefreshHeaderView header];
//    }
    
//    self.refreshHeaderView.scrollView = self;
//    self.refreshHeaderView.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
      
        beginRefresh();
//    };
}

- (void)addFooterRefresh:(void (^)())beginRefresh {
    
//    if (!self.refreshFooterView) {
//        self.refreshFooterView = [MJRefreshFooterView footer];
//    }
    
//    self.refreshFooterView.scrollView = self;
//    self.refreshFooterView.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        beginRefresh();
//    };
}

- (void)endMjRefresh {
//    if (self.refreshHeaderView) {
//        [self.refreshHeaderView endRefreshing];
//    }
//    if (self.refreshFooterView) {
//        [self.refreshFooterView endRefreshing];
//    }
}

- (void)freeMjRefresh {
    
//    if (self.refreshHeaderView) {
//        [self.refreshHeaderView free];
//    }
//
//    if (self.refreshFooterView) {
//        [self.refreshFooterView free];
//    }
}

- (void)addTopAlpaFade {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (__bridge id)UIColor.clearColor.CGColor,
                       UIColor.whiteColor.CGColor,
                       nil];
    gradient.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:1.0/10],
                          nil];
    self.layer.mask = gradient;
}

@end
