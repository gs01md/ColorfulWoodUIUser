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
#import "ColorfulWoodUIPhonePwd.h"

#define heightRateLogin 4.5

@interface ColorfulWoodUILogin()

/**
 * 包裹手机号码和密码
 */
@property(nonatomic, strong)ColorfulWoodUIPhonePwd* m_viewPhonePwd;



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
        
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(3.5/heightRateLogin);
    }];

    
    
    [self addSubview:self.m_btnForgetPwd];
    [_m_btnForgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(CWUBDefineMargin*2);
        make.top.equalTo(_m_btnlogin.mas_bottom).offset(10);
        make.bottom.equalTo(self);
    }];
    
    [self addSubview:self.m_btnRegister];
    [_m_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-CWUBDefineMargin*2);
        make.top.equalTo(_m_btnlogin.mas_bottom).offset(10);
        make.bottom.equalTo(self);
    }];
    
}

#pragma mark - 属性
- (ColorfulWoodUIPhonePwd*)m_viewPhonePwd{
    
    if (!_m_viewPhonePwd) {
        
        _m_viewPhonePwd = [ColorfulWoodUIPhonePwd new];
        
        _m_fieldPhone = _m_viewPhonePwd.m_fieldPhone;
        _m_fieldPwd = _m_viewPhonePwd.m_fieldPwd;
        _m_imgPhone = _m_viewPhonePwd.m_imgPhone;
        _m_imgPwd = _m_viewPhonePwd.m_imgPwd;
        _m_btnlogin = _m_viewPhonePwd.m_btnConfirm;
        _m_imgPhone = _m_viewPhonePwd.m_imgPhone;
        [_m_btnlogin setTitle:@"登录" forState:UIControlStateNormal];
    }
    
    return _m_viewPhonePwd;
}

- (UIButton*)m_btnForgetPwd{
    
    if (!_m_btnForgetPwd) {
        
        _m_btnForgetPwd = [UIButton new];
        [_m_btnForgetPwd setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_m_btnForgetPwd.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_m_btnForgetPwd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_m_btnForgetPwd setTitleColor:CWUBDefineCreate_Color(233, 71, 9, 1) forState:UIControlStateHighlighted];

    }
    
    return _m_btnForgetPwd;
}

- (UIButton*)m_btnRegister{
    
    if (!_m_btnRegister) {
        
        _m_btnRegister = [UIButton new];
        [_m_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
        [_m_btnRegister.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_m_btnRegister setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_m_btnRegister setTitleColor:CWUBDefineCreate_Color(233, 71, 9, 1) forState:UIControlStateHighlighted];
        
    }
    
    return _m_btnRegister;
}

#pragma mark - 功能
//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
