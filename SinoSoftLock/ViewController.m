//
//  ViewController.m
//  SinoSoftLock
//
//  Created by sinosoft on 16/8/1.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ViewController.h"
#import "SetViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)set:(id)sender {
    
    SetViewController *setVC = [[SetViewController alloc] init];
    setVC.settedPwd = NO;
    setVC.isFirst = YES;
    [self presentViewController:setVC animated:YES completion:nil];
    
    
    //[bgView removeFromSuperview];
}

- (IBAction)test:(id)sender {
    
    SetViewController *setVC = [[SetViewController alloc] init];
    //setVC.settedPwd = YES;

    //setVC.isFirst = NO;
    [self presentViewController:setVC animated:YES completion:nil];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [user valueForKey:@"second"];
    NSLog(@"--------%@", pwd);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
