//
//  WXHMenu.m
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHMenu.h"

@implementation WXHMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    // 添加三个按钮
    [self addButtonWithImageName:@"tabbar_mood"];
    [self addButtonWithImageName:@"tabbar_photo"];
    [self addButtonWithImageName:@"tabbar_blog"];
}

- (void)addButtonWithImageName:(NSString *)imageName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.subviews.count;
    [self addSubview:btn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 判断横竖屏
    if (isLanscape) { // 横屏
        for (int i = 0; i < self.subviews.count; i ++) {
            UIButton *btn = self.subviews[i];
            btn.width = self.width / self.subviews.count;
            btn.height = btn.width;
            btn.y = 0;
            btn.x = btn.width * i;
        }
    }else{ // 竖屏
        for (int i = 0; i < self.subviews.count; i ++) {
            UIButton *btn = self.subviews[i];
            btn.width = self.width;
            btn.height = self.height / self.subviews.count;
            btn.x = 0;
            btn.y = btn.height * i;
            
        }
    }
    
}

- (void)clickAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(menu:didSelectIndex:)]) {
        [self.delegate menu:self didSelectIndex:btn.tag];
    }
}
@end
