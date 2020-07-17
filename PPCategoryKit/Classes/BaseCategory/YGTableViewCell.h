//
//  YGTableViewCell.h
//  UU
//
//  Created by tao on 16/4/19.
//  Copyright © 2016年 王 家振. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YGTableViewCell;

@protocol  YGTableViewCellDelegate <NSObject>

- (void)cellDidSelectWith:(YGTableViewCell *)cell;
/**
 *  删除按钮点击事件的代理方法
 */
- (void)rightDelectBtnClickWith:(YGTableViewCell *)cell;
//左滑的代理事件
- (void)scrollToCellLeftWith:(YGTableViewCell *)cell;
@end



@interface YGTableViewCell : UITableViewCell
@property (nonatomic ,strong) UIScrollView  *contentScrollView;
@property (nonatomic ,strong) UIButton  *delectBtn;
//删除按钮的宽

@property (nonatomic ,weak) id <YGTableViewCellDelegate>ygCellDelegate;
@end
