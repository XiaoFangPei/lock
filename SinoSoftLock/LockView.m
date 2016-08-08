//
//  LockView.m
//  SinoSoftLock
//
//  Created by sinosoft on 16/8/1.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "LockView.h"
#import "LockButton.h"

@interface LockView ()
// 已经选择的按钮
@property (nonatomic, strong) NSMutableArray *selectBtns;
// 触摸的位置
@property (nonatomic, assign) CGPoint currentTouchLocation;

@end

@implementation LockView
+ (BOOL)havePwd
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *path = [user valueForKey:@"path"];
    return path != nil;
}
- (NSMutableArray *)selectBtns
{
    if (_selectBtns == nil) {
        _selectBtns = [NSMutableArray array];
    }
    return _selectBtns;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI
{
    self.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0];
    
    int button_count = 9;
    for (int i = 0; i < button_count; i++) {
        LockButton *btn = [LockButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        [self addSubview:btn];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i<self.subviews.count; i++) {
        LockButton *btn = self.subviews[i];
        CGFloat buttonWidth = 74;
        CGFloat buttonHeight = 74;
        int col = i % 3;
        int row = i / 3;
        CGFloat marginX = (self.frame.size.width - 3 * buttonWidth)/4;
        CGFloat marginY = marginX;
        CGFloat buttonX = marginX + col * (buttonWidth + marginX);
        CGFloat buttonY = marginY + row * (buttonHeight + marginY);
        btn.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        
    }
    
}
#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    // 检测哪个按钮被点中了
    for (LockButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.touchFrame, touchLocation)) {
            btn.selected = YES;
            if (![self.selectBtns containsObject:btn]) {
                //  加入到数组
                [self.selectBtns addObject:btn];
            }
        }
        // 当前触摸的位置
        self.currentTouchLocation = touchLocation;
    }
    // 重绘
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 轨迹序列
    NSMutableString *passPath = [NSMutableString string];
    for (LockButton *btn in self.selectBtns) {
        btn.selected = NO;
        // 添加到轨迹序列
        [passPath appendFormat:@"%ld", (long)btn.tag];
    }
    if ([self.delegate respondsToSelector:@selector(LockView:didFinishedWithPath:)]) {
        [self.delegate LockView:self didFinishedWithPath:passPath];
    }
    [self.selectBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.selectBtns removeAllObjects];
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark - 绘图方法
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectBtns.count; i++) {
        LockButton *btn = self.selectBtns[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    if (self.selectBtns.count) {
        [path addLineToPoint:self.currentTouchLocation];
    }
    // 设置画笔
         [[UIColor redColor] set];
         [path setLineWidth:10];
         [path setLineCapStyle:kCGLineCapRound];
         [path setLineJoinStyle:kCGLineJoinBevel];
    
         [path stroke];
}
@end
