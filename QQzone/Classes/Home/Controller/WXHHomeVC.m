//
//  WXHHomeVC.m
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHHomeVC.h"
#import "WXHDockView.h"
#import "WXHTalkVC.h"
#import "WXHAllVC.h"
@interface WXHHomeVC ()<WXHDockViewDelegate>
/** 左侧视图*/
@property(nonatomic,weak) WXHDockView *dockView;
/** 右侧视图*/
@property(nonatomic,weak) UIView *contentView;
@end

@implementation WXHHomeVC
// 横竖屏适配其实就是获知横竖屏切换时的事件,然后再对应的方法里面,重新调整控件的大小,或者控件的排布,或者控件的状态
/*
 监听横竖屏的变化可以采用以下方案:
 1. 通知: UIDeviceOrientationDidChangeNotification
 2. - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;
 3. - (void)viewWillLayoutSubviews;
 */

- (WXHDockView *)dockView{
	if (_dockView == nil) {
		WXHDockView *dockView = [[WXHDockView alloc] init];
		[self.view addSubview:dockView];
        dockView.delegate = self;
		_dockView = dockView;
	}
	return _dockView;
}
- (UIView *)contentView{
	if (_contentView == nil) {
		UIView *contentView = [[UIView alloc] init];
		contentView.backgroundColor = [UIColor greenColor];
		[self.view addSubview:contentView];
        _contentView = contentView;
        
        // 添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [contentView addGestureRecognizer:pan];
	}
	return _contentView;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	// 界面处理
	[self setupInit];
	// 创建左侧视图
	
	// 创建右侧视图
	
    // 添加自控制器
    [self setUpChildVC];
    
    // 默认选中个人中心
    [self dockDidSlelectHeadIcon];
}
#pragma mark - 添加自控制器
- (void)setUpChildVC
{
    
    [self addChildVCWith:[[WXHAllVC alloc] init] andTitle:@"全部动态"];
    [self addChildVCWith:[[UIViewController alloc] init] andTitle:@"与我相关"];
    [self addChildVCWith:[[UIViewController alloc] init] andTitle:@"照片墙"];
    [self addChildVCWith:[[UIViewController alloc] init] andTitle:@"电子相框"];
    [self addChildVCWith:[[UIViewController alloc] init] andTitle:@"好友"];
    [self addChildVCWith:[[UIViewController alloc] init] andTitle:@"更多"];
    
    [self addChildVCWith:[[UIViewController alloc] init] andTitle:@"个人中心"];
    
}

- (void)addChildVCWith:(UIViewController *)vc andTitle:(NSString *)title
{
    vc.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - 布局子控件
- (void)viewWillLayoutSubviews{
	[super viewWillLayoutSubviews];
	// 设置frame
	// 判断横竖屏状态,设置不同的值
	// dock
	self.dockView.x = 0;
	self.dockView.y = 0;
	self.dockView.height = kHeight;
	if (isLanscape) { // 横屏
		self.dockView.width = kDockWidthL;
	}else{ // 竖屏
		self.dockView.width = kDockWidthP;
	}
	
	// content
//	self.contentView.frame = CGRectMake(self.dockView.width, 20, kWidth - kDockWidthL - 40, kHeight - 20);
    self.contentView.x = self.dockView.width;
    self.contentView.y = 20;
    self.contentView.height = self.view.height - 20;
    self.contentView.width = self.view.width - self.dockView.width - 40;

	
}
#pragma mark - 界面处理
- (void)setupInit{
	// 设置背景色
	self.view.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:1];
}
#pragma mark - 手势监听事件
- (void)pan:(UIPanGestureRecognizer *)pan{
    // 判断当前是拖动还是停止
    if (pan.state == UIGestureRecognizerStateChanged) { // 拖动
        CGPoint point = [pan translationInView:self.contentView];
        // 0.7阻尼系数
        self.contentView.x = self.dockView.width + point.x * 0.7;
    }else if(pan.state == UIGestureRecognizerStateEnded){ // 停止
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.contentView.x = self.dockView.width;
        } completion:nil];
    }
}
#pragma mark - <WXHDockViewDelegate>
- (void)dockDidSlelectHeadIcon{
    NSLog(@"点击了头像");
    // 移除之前添加过的视图
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 获取最新的视图添加
    UIViewController *currentVC = [self.childViewControllers lastObject];
    currentVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:currentVC.view];
}
- (void)menu:(WXHMenu *)menu didSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            NSLog(@"说说");
            // 模态弹出一个控制器,发表说说
            WXHTalkVC *talkVC = [[WXHTalkVC alloc] init];
            UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:talkVC];
            // 弹出的最终效果
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            // 过渡效果
//            nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
        case 1:{
            NSLog(@"相册");
            break;
        }
        case 2:{
            NSLog(@"日志");
            break;
        }
        default:
            break;
    }
}
- (void)tabbar:(id)tabbar didSelectIndex:(NSInteger)selectIndex fromIndex:(NSInteger)oldIndex{
    NSLog(@"%zd---%zd", selectIndex, oldIndex);
    // 移除之前添加过的视图
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 获取最新的视图添加进来
    UIViewController *currentVC = self.childViewControllers[selectIndex];
    currentVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:currentVC.view];
}
#pragma mark - 设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}
@end
