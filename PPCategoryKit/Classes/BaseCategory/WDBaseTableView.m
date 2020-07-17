//
//  WDBaseTableView.m
//  UU
//
//  Created by 郝鹏飞 on 2020/5/8.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import "WDBaseTableView.h"

#define RightTitleDefaultColor RGB(109,109,114)

#define RightTitleViewRightMargin 2

@interface WDBaseTableView()<UIScrollViewDelegate>

/************右侧标题栏*****************/
@property (nonatomic, strong) NSMutableArray *wd_rightTitleBtnArray;

/************右侧标题栏按钮未选中颜色*****************/
@property (nonatomic ,strong)  UIColor  *wd_rightTitleNormalColor;

/************右侧标题栏已选中颜色*****************/
@property (nonatomic ,strong)  UIColor  *wd_rightTitleSelectColor;

/************右侧标题栏容器*****************/
@property (nonatomic ,strong)  UIView  *wd_rightTitleContentView;

/************最后一次选择的标题*****************/
@property (nonatomic ,strong)  UIButton  *wd_lastSelectedTitleBtn;

/************当前悬停的section*****************/
@property (nonatomic ,assign)  NSInteger  wd_currentSection;

/************是否已经滑动过*****************/
@property (nonatomic ,assign)  BOOL  wd_hadScrolled;

/************是否设置过监听*****************/
@property (nonatomic ,assign)  BOOL  wd_hadSetScrollObserver;

/************当前悬停的sectionview*****************/
@property (nonatomic ,strong)  WDTitleHeaderView  *wd_currentHeaderView;

@end

@implementation WDBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark 重写reload方法
- (void)reloadData {
    
    [super reloadData];
    _wd_hadScrolled = NO;
//    self.wd_rightTitleSelectColor = RightTitleDefaultColor;
//    self.wd_rightTitleNormalColor = RightTitleDefaultColor;
    if (self.wdDelegate && [self.wdDelegate respondsToSelector:@selector(wd_sectionIndexTitleNormalColor)]) {
        
        UIColor *normalColor = [self.wdDelegate wd_sectionIndexTitleNormalColor];
        if (normalColor) {
            self.wd_rightTitleNormalColor = normalColor;
        }else {
//            self.wd_rightTitleNormalColor = RightTitleDefaultColor;
        }
    }
    
    if (self.wdDelegate && [self.wdDelegate respondsToSelector:@selector(wd_sectionIndexTitleSelectedColor)]) {
        
        UIColor *selectColor = [self.wdDelegate wd_sectionIndexTitleSelectedColor];
        if (selectColor) {
            self.wd_rightTitleSelectColor = selectColor;
        }else {
//            self.wd_rightTitleSelectColor = RightTitleDefaultColor;
        }
    }
    
    if (self.wdDelegate && [self.wdDelegate respondsToSelector:@selector(wd_sectionIndexTitlesForTableView:)]) {
        
        NSArray *titles = [self.wdDelegate wd_sectionIndexTitlesForTableView:self];
        [self.wd_rightTitleBtnArray removeAllObjects];
        [self.wd_rightTitleContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self setupRightTitleView:titles];
        
    }
}


#pragma mark 创建自定义右侧标题按钮
- (void)setupRightTitleView:(NSArray *)titles {
    
    [self.superview layoutSubviews];
    if (titles && titles.count > 0) {
        self.wd_rightTitleContentView.hidden = NO;
        int index = 0;
//        self.wd_rightTitleContentView.frame = CGRectMake(self.width - 2 - 12, 0, 12, 12*titles.count);
//        self.wd_rightTitleContentView.centerY = self.centerY;
        for (NSString *title in titles) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:self.wd_rightTitleNormalColor forState:UIControlStateNormal];
            [button setTitleColor:self.wd_rightTitleSelectColor forState:UIControlStateSelected];
//            button.titleLabel.font = TEXT_FONT(11);
            button.frame = CGRectMake(0, 12*index, 12, 12);
            button.tag = index;
            [button addTarget:self action:@selector(wd_titleBtnCliced:) forControlEvents:UIControlEventTouchUpInside];
            [self.wd_rightTitleContentView addSubview:button];
            [self.wd_rightTitleBtnArray addObject:button];
            index ++;
        }
        
        
        if (_wd_hadSetScrollObserver) {
            [self removeObserver:self forKeyPath:@"contentOffset"];
        }
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        _wd_hadSetScrollObserver = YES;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getNowTopSectionView];
//        });
        
    }else {
        
        self.wd_rightTitleContentView.hidden = YES;
        if (_wd_hadSetScrollObserver) {
             [self removeObserver:self forKeyPath:@"contentOffset"];
        }
        _wd_hadSetScrollObserver = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self getNowTopSectionView];
}


- (void)getNowTopSectionView {
    
    NSArray <UITableViewCell *> *cellArray = [self visibleCells];
    NSInteger nowSection = -1;
    if (cellArray) {
        UITableViewCell *cell = [cellArray firstObject];
        NSIndexPath *indexPath = [self indexPathForCell:cell];
        nowSection = indexPath.section;
    }
    
    [self wd_titleBtnChange:self.wd_rightTitleBtnArray[nowSection]];
    
    if (_wd_currentSection == nowSection && _wd_hadScrolled) {
        return;
    }
    _wd_hadScrolled = YES;
    NSLog(@"当前悬停的组头是:%ld",nowSection);
    _wd_currentSection = nowSection;
    
//    if (self.wdDelegate && [self.wdDelegate respondsToSelector:@selector(wd_tableView:topTitleSection:)]) {
////        [self.wdDelegate wd_tableView:self topTitleSection:nowSection];
//    }
    if (self.wd_currentHeaderView && [self.wd_currentHeaderView  isKindOfClass:[WDTitleHeaderView class]]) {
        [self.wd_currentHeaderView setupTitleColor:self.wd_rightTitleNormalColor];
    }
//<<<<<<< HEAD
    WDTitleHeaderView *view = (WDTitleHeaderView *)[self headerViewForSection:nowSection];
    if (view && [view isKindOfClass:[WDTitleHeaderView class]]) {
         [view setupTitleColor:self.wd_rightTitleSelectColor];
    }

    self.wd_currentHeaderView = view;
//=======
//    id sectionView = [self headerViewForSection:nowSection];
//    if ([sectionView isKindOfClass:[WDTitleHeaderView class]]) {
//        WDTitleHeaderView *view = (WDTitleHeaderView *)sectionView;
//        [view setupTitleColor:self.wd_rightTitleSelectColor];
//        self.wd_currentHeaderView = view;
//    }
    
//>>>>>>> subDevelopRedMan
}

#pragma mark 自定义右侧标题按钮点击事件
- (void)wd_titleBtnCliced:(UIButton *)button {
    if (self.wd_lastSelectedTitleBtn == button) {
        return;
    }
    [self wd_titleBtnChange:button];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:button.tag];
    [self scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self getNowTopSectionView];
}

- (void)wd_titleBtnChange:(UIButton *)button {
    if (self.wd_lastSelectedTitleBtn) {
           self.wd_lastSelectedTitleBtn.selected = NO;
       }
       button.selected = YES;
       self.wd_lastSelectedTitleBtn = button;
}




#pragma mark 初始化右侧标题栏保存数组
- (NSMutableArray *)wd_rightTitleBtnArray {
    
    if (!_wd_rightTitleBtnArray) {
        _wd_rightTitleBtnArray = [NSMutableArray array];
        
    }
    return _wd_rightTitleBtnArray;;
}

- (UIView *)wd_rightTitleContentView {
    
    if (!_wd_rightTitleContentView) {
        _wd_rightTitleContentView = [[UIView alloc] init];
        [self.superview addSubview:_wd_rightTitleContentView];
    }
    
    return _wd_rightTitleContentView;
}




@end

@interface WDTitleHeaderView()

/************标题label*****************/
@property (nonatomic ,strong)  UILabel  *titleLabel;
/************背景*****************/
@property (nonatomic ,strong)  UIView  *backView;

@end

@implementation WDTitleHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [WDProjectColorConfig wd_projectColor:WDProjectColorWD0xFAFAFA];
    }
    return self;
}

- (void)setupTitle:(NSString *)title {
    
   self.backView.hidden = NO;
    self.titleLabel.text = title;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.backView.frame = self.bounds;
//    self.titleLabel.frame = CGRectMake(15, 0, self.width - 30, 19);
//    _titleLabel.centerY = self.height/2.f;
}

- (void)setupTitleColor:(UIColor *)color {
    self.backView.hidden = NO;
    self.titleLabel.textColor = color;
}

- (void)setupTitleFont:(UIFont *)font{
    self.backView.hidden = NO;
    self.titleLabel.font = font;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.width - 30, 19)];
//        _titleLabel.textColor = RGB(109, 109, 114);
//        _titleLabel.font = NUMBER_FONT(13);
//        _titleLabel.centerY = self.height/2.f;
//        _titleLabel.backgroundColor = [WDProjectColorConfig wd_projectColor:WDProjectColorWD0xFAFAFA];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;;
}

- (UIView *)backView {
    
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
//        _backView.backgroundColor = [WDProjectColorConfig wd_projectColor:WDProjectColorWD0xFAFAFA];
         [self addSubview:_backView];
    }
    return _backView;
}

@end
