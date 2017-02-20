//
//  ColorfulWoodUIPhonePwd.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/15.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodUIPhonePwd.h"
#import "ColorfulWoodUIBase.h"
#import "Masonry.h"

#define heightRate_phonePwd 3.7

@interface ColorfulWoodUIPhonePwd()

/**
 * 包裹手机号码和密码
 */
@property(nonatomic, strong)UIView* m_viewPhonePwd;

/**
 * 输入手机号码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewPhone;

/**
 * 输入密码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewPwd;


/**
 * 分割线
 */
@property(nonatomic, strong)UILabel* m_line;


@end

@implementation ColorfulWoodUIPhonePwd

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
        
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.top.equalTo(self).offset(CWUBDefineMargin);
        make.height.equalTo(self).multipliedBy(2./heightRate_phonePwd);
    }];
    
    [_m_viewPhonePwd addSubview:self.m_viewPhone];
    [_m_viewPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_viewPhonePwd);
        make.right.equalTo(_m_viewPhonePwd);
        make.centerY.equalTo(_m_viewPhonePwd).multipliedBy(1./2.);
        make.height.equalTo(self).multipliedBy(1./heightRate_phonePwd);
    }];
    
    [_m_viewPhonePwd addSubview:self.m_line];
    [_m_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(0.5));
        make.left.equalTo(_m_viewPhonePwd).offset(CWUBDefineMargin);
        make.right.equalTo(_m_viewPhonePwd).offset(-CWUBDefineMargin);
        make.centerY.equalTo(_m_viewPhonePwd);
    }];
    
    [_m_viewPhonePwd addSubview:self.m_viewPwd];
    [_m_viewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_viewPhonePwd);
        make.right.equalTo(_m_viewPhonePwd);
        make.centerY.equalTo(_m_viewPhonePwd).multipliedBy(6./4.);
        make.height.equalTo(self).multipliedBy(1./heightRate_phonePwd);
    }];
    
    [self addSubview:self.m_btnConfirm];
    [_m_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self).multipliedBy(1./heightRate_phonePwd);
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.bottom.equalTo(self);
    }];
    

    
}

#pragma mark - 属性
- (UIView*)m_viewPhonePwd{
    
    if (!_m_viewPhonePwd) {
        
        _m_viewPhonePwd = [UIView new];
        _m_viewPhonePwd.layer.cornerRadius = 5.;
        _m_viewPhonePwd.layer.borderWidth = 0.5;
        _m_viewPhonePwd.layer.borderColor = CWUBDefineColorLine.CGColor;
        
    }
    
    return _m_viewPhonePwd;
}

- (CWUBLeftImageFollowField*)m_viewPhone{
    
    if (!_m_viewPhone) {
        
        _m_viewPhone = [CWUBLeftImageFollowField new];
        _m_viewPhone.m_txtFieldContent.placeholder = @"手机号";
        _m_viewPhone.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_viewPhone.m_imgLeft.layer.borderWidth = 0.;
        _m_fieldPhone = _m_viewPhone.m_txtFieldContent;
        _m_imgPhone = _m_viewPhone.m_imgLeft;
    }
    
    return _m_viewPhone;
}

- (CWUBLeftImageFollowField*)m_viewPwd{
    
    if (!_m_viewPwd) {
        
        _m_viewPwd = [CWUBLeftImageFollowField new];
        _m_viewPwd.m_txtFieldContent.placeholder = @"密码";
        _m_viewPwd.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_viewPwd.m_imgLeft.layer.borderWidth = 0.;
        _m_fieldPwd = _m_viewPwd.m_txtFieldContent;
        _m_imgPwd = _m_viewPwd.m_imgLeft;
    }
    
    return _m_viewPwd;
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
