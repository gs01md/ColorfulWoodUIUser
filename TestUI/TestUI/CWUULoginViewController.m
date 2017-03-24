//
//  CWUULoginViewController.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/1/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUULoginViewController.h"
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <BmobSDK/Bmob.h>
#import "CWUUPhonePwdViewController.h"
#import <UIViewController+JKBackButtonItemTitle.h>
#import <JKCategories/NSString+JKTrims.h>
#import <ColorfulWoodTools.h>
#import "CWUUSignUpPhonePwdViewController.h"
#import "CWUUPhoneCodeViewController.h"
#import "CWUUUserDetail.h"

@interface CWUULoginViewController ()<
CWUUPhonePwdViewControllerDelegate,
CWUUPhoneCodeViewControllerDelegate
>

@property(nonatomic, strong) ColorfulWoodUILogin * m_view;

@property(nonatomic, strong) CWUUSignUpPhonePwdViewController * m_signUp;
@property(nonatomic, strong) CWUUPhoneCodeViewController * m_forget;

@end

@implementation CWUULoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    [self.view addSubview:self.m_view];
}

#pragma mark - 属性

- (ColorfulWoodUILogin*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = 195;
        
        _m_view = [[ColorfulWoodUILogin alloc] initWithFrame:rect];
        _m_view.m_imgPhone.image = [UIImage imageNamed:@"loginPhone"];
        _m_view.m_imgPwd.image = [UIImage imageNamed:@"loginPwd"];
        
        [_m_view.m_btnlogin addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
        [_m_view.m_btnRegister addTarget:self action:@selector(onSignUp) forControlEvents:UIControlEventTouchUpInside];
        [_m_view.m_btnForgetPwd addTarget:self action:@selector(onForgetPwd) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _m_view;
}

- (CWUUSignUpPhonePwdViewController*)m_signUp{
    
    if (!_m_signUp) {
        
        _m_signUp = [CWUUSignUpPhonePwdViewController new];
        _m_signUp.delegate = self;
    }
    
    return _m_signUp;
}

- (CWUUPhoneCodeViewController*)m_forget{
    
    if (!_m_forget) {
        
        _m_forget = [CWUUPhoneCodeViewController new];
        _m_forget.delegate = self;
    }
    
    return _m_forget;
}

#pragma mark - 事件

/**
 * 登录操作
 */
- (void)onLogin{
    
    if ([self checkPhoneAndPwd]) {
        
        NSString * strPhone = [_m_view.m_fieldPhone.text jk_trimmingWhitespace];
        NSString * strPwd = [_m_view.m_fieldPwd.text jk_trimmingWhitespace];
        [BmobUser loginWithUsernameInBackground:strPhone password:strPwd block:^(BmobUser *user, NSError *error) {
            
            if (user){
                
                NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:[BmobUser currentUser].objectId,@"objectId",nil];
                
                [BmobCloud callFunctionInBackground:@"UserInfo_Get" withParameters:dic block:^(id object, NSError *error) {
                    
                    BmobError * bmobError = [NSDictionary checkWithBmobDic:object];
                    
                    if (bmobError.m_code == BmobErrorType_Success) {
                        
                        CWUUUserDetailModel * info = [[CWUUUserDetailModel alloc]initWithDictionary:object[@"content"] error:nil];
                        CWUUUserDetail * detail = [CWUUUserDetail shareInstance];
                        [detail saveUserDetail:info];
                        
                        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"登录成功" afterDelay:2.];
                        
                    }else{
                        
                        switch (bmobError.m_code) {
                            case 201:
                                [ColorfulWoodAlert showAlertAutoHideWithTitle:@"数据无效" afterDelay:2.];
                                break;
                                
                            default:
                                [ColorfulWoodAlert showAlertAutoHideWithTitle:bmobError.m_strError afterDelay:2.];
                                break;
                        }
                        
                    }
                    
                }] ;

                
                
                [self CWUUPhonePwdViewControllerDelegate_success];
                
            } else {
                
                switch (error.code ) {
                    case 101:
                        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"手机号或密码错误" afterDelay:2.];
                        break;
                        
                    default:{
                        
                        [ColorfulWoodAlert showAlertAutoHideWithTitle:error.userInfo[@"NSLocalizedDescription"] afterDelay:2.];
                    }
                        
                        break;
                }
                
            }
        }];
    }
    
}

/**
 * 跳转到注册
 */
- (void)onSignUp{
    
    [self.navigationController pushViewController:self.m_signUp animated:YES];
}

/**
 * 忘记密码
 */
- (void)onForgetPwd{
    
    [self.navigationController pushViewController:self.m_forget animated:YES];
}


- (void)backBtn{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 功能

- (BOOL) checkPhoneAndPwd{
    
    NSString * strPhone = [_m_view.m_fieldPhone.text jk_trimmingWhitespace];
    NSString * strPwd = [_m_view.m_fieldPwd.text jk_trimmingWhitespace];
    
    if (![NSString checkForMobilePhoneNo:strPhone] ) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"请输入正确的手机号" afterDelay:2];
        
        return NO;
    }
    
    if (![NSString checkForPasswordWithShortest:6 longest:18 password:strPwd]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"密码需要6~18位" afterDelay:2];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - CWUULoginViewController 代理

- (void)CWUUPhonePwdViewControllerDelegate_success{
    
    if ([self.delegate respondsToSelector:@selector(CWUULoginViewControllerDelegate_success)]) {
        
        [self.delegate CWUULoginViewControllerDelegate_success];
    }
    
}

#pragma mark - CWUUPhoneCodeViewController 代理
/**
 * 成功后返回
 */
- (void)CWUUPhoneCodeViewControllerDelegate_success{
    
    if ([self.delegate respondsToSelector:@selector(CWUULoginViewControllerDelegate_success)]) {
        
        [self.delegate CWUULoginViewControllerDelegate_success];
    }
    
}
#pragma mark - 弃用

- (void) loginOld{
    
    NSString * strPhone = [_m_view.m_fieldPhone.text jk_trimmingWhitespace];
    NSString * strPwd = [_m_view.m_fieldPwd.text jk_trimmingWhitespace];
    
    NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:strPhone,@"phone", strPwd,@"password",nil];
    
    [BmobCloud callFunctionInBackground:@"Login" withParameters:dic block:^(id object, NSError *error) {
        
        BmobError * bmobError = [NSDictionary checkWithBmobDic:object];
        
        if (bmobError.m_code == BmobErrorType_Success) {
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"登录成功" afterDelay:2.];
            
            [self CWUUPhonePwdViewControllerDelegate_success];
            
        }else{
            
            switch (bmobError.m_code) {
                    
                default:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:bmobError.m_strError afterDelay:2.];
                    break;
            }
            
        }
        
        
    }] ;
}
@end
