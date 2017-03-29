//
//  CWUUPhoneCodeViewController.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/24.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUPhoneCodeViewController.h"
#import <ColorfulWoodTools/ColorfulWoodTools.h>
#import <JKCategories/JKCategories.h>
#import <BmobSDK/Bmob.h>

@interface CWUUPhoneCodeViewController ()

@end

@implementation CWUUPhoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证码登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    [self.m_view.m_btnCode addTarget:self action:@selector(onCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_view];
}

- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 属性
-(ColorfulWoodUIPhoneSMS*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = 160;
        
        _m_view = [[ColorfulWoodUIPhoneSMS alloc] initWithFrame:rect];
        _m_view.m_imgPhone.image = [UIImage imageNamed:@"loginPhone"];
        _m_view.m_imgCode.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm setTitle:@"登录" forState:UIControlStateNormal];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onSignUp) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _m_view;
}

#pragma mark - 事件

- (void) onCodeRequest {
    
    if (![self checkInputPhone]) {
        
        [self.m_view resetCodeBtn];
        return;
    }
    
    NSString * strPhone = [self.m_view.m_fieldPhone.text jk_trimmingWhitespace];
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:strPhone andTemplate:nil resultBlock:^(int number, NSError *error) {
        
        if (!error) {
            
            
        }
    }];
}

- (void)onSignUp{
    
    if (![self checkInput]) {
        
        return;
    }
    
    NSString * strPhone = [self.m_view.m_fieldPhone.text jk_trimmingWhitespace];
    NSString * strCode = [self.m_view.m_fieldCode.text jk_trimmingWhitespace];
    [BmobUser loginInbackgroundWithMobilePhoneNumber:strPhone andSMSCode:strCode block:^(BmobUser *user, NSError *error) {
        
        if (user){
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"登录成功" afterDelay:2.];
            if ([self.delegate respondsToSelector:@selector(CWUUPhoneCodeViewControllerDelegate_success)]) {
                
                [self.delegate CWUUPhoneCodeViewControllerDelegate_success];
            }
            
        } else {
            
            switch (error.code ) {
                case 101:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:@"手机号或验证码错误" afterDelay:2.];
                    break;
                    
                default:{
                    
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:error.userInfo[@"NSLocalizedDescription"] afterDelay:2.];
                }
                    
                    break;
            }
            
        }

    }];
    
}

#pragma mark - 功能

- (BOOL)checkInput {
    
    BOOL bCheck = YES;
    
    NSString * strPhone = [self.m_view.m_fieldPhone.text jk_trimmingWhitespace];
    NSString * strCode = [self.m_view.m_fieldCode.text jk_trimmingWhitespace];
    
    if (![NSString checkForMobilePhoneNo:strPhone] ) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"请输入正确的手机号" afterDelay:2];
        
        return NO;
    }
    
    if (strCode.length != 6 ||
        [strCode intValue] <  1 ||
        [strCode intValue] >= 1000000) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"验证码是6位数字" afterDelay:1.];
        
        bCheck = NO;
        
    }
    
    return bCheck;
    
}

- (BOOL)checkInputPhone {
    
    BOOL bCheck = YES;
    
    NSString * strPhone = [self.m_view.m_fieldPhone.text jk_trimmingWhitespace];
    
    if (![NSString checkForMobilePhoneNo:strPhone] ) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"请输入正确的手机号" afterDelay:2];
        
        return NO;
    }
    
    return bCheck;
    
}


@end
