//
//  YGTableViewCell.m
//  UU
//
//  Created by tao on 16/4/19.
//  Copyright © 2016年 王 家振. All rights reserved.
//

#import "YGTableViewCell.h"

#define DELECT_BTN_WIDTH 80

@interface YGTableViewCell ()<UIScrollViewDelegate>


@end


@implementation YGTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
#pragma mark - 这个是自定义的scrollView
    UIScrollView *contentScrollView  = [[UIScrollView alloc]init];
//    contentScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH + DELECT_BTN_WIDTH, 80);
    contentScrollView.scrollEnabled = YES;
    //contentScrollView.sct
    self.contentScrollView = contentScrollView;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.bounces = NO;
    self.contentScrollView.delegate = self;
    //contentScrollView.backgroundColor = [UIColor redColor];
//    contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH + DELECT_BTN_WIDTH + DELECT_BTN_WIDTH, 0);
    [self.contentView addSubview:contentScrollView];
    
    //.删除按钮
    UIButton *delectBtn = [[UIButton alloc]init];
    [delectBtn setImage:[UIImage imageNamed:@"message_delect_YG"] forState:UIControlStateNormal];
//    delectBtn.frame = CGRectMake(SCREEN_WIDTH, 0, DELECT_BTN_WIDTH, 80);
    //[delectBtn sizeToFit];
//    delectBtn.backgroundColor = RGB(235, 237, 240);
    self.delectBtn = delectBtn;
    [self.contentScrollView addSubview:delectBtn];
    [delectBtn addTarget:self action:@selector(delectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加最上面的btn
    UIButton *topBtn = [[UIButton alloc]init];
//    topBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    [self.contentScrollView addSubview:topBtn];
    [topBtn addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark -添加选中按钮
    
}




- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"这里是停止拖拽的代理方法%f",scrollView.contentOffset.x);
    //取当前的滚动
    CGPoint contentSet = scrollView.contentOffset;
    if (contentSet.x >= DELECT_BTN_WIDTH*0.5) {
        contentSet.x = DELECT_BTN_WIDTH;
        //self.contentScrollView.contentOffset = contentSet;
        contentSet.x = DELECT_BTN_WIDTH;
        [self.contentScrollView setContentOffset:contentSet animated:YES];
        //左滑
                if ([self.ygCellDelegate respondsToSelector:@selector(scrollToCellLeftWith:)]) {
                    [self.ygCellDelegate scrollToCellLeftWith:self];
                }
    }else{
        contentSet.x = 0;
        [self.contentScrollView setContentOffset:contentSet animated:YES];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark 带来方法
#pragma mark 代理方法
- (void)delectBtnClick{
    //NSLog(@"自己写的selectBtn点击了");
    if ([self.ygCellDelegate respondsToSelector:@selector(rightDelectBtnClickWith:)]) {
        [self.ygCellDelegate rightDelectBtnClickWith:self];
    }
   
}


- (void)topBtnClick{
    //NSLog(@"自己写的top按钮点击了");
    if ([self.ygCellDelegate respondsToSelector:@selector(cellDidSelectWith:)]) {
        
        [self.ygCellDelegate cellDidSelectWith:self];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}



@end
