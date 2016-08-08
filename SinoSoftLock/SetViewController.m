//
//  SetViewController.m
//  SinoSoftLock
//
//  Created by sinosoft on 16/8/2.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "SetViewController.h"
#import "LockView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface SetViewController ()<LockViewDelegate>


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LockView *lockView = [[LockView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
    lockView.delegate = self;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    bgView.backgroundColor = [UIColor grayColor];
    [bgView addSubview:lockView];
    [self.view addSubview:bgView];
    
    
}
- (void)LockView:(LockView *)LockView didFinishedWithPath:(NSString *)path
{
    
        int count = 0;
        if (self.settedPwd == NO && self.isFirst == YES) {
            NSUserDefaults *first = [NSUserDefaults standardUserDefaults];
            [first setValue:path forKey:@"first"];
            count++;
            self.isFirst = NO;
            self.settedPwd = NO;
            NSLog(@"手势解锁的输入是: %@, %d", path, count);
        } else if (self.settedPwd == NO && self.isFirst == NO) {
            NSUserDefaults *second = [NSUserDefaults standardUserDefaults];
            [second setValue:path forKey:@"second"];
            NSLog(@"手势解锁的输入是: aaaaaaa%@", path);
            self.isFirst = NO;
            [self setPwdSucceed];
            self.settedPwd = YES;
        }
    if (self.settedPwd == YES && self.isFirst == YES) {
        NSUserDefaults *test = [NSUserDefaults standardUserDefaults];
        [test setValue:path forKey:@"test"];
        [self testLock];
    }
    if (self.settedPwd == YES && self.isFirst == NO) {
        NSUserDefaults *test = [NSUserDefaults standardUserDefaults];
        [test setValue:path forKey:@"test"];
        [self testLock];
    }
    
}

- (void)setPwdSucceed
{
        NSUserDefaults *first = [NSUserDefaults standardUserDefaults];
        NSString *qq = [first valueForKey:@"first"];
    
        NSUserDefaults *second = [NSUserDefaults standardUserDefaults];
        NSString *pp = [second valueForKey:@"second"];
        NSLog(@"%@, bbbbb%@", qq, pp);
    if ([qq isEqualToString:pp] == YES) {
        _pwd = pp;
        NSLog(@"密码设置成功, %@", _pwd);
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"前后输入不一致");
    }
}
- (void)testLock
{
    NSUserDefaults *test = [NSUserDefaults standardUserDefaults];
    NSString *tt = [test valueForKey:@"test"];
    NSLog(@"+++++++++++%@", tt);
    if ([tt isEqualToString:_pwd]) {
       
        NSLog(@"验证成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
         NSLog(@"验证失败");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
