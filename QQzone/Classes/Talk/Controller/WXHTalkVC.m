//
//  WXHTalkVC.m
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHTalkVC.h"

@interface WXHTalkVC ()

@end

@implementation WXHTalkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInit];
}

- (void)setupInit{
    // 标题
    self.title = @"说说";
    // 设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
}

- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
