//
//  CWUUSignUpCodeViewController.m
//  TestUI
//
//  Created by 大新 on 2017/2/22.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUSignUpCodeViewController.h"
#import <BmobSDK/Bmob.h>
#import <ColorfulWoodTools.h>
#import <JKCategories.h>

@interface CWUUSignUpCodeViewController ()

@end

@implementation CWUUSignUpCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.m_view.m_btnConfirm setTitle:@"注册" forState:UIControlStateNormal];
}

- (void)onSignUp{
    
    [self networkSignUp];
}



/**
 * 注册
 */
- (void) networkSignUp{
    
    if (![self checkInputCode]) {
        
        return;
    }
    
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.m_phone];
    [bUser setMobilePhoneNumber:self.m_phone];
    [bUser setPassword:self.m_pwd];
    
    NSString * strCode = [self.m_view.m_fieldCode.text jk_trimmingWhitespace];

    [bUser signUpOrLoginInbackgroundWithSMSCode:strCode block:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"注册成功" afterDelay:2.];
            
            if ([self.delegate respondsToSelector:@selector(CWUUCodeViewControllerDelegate_success)]) {
                
                [self.delegate CWUUCodeViewControllerDelegate_success];
            }
            
        } else {
            
            NSString * str = [NSString stringWithFormat:@"%@",error];
            [ColorfulWoodAlert showAlertAutoHideWithTitle:str afterDelay:2.];
        }
    }];
    
}

#pragma mark - 弃用
/**
 * 启用；因为用户模块有专门的封装
 */
- (void) signUpOld {
    
    NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:self.m_phone,@"phone", self.m_pwd,@"password",nil];
    
    [BmobCloud callFunctionInBackground:@"SignUp" withParameters:dic block:^(id object, NSError *error) {
        
        BmobError * bmobError = [NSDictionary checkWithBmobDic:object];
        
        if (bmobError.m_code == BmobErrorType_Success) {
            
            //执行成功时调用
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"注册成功" afterDelay:2.];
            
            if ([self.delegate respondsToSelector:@selector(CWUUCodeViewControllerDelegate_success)]) {
                
                [self.delegate CWUUCodeViewControllerDelegate_success];
            }
            
        }else{
            
            switch (bmobError.m_code) {
                case 202:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:@"该手机已注册" afterDelay:2.];
                    break;
                    
                case 209:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:@"该手机已注册" afterDelay:2.];
                    break;
                    
                default:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:bmobError.m_strError afterDelay:2.];
                    break;
            }
            
        }
        
    }] ;

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
            
            [self networkSignUp];
            
        } else {
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:error.localizedDescription afterDelay:2.];
        }
    }];
    
}

@end
