//
//  WXHDockView.h
//  QQzone
//
//  Created by 初七 on 2016/12/29.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXHMenu.h"
#import "WXHTabbar.h"
#import "WXHHeadIcon.h"
@protocol WXHDockViewDelegate <NSObject,WXHMenuDelegate,WXHTabbarDelegate>
@optional
- (void)dockDidSlelectHeadIcon;
@end

@interface WXHDockView : UIView
/** 代理*/
@property(nonatomic,weak) id<WXHDockViewDelegate> delegate;
@end
