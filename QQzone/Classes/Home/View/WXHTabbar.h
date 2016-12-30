//
//  WXHTabbar.h
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WXHTabbarDelegate <NSObject>
@optional

- (void)tabbar:(id)tabbar didSelectIndex:(NSInteger)selectIndex fromIndex:(NSInteger)oldIndex;
@end

@interface WXHTabbar : UIView

/** 代理*/
@property(nonatomic,weak) id<WXHTabbarDelegate> delegate;

- (void)clearSelect;

@end
