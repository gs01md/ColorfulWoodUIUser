//
//  CWUUPhonePwdViewController.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/16.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUPhonePwdViewController.h"
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import "CWUUCodeViewController.h"
#import <ColorfulWoodAlert.h>
#import <ColorfulWoodTools.h>

@interface CWUUPhonePwdViewController ()<
CWUUCodeViewControllerDelegate
>


@end



@implementation CWUUPhonePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    [self.view addSubview:self.m_view];
    
}

#pragma mark - 属性
-(ColorfulWoodUIPhonePwd*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = 160;
        
        _m_view = [[ColorfulWoodUIPhonePwd alloc] initWithFrame:rect];
        _m_view.m_imgPhone.image = [UIImage imageNamed:@"loginPhone"];
        _m_view.m_imgPwd.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm setTitle:@"下一步" forState:UIControlStateNormal];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onNext) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _m_view;
}


#pragma mark - 事件
-(BOOL) onNext{
    
    if (![NSString checkForMobilePhoneNo:_m_view.m_fieldPhone.text] ) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"请输入正确的手机号" afterDelay:2];
        
        return NO;
    }
    
    if (![NSString checkForPasswordWithShortest:6 longest:18 password:_m_view.m_fieldPwd.text]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"密码需要6~18位" afterDelay:2];
        
        return NO;
    }

    return YES;
        
    

}


- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - CWUUSignUpWithCodeViewController 代理
/**
 * 注册成功，需要自动返回
 */
- (void)CWUUCodeViewControllerDelegate_success{
    
    if ([self.delegate respondsToSelector:@selector(CWUUPhonePwdViewControllerDelegate_success)]) {
        
        [self.delegate CWUUPhonePwdViewControllerDelegate_success];
    }
}

@end
