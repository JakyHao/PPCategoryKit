//
//  UIViewController+LoadCustomerNavigationBar.h
//  UU
//
//  Created by 郝鹏飞 on 2020/5/6.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LoadCustomerNavigationBar)

- (void)loadCustomerNavigationBar;

- (void)loadCustomerNavigationBarWidthTitle:(NSString *)title leftBtn:(UIButton *)leftBtn rightBtn:(UIButton *)rightBtn;

- (void)loadDefaultBackBtn;

- (void)loadLeftBtn:(UIButton *)button andSelect:(SEL)sel;

- (void)loadRightBtns:(NSArray *)buttons andSelect:(SEL)sel;

- (void)loadTitleView:(UIView *)titleView;

- (void)customerNaviBar_viewWillAppear;

- (void)customerNaviBar_viewWillDisAppear;

- (void)isHideBottomLine:(BOOL)isHidden;



@end

NS_ASSUME_NONNULL_END
