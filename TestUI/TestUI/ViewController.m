//
//  ViewController.m
//  TestUI
//
//  Created by 大新 on 2017/1/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "ViewController.h"
#import <ColorfulWoodUIBase.h>
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <BmobSDK/Bmob.h>

@interface ViewController (){
    
    ColorfulWoodUILogin * user;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = self.view.frame;
    rect.origin.y = 64.;
    rect.size.height = CWUBDefineDeviceHeight - 64;
    
    user = [[ColorfulWoodUILogin alloc] initWithFrame:rect];

    [self.view addSubview:user];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    user.m_imgPhone.image = [UIImage imageNamed:@"loginPhone"];
    user.m_imgPwd.image = [UIImage imageNamed:@"loginPwd"];
    
    [user.m_btnlogin addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
    
}


/**
 * 视图点击事件
 */
- (void)CWUBViewBaseDelegate_viewClick{
    
    NSLog(@"CWUBViewBaseDelegate_viewClick");
}


#pragma mark - 事件
- (void)onLogin{
    
    NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:@"15910667631",@"phone", @"123456",@"password",nil];

    [BmobCloud callFunctionInBackground:@"registerRongCloudForChaoticEnglish" withParameters:dic block:^(id object, NSError *error) {
        
        if (!error) {
            //执行成功时调用
            NSLog(@"error %@",[object description]);
        }else{
            //执行失败时调用
            NSLog(@"error %@",[error description]);
        }
        
    }] ;
}

@end
