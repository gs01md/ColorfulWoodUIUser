//
//  CWUUForgetPasswordViewController.m
//  TestUI
//
//  Created by 大新 on 2017/3/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUForgetPasswordViewController.h"
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import "CWUUCodeViewController.h"
#import <ColorfulWoodAlert.h>
#import <ColorfulWoodTools/ColorfulWoodTools.h>
#import "CWUUForgetCodeViewController.h"
#import <JKCategories/JKCategories.h>
#import <BmobSDK/Bmob.h>

@interface CWUUForgetPasswordViewController ()<
CWUUCodeViewControllerDelegate
>

@property (nonatomic, strong) CWUUForgetCodeViewController * m_forgetWithCode;

@end



@implementation CWUUForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    [self.view addSubview:self.m_view];
    
}

#pragma mark - 属性
-(ColorfulWoodUIForget*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = 160;
        
        _m_view = [[ColorfulWoodUIForget alloc] initWithFrame:rect];
        _m_view.m_imgPwd.image = [UIImage imageNamed:@"loginPwd"];
        _m_view.m_imgPwdConfig.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm setTitle:@"下一步" forState:UIControlStateNormal];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onNext) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _m_view;
}

-(CWUUForgetCodeViewController*)m_forgetWithCode{
    
    if (!_m_forgetWithCode) {
        
        _m_forgetWithCode = [CWUUForgetCodeViewController new];
        _m_forgetWithCode.delegate = self;
        _m_forgetWithCode.m_pwd = [self.m_view.m_fieldPwd.text jk_trimmingWhitespace];
        _m_forgetWithCode.m_phone = [BmobUser currentUser].mobilePhoneNumber;
        
    }
    
    return _m_forgetWithCode;
}


#pragma mark - 事件
-(BOOL) onNext{
    
    if (![NSString checkForPasswordWithShortest:6 longest:18 password:_m_view.m_fieldPwd.text]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"密码需要6~18位" afterDelay:2];
        
        return NO;
    }
    
    if (![NSString checkForPasswordWithShortest:6 longest:18 password:_m_view.m_fieldPwdConfig.text]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"确认密码需要6~18位" afterDelay:2];
        
        return NO;
    }
    
    if (![_m_view.m_fieldPwd.text isEqualToString:_m_view.m_fieldPwdConfig.text]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"两次密码不一致" afterDelay:2];
        
        return NO;
    }
    
    [self.navigationController pushViewController:self.m_forgetWithCode animated:YES];
    
    return YES;
}


- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -  修改完后的代理
/**
 * 修改成功，需要自动返回
 */
- (void)CWUUCodeViewControllerDelegate_success{
    
    if ([self.delegate respondsToSelector:@selector(CWUUForgetPasswordViewControllerDelegate_success)]) {
        
        [self.delegate CWUUForgetPasswordViewControllerDelegate_success];
    }
}

@end

