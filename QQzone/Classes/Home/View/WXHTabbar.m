//
//  WXHTabbar.m
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHTabbar.h"
#import "WXHTabbarButton.h"

@interface WXHTabbar()
/** 当前选中按钮*/
@property(nonatomic,weak) WXHTabbarButton *currentBtn;
@end
@implementation WXHTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupSubviews{
    // 添加按钮
    [self addButtonWithImageName:@"tab_bar_feed_icon" andTitle:@"全部动态"];
    [self addButtonWithImageName:@"tab_bar_passive_feed_icon" andTitle:@"与我相关"];
    [self addButtonWithImageName:@"tab_bar_pic_wall_icon" andTitle:@"照片墙"];
    [self addButtonWithImageName:@"tab_bar_e_album_icon" andTitle:@"电子相框"];
    [self addButtonWithImageName:@"tab_bar_friend_icon" andTitle:@"好友"];
    [self addButtonWithImageName:@"tab_bar_e_more_icon" andTitle:@"更多"];
    
}

- (void)addButtonWithImageName:(NSString *)imageName andTitle:(NSString *)title
{
    WXHTabbarButton *btn = [WXHTabbarButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchDown];
    
    // 绑定tag
    btn.tag = self.subviews.count;
    
    [self addSubview:btn];
}

#pragma mark - 对子控件布局
- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.width = self.width;
        btn.height = self.height / self.subviews.count;
        btn.x = 0;
        btn.y = btn.height * i;
    }
}

- (void)clickAction:(WXHTabbarButton *)btn{
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectIndex:fromIndex:)]) {
        [self.delegate tabbar:self didSelectIndex:btn.tag fromIndex:self.currentBtn.tag];
    }
    self.currentBtn.selected = NO;
    self.currentBtn = btn;
    self.currentBtn.selected = YES;
}

#pragma mark - 清除当前选中的按钮
- (void)clearSelect{
    self.currentBtn.selected = NO;
}
@end
