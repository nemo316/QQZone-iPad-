//
//  WXHDockView.m
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHDockView.h"

@interface WXHDockView()
/** 底部菜单*/
@property(nonatomic,weak) WXHMenu *menuView;
/** 中间菜单*/
@property(nonatomic,weak) WXHTabbar *tabBarView;
/** 头像*/
@property(nonatomic,weak) WXHHeadIcon *iconBtn;
@end

@implementation WXHDockView
// 通过懒加载创建三个控件
- (WXHMenu *)menuView{
	if (_menuView == nil) {
		WXHMenu *menuView = [[WXHMenu alloc] init];
		[self addSubview:menuView];
		_menuView = menuView;
	}
	return _menuView;
}
- (WXHTabbar *)tabBarView{
	if (_tabBarView == nil) {
		WXHTabbar *tabBarView = [[WXHTabbar alloc] init];
		[self addSubview:tabBarView];
		_tabBarView	 = tabBarView;
	}
	return _tabBarView;
}
- (WXHHeadIcon *)iconBtn{
	if (_iconBtn == nil) {
		WXHHeadIcon *iconBtn = [WXHHeadIcon buttonWithType:UIButtonTypeCustom];
        [iconBtn setImage:[UIImage imageNamed:@"icon.jpg"] forState:UIControlStateNormal];
        [iconBtn setTitle:@"我是谁?" forState:UIControlStateNormal];
        [iconBtn addTarget:self action:@selector(headClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconBtn];
		_iconBtn = iconBtn;
	}
	return _iconBtn;
}
// 对底部三个子控件布局
- (void)layoutSubviews{
	[super layoutSubviews];
    
	self.menuView.x = 0;
	self.menuView.width = self.width;
	// 菜单布局
	if(isLanscape)
	{
		self.menuView.height = kMenueHeightL;
		self.menuView.y = self.height - self.menuView.height;
	}
	else
	{
		self.menuView.height = kMenueHeightP;
		self.menuView.y = self.height - self.menuView.height;
	}
	
	
	// tabbar布局
	self.tabBarView.width = self.width;
	self.tabBarView.height = kTabbarHeightLP;
	self.tabBarView.x = 0;
	self.tabBarView.y = self.height - self.menuView.height - self.tabBarView.height;
	
	
	// icon 布局
	if (isLanscape) {
		self.iconBtn.width = kIconWHL;
		self.iconBtn.height = kIconWHL;
	}else
	{
		self.iconBtn.width = kIconWHP;
		self.iconBtn.height = kIconWHP;
	}
	self.iconBtn.center = CGPointMake(self.width * 0.5, self.tabBarView.y * 0.5);
	
	
}

#pragma mark - 点击事件
- (void)headClickAction{
    
    // 清空选择的按钮
    [self.tabBarView clearSelect];
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(dockDidSlelectHeadIcon)]) {
        [self.delegate dockDidSlelectHeadIcon];
    }
}

#pragma mark - 重写delegate的代理方法
- (void)setDelegate:(id<WXHDockViewDelegate>)delegate{
    _delegate = delegate;
    self.menuView.delegate = delegate;
    self.tabBarView.delegate = delegate;
}
@end
