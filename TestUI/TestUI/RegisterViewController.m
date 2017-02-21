//
//  RegisterViewController.m
//  TestUI
//
//  Created by 大新 on 2017/2/16.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "RegisterViewController.h"
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <ColorfulWoodCategories.h>
#import "RegisterCodeViewController.h"
#import <ColorfulWoodAlert.h>

@interface RegisterViewController ()
@property (nonatomic, strong) ColorfulWoodUIPhonePwd *m_view;
@end



@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    [self.view addSubview:self.m_view];
    
}

-(ColorfulWoodUIPhonePwd*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = 160;
        
        _m_view = [[ColorfulWoodUIPhonePwd alloc] initWithFrame:rect];
        _m_view.m_imgPhone.image = [UIImage imageNamed:@"loginPhone"];
        _m_view.m_imgPwd.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm setTitle:@"下一步" forState:UIControlStateNormal];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onRegisterNext) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _m_view;
}


-(void)onRegisterNext{
    
    if (![NSString checkForMobilePhoneNo:_m_view.m_fieldPhone.text] ) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"请输入正确的手机号" afterDelay:2];
        
        return;
    }
    
    if (![NSString checkForPasswordWithShortest:6 longest:18 password:_m_view.m_fieldPwd.text]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"密码需要6~18位" afterDelay:2];
        
        return;
    }
    

        
    RegisterCodeViewController * vc = [RegisterCodeViewController new];
    vc.m_phone = _m_view.m_fieldPhone.text;
    vc.m_pwd = _m_view.m_fieldPwd.text;
        
    [self.navigationController pushViewController:vc animated:YES];


    
}


- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
