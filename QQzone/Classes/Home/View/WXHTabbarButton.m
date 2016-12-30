//
//  WXHTabbarButton.m
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHTabbarButton.h"

#define ratio 0.3
@implementation WXHTabbarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}
#pragma mark - 取消点击高亮状态
- (void)setHighlighted:(BOOL)highlighted{

}
#pragma mark - 改变按钮文字frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (isLanscape) { // 横屏
        return CGRectMake(contentRect.size.width * ratio, 0, contentRect.size.width * (1 - ratio), contentRect.size.height);
    }else{ // 竖屏
        return CGRectZero;
    }
}
#pragma mark - 改变按钮图片frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (isLanscape) {
        return CGRectMake(0, 0, self.width * ratio, contentRect.size.height);
    }else{
        return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
    }
}
@end
