//
//  WXHMenu.h
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef NS_ENUM(NSInteger,MenuType) {
//    MenuTypeTalk,
//    MenuTypePhoto,
//    MenuTypeDiary
//};

@class WXHMenu;
@protocol WXHMenuDelegate <NSObject>

@optional

/**
 代理方法(点击了哪个按钮)

 @param menu 底部菜单
 @param index 索引
 */
- (void)menu:(WXHMenu *)menu didSelectIndex:(NSInteger)index;

@end

@interface WXHMenu : UIView

/** 代理*/
@property(nonatomic,weak) id<WXHMenuDelegate> delegate;
@end
