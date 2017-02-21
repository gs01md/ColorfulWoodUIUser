//
//  RegisterCodeViewController.m
//  TestUI
//
//  Created by 大新 on 2017/2/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "RegisterCodeViewController.h"
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <ColorfulWoodCategories.h>
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <BmobSDK/Bmob.h>
#import <ColorfulWoodAlert.h>

@interface RegisterCodeViewController ()
@property (nonatomic, strong) ColorfulWoodUISMS *m_view;
@end

@implementation RegisterCodeViewController

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
        rect.size.height = 100;
        
        _m_view = [[ColorfulWoodUISMS alloc] initWithFrame:rect];
        _m_view.m_imgCode.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm setTitle:@"注册" forState:UIControlStateNormal];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onRegisterNext) forControlEvents:UIControlEventTouchUpInside];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onRegisterNext) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _m_view;
}


- (void)onBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRegisterNext{
    
    [self networtCode];
}

/**
 * 检查验证码
 */
- (void) networtCode{
    
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:_m_phone andSMSCode:_m_view.m_fieldCode.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            
            [self networtSignUp];
            
        } else {
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:error afterDelay:2.];
        }
    }];
    
}

/**
 * 注册
 */
- (void) networtSignUp{
    
    NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:_m_phone,@"phone", _m_pwd,@"password",nil];
    
    [BmobCloud callFunctionInBackground:@"registerRongCloudForChaoticEnglish" withParameters:dic block:^(id object, NSError *error) {
        
        NSDictionary * dic = object;
        NSString * strErrorCode = @"";
        int errorCode = 0;
        
        if (dic) {
            
            strErrorCode = [dic objectForKey:@"code"];
            strErrorCode = strErrorCode?strErrorCode:@"";
            errorCode = [strErrorCode intValue];
        }
        
        if (!error && errorCode==0) {
            //执行成功时调用
            NSLog(@"error %@",[object description]);
            
        }else{
            
            switch (errorCode) {
                case 209:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:@"该手机已注册" afterDelay:2.];
                    break;
                    
                default:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:strErrorCode afterDelay:2.];
                    break;
            }
            
        }
        
    }] ;
}

@end
