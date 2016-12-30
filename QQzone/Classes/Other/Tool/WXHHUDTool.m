//
//  WXHHUDTool.m
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHHUDTool.h"
#define iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
@interface WXHHUDTool()<UIActionSheetDelegate>

@end

@implementation WXHHUDTool

+ (void)showMessage:(NSString *)message{
    if (iOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示9.0" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"友情提示8.0" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
@end
