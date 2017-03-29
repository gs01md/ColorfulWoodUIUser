//
//  ColorfulWoodUIForget.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/15.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodUIForget.h"
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <Masonry/Masonry.h>

#define heightRate_changPwd 3.7

@interface ColorfulWoodUIForget()

/**
 * 包裹手机号码和密码
 */
@property(nonatomic, strong)UIView* m_view;

/**
 * 输入密码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewPwd;

/**
 * 确认
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewPwdConfig;




/**
 * 分割线
 */
@property(nonatomic, strong)UILabel* m_line;


@end

@implementation ColorfulWoodUIForget

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
    
    [self addSubview:self.m_view];
    [_m_view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.top.equalTo(self).offset(CWUBDefineMargin);
        make.height.equalTo(self).multipliedBy(2./heightRate_changPwd);
    }];
    
    [_m_view addSubview:self.m_viewPwd];
    [_m_viewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_view);
        make.right.equalTo(_m_view);
        make.centerY.equalTo(_m_view).multipliedBy(1./2.);
        make.height.equalTo(self).multipliedBy(1./heightRate_changPwd);
    }];
    
    [_m_view addSubview:self.m_line];
    [_m_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(0.5));
        make.left.equalTo(_m_view).offset(CWUBDefineMargin);
        make.right.equalTo(_m_view).offset(-CWUBDefineMargin);
        make.centerY.equalTo(_m_view);
    }];
    
    [_m_view addSubview:self.m_viewPwdConfig];
    [_m_viewPwdConfig mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_view);
        make.right.equalTo(_m_view);
        make.centerY.equalTo(_m_view).multipliedBy(6./4.);
        make.height.equalTo(self).multipliedBy(1./heightRate_changPwd);
    }];
    
    [self addSubview:self.m_btnConfirm];
    [_m_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self).multipliedBy(1./heightRate_changPwd);
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.bottom.equalTo(self);
    }];
    
    
    
}

#pragma mark - 属性
- (UIView*)m_view{
    
    if (!_m_view) {
        
        _m_view = [UIView new];
        _m_view.layer.cornerRadius = 5.;
        _m_view.layer.borderWidth = 0.5;
        _m_view.layer.borderColor = CWUBDefineColorLine.CGColor;
        
    }
    
    return _m_view;
}

- (CWUBLeftImageFollowField*)m_viewPwd{
    
    if (!_m_viewPwd) {
        
        _m_viewPwd = [CWUBLeftImageFollowField new];
        _m_viewPwd.m_txtFieldContent.placeholder = @"密码";
        _m_viewPwd.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_viewPwd.m_imgLeft.layer.borderWidth = 0.;
        [_m_viewPwd.m_txtFieldContent setSecureTextEntry:YES];
        _m_fieldPwd = _m_viewPwd.m_txtFieldContent;
        _m_imgPwd = _m_viewPwd.m_imgLeft;
    }
    
    return _m_viewPwd;
}

- (CWUBLeftImageFollowField*)m_viewPwdConfig{
    
    if (!_m_viewPwdConfig) {
        
        _m_viewPwdConfig = [CWUBLeftImageFollowField new];
        _m_viewPwdConfig.m_txtFieldContent.placeholder = @"确认密码";
        _m_viewPwdConfig.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_viewPwdConfig.m_imgLeft.layer.borderWidth = 0.;
        [_m_viewPwdConfig.m_txtFieldContent setSecureTextEntry:YES];
        _m_fieldPwdConfig = _m_viewPwdConfig.m_txtFieldContent;
        _m_imgPwdConfig = _m_viewPwdConfig.m_imgLeft;
        
    }
    
    return _m_viewPwdConfig;
}

- (UILabel*)m_line{
    
    if (!_m_line) {
        
        _m_line = [UILabel new];
        _m_line.backgroundColor = CWUBDefineColorLine;
        
    }
    
    return _m_line;
}

- (UIButton*)m_btnConfirm{
    
    if (!_m_btnConfirm) {
        
        _m_btnConfirm = [UIButton new];
        [_m_btnConfirm setTitle:@"" forState:UIControlStateNormal];
        [_m_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_m_btnConfirm setTitleColor:CWUBDefineCreate_Color(233, 71, 9, 1) forState:UIControlStateHighlighted];
        [_m_btnConfirm setBackgroundImage:[self imageWithColor:CWUBDefineCreate_Color(233,71,9,1) ] forState:UIControlStateNormal];
        [_m_btnConfirm setBackgroundImage:[self imageWithColor:[UIColor grayColor] ] forState:UIControlStateHighlighted];
        _m_btnConfirm.layer.cornerRadius = 5.;
        _m_btnConfirm.layer.masksToBounds = YES;
    }
    
    return _m_btnConfirm;
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
