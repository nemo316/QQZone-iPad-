//
//  WXHLoginTool.m
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHLoginTool.h"
#define kIsRememberPassword @"isRememberPassword"
#define kIsAutoLogin @"isAutoLogin"

#define kAccountKey @"accountKey"
#define kPassworkdKey @"passworkdKey"

@implementation WXHLoginTool

#pragma mark - 登录
+ (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password result:(void (^)(BOOL))loginResult{
    
    // 在本地进行判断,以后如果修改,直接在此处改成发送给服务器,不需要改接口
    // 记住账号
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:kAccountKey];
    
    // 在后面的某个时间点,把任务扔到对应的线程,排队
    // 参数1: 当前时间
    // 参数2: 要延迟的时间(单位: 纳秒)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([account isEqualToString:@"wxh"] && [password isEqualToString:@"123"]) {
            // 登录成功
            loginResult(YES);
            // 判断是否需要记住密码
            BOOL isRememberPassword = [self getRememberPasswordState];
            if (isRememberPassword) {
                // 记住密码
                [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassworkdKey];
            }else{
                // 移除密码
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPassworkdKey];
            }
        }else{ // 登录失败
            loginResult(NO);
        }
        // 执行
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
}

#pragma mark - 记住密码
+ (void)rememberPassword:(BOOL)isRemember{
    [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:kIsRememberPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 自动登录
+ (void)autoLogin:(BOOL)isAutoLogin{
    [[NSUserDefaults standardUserDefaults] setBool:isAutoLogin forKey:kIsAutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 获取账号
+ (NSString *)getAccount{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAccountKey];
}
#pragma mark - 获取密码
+ (NSString *)getPassword{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPassworkdKey];
}
#pragma mark - 获取记住密码的状态
+ (BOOL)getRememberPasswordState{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsRememberPassword];
}
#pragma mark - 获取自动登陆的状态
+ (BOOL)getAutoLoginState{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsAutoLogin];
}
@end
