//
//  WXHAllVC.m
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHAllVC.h"

@interface WXHAllVC ()

@end

@implementation WXHAllVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupInit];
}

- (void)setupInit{
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"全部", @"特别关心", @"好友动态", @"认证空间"]];
    // 设置seg颜色
    [seg setTintColor:[UIColor grayColor]];
    // 设置字体的颜色
    NSDictionary *attribute = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    [seg setTitleTextAttributes:attribute forState:UIControlStateNormal];
    // 添加点击事件
    [seg addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    // 默认选中第一个
    [seg setSelectedSegmentIndex:0];
    
    self.navigationItem.titleView = seg;
}

- (void)valueChange:(UISegmentedControl *)seg{
    NSLog(@"%ld",seg.selectedSegmentIndex);
}

@end
