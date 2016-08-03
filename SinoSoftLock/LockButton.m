//
//  LockButton.m
//  SinoSoftLock
//
//  Created by sinosoft on 16/8/1.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "LockButton.h"

@implementation LockButton
/** 使用代码创建会调用 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initLockButton];
    }
    return self;
}

/** 初始化 */
- (void) initLockButton {
    // 取消交互事件（点击）
    self.userInteractionEnabled = NO;
    
    // 设置普通状态图片
    [self setBackgroundImage:[UIImage imageNamed:@"dot_off"] forState:UIControlStateNormal];
    
    // 设置选中状态图片
    [self setBackgroundImage:[UIImage imageNamed:@"dot_on"] forState:UIControlStateSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 可触碰范围
    CGFloat touchWidth = 24;
    CGFloat touchHeight = 24;
    CGFloat touchX = self.center.x - touchWidth/2;
    CGFloat touchY = self.center.y - touchHeight/2;
    self.touchFrame = CGRectMake(touchX, touchY, 24, 24);
}


@end
