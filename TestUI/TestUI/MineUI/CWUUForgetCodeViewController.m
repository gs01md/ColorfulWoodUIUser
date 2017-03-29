//
//  CWUUForgetCodeViewController.m
//  TestUI
//
//  Created by 大新 on 2017/3/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUForgetCodeViewController.h"
#import <BmobSDK/Bmob.h>
#import <ColorfulWoodTools.h>
#import <JKCategories.h>

@interface CWUUForgetCodeViewController ()

@end

@implementation CWUUForgetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.m_view.m_btnConfirm setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.m_view.m_btnConfirm addTarget:self action:@selector(onChangePassword) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onChangePassword{
    
    [self networkChangePassword];
}



/**
 * 修改密码
 */
- (void) networkChangePassword{
    
    if (![self checkInputCode]) {
        
        return;
    }
    
    NSString * strCode = [self.m_view.m_fieldCode.text jk_trimmingWhitespace];
    
    [BmobUser resetPasswordInbackgroundWithSMSCode:strCode andNewPassword:self.m_pwd block:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"修改密码成功" afterDelay:2.];
            
            if ([self.delegate respondsToSelector:@selector(CWUUCodeViewControllerDelegate_success)]) {
                
                [self.delegate CWUUCodeViewControllerDelegate_success];
            }
            
        } else {
            
            NSString * str = [NSString stringWithFormat:@"%@",error];
            [ColorfulWoodAlert showAlertAutoHideWithTitle:str afterDelay:2.];
        }
        
    }];
 
    
}

/**
 * 检查验证码
 */
- (void) networtCode{
    
    if (![self checkInputCode]) {
        
        return;
    }
    
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:self.m_phone andSMSCode:self.m_view.m_fieldCode.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            
            [self networkChangePassword];
            
        } else {
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:error.localizedDescription afterDelay:2.];
        }
    }];
    
}

@end
