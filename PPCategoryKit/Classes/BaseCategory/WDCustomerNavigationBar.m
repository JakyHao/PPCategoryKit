//
//  WDCustomerNavigationBar.m
//  UU
//
//  Created by 郝鹏飞 on 2020/5/6.
//  Copyright © 2020 王 家振. All rights reserved.
//

#import "WDCustomerNavigationBar.h"

@interface WDCustomerNavigationBar()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray *rightBtns;

@property (nonatomic, assign) SEL rightBtnSEL;

@property (nonatomic, strong) UIViewController *targetCtl;

@property (nonatomic, strong) UIView    *bottomLine;

@end


@implementation WDCustomerNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)getNavigationBar {
    
//    WDCustomerNavigationBar *bar = [[WDCustomerNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = RGB(255, 255, 255);
        self.rightBtns = [NSMutableArray array];
        self.bottomLine.hidden = NO;
    }
    return self;
}

- (void)addNavigationBarToController:(UIViewController *)controller {
    
    [controller addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [controller.view addSubview:self];
    [controller.view bringSubviewToFront:self];
    _targetCtl = controller;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"title"]) {
        
        self.titleLabel.text = [change valueForKey:@"new"];
    }
}

- (void)setupRightBtns:(NSArray *)buttons {
    [self.rightBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightBtns removeAllObjects];
    [self.rightBtns addObjectsFromArray:buttons];
    for (int i = 0; i < self.rightBtns.count; i ++) {
        UIButton *btn = self.rightBtns[i];
        btn.tag = i + 1;
        if (self.rightBtnSEL) {
            
            [btn addTarget:_targetCtl action:self.rightBtnSEL forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview:btn];
    }
}

- (void)setupLeftBtn:(UIButton *)button {
    self.backBtn = button;
    [self addSubview:button];
}

- (void)addLeftBtnWithSelector:(SEL)sel {
    
    [self.backBtn addTarget:_targetCtl action:sel forControlEvents:UIControlEventTouchUpInside];

}

- (void)addRightBtnSelector:(SEL)sel {
    
    self.rightBtnSEL = sel;
    [self.rightBtns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = (UIButton *)obj;
        [btn addTarget:_targetCtl action:self.rightBtnSEL forControlEvents:UIControlEventTouchUpInside];
    }];
}


- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarHeight, 300, 44)];
//        _titleLabel.textColor = RGBA(0, 0, 0, 1);
//        _titleLabel.font = TEXT_FONT_BLOD(17);
//        _titleLabel.centerX = self.centerX;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;;
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _backBtn.frame = CGRectMake(8.5, StatusBarHeight+8, 28, 28);
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"back_arrow_black"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
//        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-0.25, SCREEN_WIDTH, 0.25)];
//        _bottomLine.backgroundColor = RGB(169, 169, 169);
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (void)setTitleView:(UIView *)titleView {
    
    [self addSubview:titleView];
}

- (void)isHideBottomLine:(BOOL)isHidden {
    
    self.bottomLine.hidden = isHidden;
}

- (void)dealloc {
    
    [_targetCtl removeObserver:self forKeyPath:@"title"];
}


@end
