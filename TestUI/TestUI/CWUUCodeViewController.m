//
//  CWUUCodeViewController.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUCodeViewController.h"
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <BmobSDK/Bmob.h>
#import <ColorfulWoodTools.h>
#import <JKCategories.h>

@interface CWUUCodeViewController ()

@end

@implementation CWUUCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(onBackBtn)];
    [self.view addSubview:self.m_view];
}

- (ColorfulWoodUISMS*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = 100.;
        
        _m_view = [[ColorfulWoodUISMS alloc] initWithFrame:rect];
        _m_view.m_imgCode.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onSignUp) forControlEvents:UIControlEventTouchUpInside];
        [_m_view.m_btnCode addTarget:self action:@selector(onCodeRequest) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _m_view;
}


- (void)onBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSignUp{
    
}



- (void) onCodeRequest {
    
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:_m_phone andTemplate:nil resultBlock:^(int number, NSError *error) {
       
        if (!error) {
            
            
        }
    }];
}

#pragma mark - 功能

- (BOOL)checkInputCode {
    
    BOOL bCheck = YES;
    
    NSString * strCode = [self.m_view.m_fieldCode.text jk_trimmingWhitespace];
    
    if (strCode.length != 6 ||
        [strCode intValue] <  1 ||
        [strCode intValue] >= 1000000) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"验证码是6位数字" afterDelay:1.];
        
        bCheck = NO;
        
    }
    
    return bCheck;
    
}

@end
