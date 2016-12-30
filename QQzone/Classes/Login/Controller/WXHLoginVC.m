//
//  WXHLoginVC.m
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHLoginVC.h"
#import "WXHLoginTool.h"
#import "WXHHUDTool.h"
#import "WXHHomeVC.h"
@interface WXHLoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *remberBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
/** 做动画的视图*/
@property (weak, nonatomic) IBOutlet UIView *animatedView;
/** 指示器*/
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation WXHLoginVC

- (void)viewDidLoad {
	[super viewDidLoad];
	// 初始化
	[self setupInit];
}
#pragma mark - 初始化
- (void)setupInit
{
	// 填充记录的用户名
	self.accountTF.text = [WXHLoginTool getAccount];
	self.pwdTF.text = [WXHLoginTool getPassword];
	
	// 记录状态显示
	self.remberBtn.selected = [WXHLoginTool getRememberPasswordState];
	self.autoLoginBtn.selected = [WXHLoginTool getAutoLoginState];
}
#pragma mark - 业务逻辑
#pragma mark * 记住密码
- (IBAction)remberAction:(UIButton *)sender {
	self.remberBtn.selected = !self.remberBtn.selected;
	// 如果没有记住密码,则自动登录也是false
	if (!sender.selected) {
		self.autoLoginBtn.selected = NO;
	}
	// 是否记住密码
	[WXHLoginTool rememberPassword:sender.selected];
	NSLog(@"%d",sender.selected);
}
#pragma mark * 自动登录
- (IBAction)autoLoginAction:(UIButton *)sender {
	self.autoLoginBtn.selected = !self.autoLoginBtn.selected;
	// 如果点击了自动登录,则记住密码是true
	if (sender.selected) {
		self.remberBtn.selected = YES;
	}
	// 是否自动登录
	[WXHLoginTool autoLogin:sender.selected];
}
#pragma mark * 登录前的状态
- (void)preLogin{
	// 1.禁止用户交互
	self.view.userInteractionEnabled = NO;
	// 2.开启转圈动画
	[self.activityView startAnimating];
}
#pragma mark * 登录后的状态
- (void)endLogin{
	// 1.开启用户交互
	self.view.userInteractionEnabled = YES;
	// 2.停止转圈动画
	[self.activityView stopAnimating];
}
#pragma mark * 登录错误(抖一抖)
- (void)loginError{
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
	animation.values = @[@(-10), @(0), @(10), @(0)];
	animation.duration = 0.1;
	animation.repeatCount = 5;
	[self.animatedView.layer addAnimation:animation forKey:nil];
}

#pragma mark * 登录
// 控制器只负责业务逻辑的调用,不关心具体是如何实现的
- (IBAction)loginAction:(UIButton *)sender {
	// 获取用户名跟密码
	NSString *account = self.accountTF.text;
	NSString *pwd = self.pwdTF.text;
	
	// 登录成功或失败之前做的处理
	[self preLogin];
	
	// 发送给服务器,验证身份
	[WXHLoginTool loginWithAccount:account andPassword:pwd result:^(BOOL isSuccess) {
		if (isSuccess) {
			NSLog(@"成功");
			// 成功之后跳转界面(切换根控制器)
			[UIApplication sharedApplication].keyWindow.rootViewController = [[WXHHomeVC alloc] init];
			
		}else{
			NSLog(@"失败");
			// 错误提示
			// 抖一抖
			[self loginError];
			// HUD
			[WXHHUDTool showMessage:@"账号或密码错误"];
		}
		// 登录完成后要要做的处理
		[self endLogin];
	}];
	
}

#pragma mark - <UITextFieldDelegate>
#pragma mark * 当用户点击return的时候调用
// (实现用户点击键盘, 自动获取帐号或者密码输入框焦点)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	
	// 判断
	if (textField == self.accountTF) { // 当前处于账号输入框时,让密码输入框变为第一响应者
		[self.pwdTF becomeFirstResponder];
		
	}else{ // 否则直接登录
		[self loginAction:nil];
	}
	return YES;
}

#pragma mark - 设置状态栏状态
- (UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	// 判断是否自动登录
	if ([WXHLoginTool getAutoLoginState]) {
		// 登录
		[self loginAction:nil];
	}
}
@end
