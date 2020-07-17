//
//  UIViewController+LoadCustomerNavigationBar.m
//  UU
//
//  Created by 郝鹏飞 on 2020/5/6.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import "UIViewController+LoadCustomerNavigationBar.h"
#import "WDCustomerNavigationBar.h"
#import <objc/runtime.h>

@interface UIViewController ()

/************自定义导航栏*****************/
@property (nonatomic ,strong)  WDCustomerNavigationBar *  customerNavigationBar;

@end

static char customerNavigationBar_key;

@implementation UIViewController (LoadCustomerNavigationBar)

- (WDCustomerNavigationBar *)customerNavigationBar {
    
    return objc_getAssociatedObject(self, &customerNavigationBar_key);;
}

- (void)setCustomerNavigationBar:(WDCustomerNavigationBar *)customerNavigationBar {
    
    objc_setAssociatedObject(self, &customerNavigationBar_key, customerNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)loadCustomerNavigationBar {
    
    if (!self.customerNavigationBar) {
        self.customerNavigationBar = [WDCustomerNavigationBar getNavigationBar];
        [self.customerNavigationBar addNavigationBarToController:self];
    }
    
}

- (void)loadCustomerNavigationBarWidthTitle:(NSString *)title leftBtn:(UIButton *)leftBtn rightBtn:(UIButton *)rightBtn {
    
    [self loadCustomerNavigationBar];
    if (leftBtn) {
        [self loadLeftBtn:leftBtn andSelect:@selector(leftBtnMethod)];
    }
    if (rightBtn) {
        
        [self loadRightBtns:@[rightBtn] andSelect:@selector(rightBtnMethod)];
    }
    
    
    self.title = title;
}

- (void)loadDefaultBackBtn {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_arrow_black"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.frame = CGRectMake(8.5, 4+StatusBarHeight, 28, 28);
    [self.customerNavigationBar addSubview:backBtn];
//    [self loadLeftBtn:backBtn andSelect:@selector(leftBtnMethod)];
//    [self ]
}

- (void)loadLeftBtn:(UIButton *)button andSelect:(SEL)sel {
//    [self.customerNavigationBar addSubview:button];
    if (sel) {
        
        [self.customerNavigationBar addLeftBtnWithSelector:sel];
    }
    
}

- (void)loadRightBtns:(NSArray *)buttons andSelect:(SEL)sel {
    
    if (buttons) {
        [self.customerNavigationBar setupRightBtns:buttons];
    }
    if (sel) {
        
        [self.customerNavigationBar addRightBtnSelector:sel];
    }
    
    
}

- (void)loadTitleView:(UIView *)titleView {
    
    [self.customerNavigationBar setTitleView:titleView];
}

- (void)customerNaviBar_viewWillAppear {
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)customerNaviBar_viewWillDisAppear {
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)isHideBottomLine:(BOOL)isHidden {
    
    [self.customerNavigationBar isHideBottomLine:isHidden];
}

@end
