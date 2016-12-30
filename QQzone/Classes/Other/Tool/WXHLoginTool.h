//
//  WXHLoginTool.h
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXHLoginTool : NSObject

/**
 登录工具

 @param account 账号
 @param password 密码
 @param loginResult 是否登录成功
 */
+ (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password result:(void(^)(BOOL isSuccess))loginResult;


/**
 记住密码

 @param isRemember 是否记住密码
 */
+ (void)rememberPassword:(BOOL)isRemember;


/**
 自动登录

 @param isAutoLogin 是否自动登录
 */
+ (void)autoLogin:(BOOL)isAutoLogin;


/**
 获取账号

 @return 账号
 */
+ (NSString *)getAccount;


/**
 获取密码

 @return 密码
 */
+ (NSString *)getPassword;


/**
 获取记住密码的状态

 @return 记住密码的状态
 */
+ (BOOL)getRememberPasswordState;


/**
 获取自动登录的状态

 @return 自动登录的状态
 */
+ (BOOL)getAutoLoginState;
@end
