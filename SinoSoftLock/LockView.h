//
//  LockView.h
//  SinoSoftLock
//
//  Created by sinosoft on 16/8/1.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LockView;

@protocol LockViewDelegate <NSObject>
@optional
- (void)LockView:(LockView *)LockView didFinishedWithPath:(NSString *) path;

@end

@interface LockView : UIView
@property (nonatomic, weak) id<LockViewDelegate> delegate;
// 是否缓存密码
+(BOOL)havePwd;

@end
