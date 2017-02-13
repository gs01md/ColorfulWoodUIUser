//
//  ColorfulWoodUILogin.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/13.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodUILogin.h"
#import "ColorfulWoodUIBase.h"
#import "Masonry.h"

#define height_textField 40.
#define color_line [UIColor grayColor]

@interface ColorfulWoodUILogin()

/**
 * 包裹手机号码和密码
 */
@property(nonatomic, strong)UIView* m_viewPhonePwd;

/**
 * 登陆按钮
 */
@property(nonatomic, strong)UIButton* m_btnlogin;

/**
 * 忘记密码
 */
@property(nonatomic, strong)UIButton* m_btnForgetPwd;

/**
 * 注册
 */
@property(nonatomic, strong)UIButton* m_btnRegister;


@end

@implementation ColorfulWoodUILogin

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initWidgets];
    }
    
    return self;
}

/**
 * 布局
 */
- (void)initWidgets{
    
    [self addSubview:self.m_viewPhonePwd];
    [_m_viewPhonePwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(@(CWUBDefineScaleFrom_iPhone6s_Desgin(height_textField*2)));
    }];
    
    [self addSubview:self.m_fieldPhone];
    [_m_fieldPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_viewPhonePwd);
        make.right.equalTo(_m_viewPhonePwd);
        make.top.equalTo(_m_viewPhonePwd);
        make.height.equalTo(@(CWUBDefineScaleFrom_iPhone6s_Desgin(height_textField)));
    }];
    
    [self addSubview:self.m_fieldPwd];
    [_m_fieldPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_viewPhonePwd);
        make.right.equalTo(_m_viewPhonePwd);
        make.top.equalTo(_m_fieldPhone.mas_bottom);
        make.height.equalTo(@(CWUBDefineScaleFrom_iPhone6s_Desgin(height_textField)));
    }];
}

#pragma mark - 属性
- (UIView*)m_viewPhonePwd{
    
    if (!_m_viewPhonePwd) {
        
        _m_viewPhonePwd = [UIView new];
        _m_viewPhonePwd.layer.cornerRadius = 5.;
        _m_viewPhonePwd.layer.borderWidth = 1.;
        _m_viewPhonePwd.layer.borderColor = color_line.CGColor;
    }
    
    return _m_viewPhonePwd;
}

- (CWUBLeftImageFollowField*)m_fieldPhone{
    
    if (!_m_fieldPhone) {
        
        _m_fieldPhone = [CWUBLeftImageFollowField new];
        _m_fieldPhone.m_imgBottom.backgroundColor = color_line;
        _m_fieldPhone.m_txtFieldContent.placeholder = @"手机号";
        _m_fieldPhone.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_fieldPhone.m_imgLeft.layer.borderWidth = 0.;
    }
    
    return _m_fieldPhone;
}

- (CWUBLeftImageFollowField*)m_fieldPwd{
    
    if (!_m_fieldPwd) {
        
        _m_fieldPwd = [CWUBLeftImageFollowField new];
        _m_fieldPwd.m_txtFieldContent.placeholder = @"密码";
        _m_fieldPwd.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_fieldPwd.m_imgLeft.layer.borderWidth = 0.;
    }
    
    return _m_fieldPwd;
}

@end
