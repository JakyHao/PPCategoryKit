//
//  WDBaseTableView.h
//  UU
//
//  Created by 郝鹏飞 on 2020/5/8.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WDTableViewDelegate <NSObject>

@required

@optional

/// 设置右边标题栏数据源，不设置或返回nil则不显示
/// @param tableView 当前tableview对象
- (NSArray <NSString *> *_Nullable)wd_sectionIndexTitlesForTableView:(UITableView *_Nullable)tableView;

/// 设置右边标题栏选中状态字体颜色，不设置或返回nil则为默认颜色
- (UIColor *_Nullable)wd_sectionIndexTitleSelectedColor;

/// 设置右边表体验未选中颜色，不设置或返回nil则为默认颜色
- (UIColor *_Nullable)wd_sectionIndexTitleNormalColor;

///// 返回当前悬浮在顶端的section
///// @param tableView 当前tableview对象
///// @param section 当前悬浮的顶端的section
//- (void)wd_tableView:(UITableView *_Nullable)tableView topTitleSection:(NSInteger)section;

@end


NS_ASSUME_NONNULL_BEGIN

@interface WDBaseTableView : UITableView

@property (nonatomic ,weak)  id<WDTableViewDelegate>  wdDelegate;

@end


/// 与右侧标题对应的sectionheaderview
@interface WDTitleHeaderView : UITableViewHeaderFooterView

/// 设置title
/// @param title 设置title颜色
- (void)setupTitle:(NSString *)title;

- (void)setupTitleColor:(UIColor *)color;

- (void)setupTitleFont:(UIFont *)font;

@end


NS_ASSUME_NONNULL_END
