//
//  WXHHeadIcon.m
//  QQzone
//
//  Created by 初七 on 2016/12/30.
//  Copyright © 2016年 nemo. All rights reserved.
//

#import "WXHHeadIcon.h"
#define ratio 0.8
@implementation WXHHeadIcon

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (isLanscape) {
        return CGRectMake(0, contentRect.size.height * ratio, contentRect.size.width, contentRect.size.height * (1 - ratio));
    }else{ // 竖屏返回全部0
        return CGRectZero;
    }
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (isLanscape) {
        return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * ratio);
    }else
    {
        return contentRect;
    }
}

@end
