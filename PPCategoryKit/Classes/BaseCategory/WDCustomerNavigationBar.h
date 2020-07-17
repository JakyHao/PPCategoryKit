//
//  WDCustomerNavigationBar.h
//  UU
//
//  Created by 郝鹏飞 on 2020/5/6.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDCustomerNavigationBar : UIView


+ (instancetype)getNavigationBar;

- (void)addNavigationBarToController:(UIViewController *)controller;

- (void)addLeftBtnWithSelector:(SEL)sel;

- (void)addRightBtnSelector:(SEL)sel;

- (void)setupRightBtns:(NSArray *)buttons;

- (void)setupLeftBtn:(UIButton *)button;

- (void)setTitleView:(UIView * _Nonnull)titleView;

- (void)isHideBottomLine:(BOOL)isHidden;

/************标题*****************/
@property (nonatomic ,strong)  NSString  *title;

@end

NS_ASSUME_NONNULL_END
