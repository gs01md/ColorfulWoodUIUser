//
//  CWUUSignUpPhonePwdViewController.m
//  TestUI
//
//  Created by 大新 on 2017/2/22.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUSignUpPhonePwdViewController.h"
#import "CWUUSignUpCodeViewController.h"
#import <JKCategories.h>

@interface CWUUSignUpPhonePwdViewController ()<
CWUUCodeViewControllerDelegate
>
@property (nonatomic, strong) CWUUSignUpCodeViewController * m_signUpWithCode;
@end

@implementation CWUUSignUpPhonePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self.m_view.m_btnConfirm setTitle:@"下一步" forState:UIControlStateNormal];
}

#pragma mark - 事件
-(BOOL) onNext{
    
    if ([super onNext]) {
        
        [self.navigationController pushViewController:self.m_signUpWithCode animated:YES];
    }
    
    return YES;
    
}

#pragma mark - 属性
-(CWUUSignUpCodeViewController*)m_signUpWithCode{
    
    if (!_m_signUpWithCode) {
        
        _m_signUpWithCode = [CWUUSignUpCodeViewController new];
        _m_signUpWithCode.delegate = self;
        _m_signUpWithCode.m_phone = [self.m_view.m_fieldPhone.text jk_trimmingWhitespace];
        _m_signUpWithCode.m_pwd = [self.m_view.m_fieldPwd.text jk_trimmingWhitespace];
        
    }
    
    return _m_signUpWithCode;
}

#pragma mark - CWUUSignUpCodeViewController 的代理
/**
 * 注册成功，需要自动返回
 */
- (void)CWUUCodeViewControllerDelegate_success{
    
    if ([self.delegate respondsToSelector:@selector(CWUUPhonePwdViewControllerDelegate_success)]) {
        
        [self.delegate CWUUPhonePwdViewControllerDelegate_success];
    }
}

@end
