//
//  ViewController.m
//  TestUI
//
//  Created by 大新 on 2017/2/22.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "ViewController.h"

#import "CWUULoginViewController.h"


@interface ViewController ()<
CWUULoginViewControllerDelegate
>{
    
    CWUULoginViewController * _rootViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float fLeft   = 100;
    float fTop    = 100;
    float fWidth  = 100;
    float fHeight = 50;
    CGRect rect = CGRectMake(fLeft, fTop, fWidth, fHeight);
    UIButton * btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    

}

- (void) onLogin{
    
    _rootViewController = [[CWUULoginViewController alloc] init];
    _rootViewController.delegate = self;
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)CWUULoginViewControllerDelegate_success{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
