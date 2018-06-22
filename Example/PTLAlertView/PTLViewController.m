//
//  PTLViewController.m
//  PTLAlertView
//
//  Created by pengtanglong_local@163.com on 06/22/2018.
//  Copyright (c) 2018 pengtanglong_local@163.com. All rights reserved.
//

#import "PTLViewController.h"
#import "PTLAlertView.h"

@interface PTLViewController ()

@end

@implementation PTLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


/// 二个按钮
- (IBAction)show2:(id)sender {
    
    PTLAlertView *alertView = [[PTLAlertView alloc]initWithTitle:@"我是标题" message:@"你好你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈吗哈哈" cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView setSelctBtnBlock:^(NSInteger index, NSString * _Nullable btnCurrentTitle) {
        NSLog(@"hha- %zd ---- %@", index, btnCurrentTitle);
    }];
    
    alertView.cancelBtnTextColor = [UIColor redColor];
    [alertView show];
    
}


/// 一个按钮
- (IBAction)show1:(id)sender {
    PTLAlertView *alertView = [[PTLAlertView alloc]initWithTitle:@"我是标题" message:@"你好你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈吗哈哈" cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    
    [alertView setSelctBtnBlock:^(NSInteger index, NSString * _Nullable btnCurrentTitle) {
        NSLog(@"hha- %zd ---- %@", index, btnCurrentTitle);
    }];
    
    alertView.cancelBtnTextColor = [UIColor redColor];
    [alertView show];
}


/// 三个按钮
- (IBAction)showAlert:(id)sender {
    
    PTLAlertView *alertView = [[PTLAlertView alloc]initWithTitle:@"我是标题" message:@"你好你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈吗哈哈你好你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈你好吗哈哈吗哈哈" cancelButtonTitle:@"取消" otherButtonTitles:@"确定",@"等一会", nil];
    
    [alertView setSelctBtnBlock:^(NSInteger index, NSString * _Nullable btnCurrentTitle) {
        NSLog(@"hha- %zd ---- %@", index, btnCurrentTitle);
    }];
    
    //    alertView.titleBackgroundColor = [UIColor redColor];
    //    alertView.titleTextColor = [UIColor greenColor];
    //    alertView.titleTextFont = [UIFont systemFontOfSize:20];
    //    alertView.messageTextColor = [UIColor redColor];
    //    alertView.messageTextFont = [UIFont systemFontOfSize:15];
    alertView.cancelBtnTextColor = [UIColor redColor];
    //    alertView.cancelBtnTextFont = [UIFont systemFontOfSize:20];
    //    alertView.otherBtnTextColor = [UIColor yellowColor];
    //    alertView.otherBtnTextFont = [UIFont systemFontOfSize:20];
//    [[PTLAlertView sharedInstance] show];
    [alertView show];
}

@end
