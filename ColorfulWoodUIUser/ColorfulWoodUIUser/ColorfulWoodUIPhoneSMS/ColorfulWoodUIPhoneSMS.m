//
//  ColorfulWoodUIPhoneSMS.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/24.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodUIPhoneSMS.h"
#import "Masonry.h"
#import <ColorfulWoodUIBase.h>

#define heightRate_phonePwd 3.7

@interface ColorfulWoodUIPhoneSMS()

/**
 * 按钮倒计时
 */
@property int m_iNum;
@property (nonatomic, strong) NSTimer * m_timer;

/**
 * 包裹手机号码和Code
 */
@property(nonatomic, strong)UIView* m_viewPhoneCode;

/**
 * 分割线
 */
@property(nonatomic, strong)UILabel* m_line;


/**
 * 输入手机号码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewPhone;

/**
 * 输入Code
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewCode;

@end

@implementation ColorfulWoodUIPhoneSMS

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
    
    [self addSubview:self.m_viewPhoneCode];
    [_m_viewPhoneCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.top.equalTo(self).offset(CWUBDefineMargin);
        make.height.equalTo(self).multipliedBy(2./heightRate_phonePwd);
    }];
    
    [_m_viewPhoneCode addSubview:self.m_viewPhone];
    [_m_viewPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_viewPhoneCode);
        make.right.equalTo(_m_viewPhoneCode);
        make.centerY.equalTo(_m_viewPhoneCode).multipliedBy(1./2.);
        make.height.equalTo(self).multipliedBy(1./heightRate_phonePwd);
    }];
    
    [_m_viewPhoneCode addSubview:self.m_line];
    [_m_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(0.5));
        make.left.equalTo(_m_viewPhoneCode).offset(CWUBDefineMargin);
        make.right.equalTo(_m_viewPhoneCode).offset(-CWUBDefineMargin);
        make.centerY.equalTo(_m_viewPhoneCode);
    }];
    
    [_m_viewPhoneCode addSubview:self.m_viewCode];
    [_m_viewCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_viewPhoneCode);
        make.right.equalTo(_m_viewPhoneCode);
        make.centerY.equalTo(_m_viewPhoneCode).multipliedBy(6./4.);
        make.height.equalTo(self).multipliedBy(1./heightRate_phonePwd);
    }];
    
    [_m_viewCode addSubview:self.m_btnCode];
    [_m_btnCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_m_viewCode.mas_right);
        make.top.equalTo(_m_viewCode).offset(2);
        make.bottom.equalTo(_m_viewCode).offset(-2);
        make.width.equalTo(@(CWUBDefineScaleFrom_iPhone6s_Desgin(90)));
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
- (UIView*)m_viewPhoneCode{
    
    if (!_m_viewPhoneCode) {
        
        _m_viewPhoneCode = [UIView new];
        _m_viewPhoneCode.layer.cornerRadius = 5.;
        _m_viewPhoneCode.layer.borderWidth = 0.5;
        _m_viewPhoneCode.layer.borderColor = CWUBDefineColorLine.CGColor;
        
    }
    
    return _m_viewPhoneCode;
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

- (CWUBLeftImageFollowField*)m_viewCode{
    
    if (!_m_viewCode) {
        
        _m_viewCode = [CWUBLeftImageFollowField new];
        _m_viewCode.m_txtFieldContent.placeholder = @"验证码";
        _m_viewCode.m_imgLeft.backgroundColor = [UIColor clearColor];
        _m_viewCode.m_imgLeft.layer.borderWidth = 0.;
        _m_fieldCode = _m_viewCode.m_txtFieldContent;
        _m_imgCode = _m_viewCode.m_imgLeft;

    }
    
    return _m_viewCode;
}

- (UIButton*)m_btnCode{
    
    if (!_m_btnCode) {
        
        _m_btnCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _m_btnCode.enabled = YES;
        _m_btnCode.layer.masksToBounds = YES;
        _m_btnCode.layer.cornerRadius = 4;
        _m_btnCode.layer.borderWidth = 1;
        [_m_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_m_btnCode setBackgroundImage:[self imageWithColor:CWUBDefineCreate_Color(10, 18, 50, 1) ] forState:UIControlStateNormal];
        [_m_btnCode setBackgroundImage:[self imageWithColor:[UIColor whiteColor] ] forState:UIControlStateHighlighted];
        
        _m_btnCode.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
        [_m_btnCode addTarget:self action:@selector(onGetCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _m_btnCode;
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



#pragma mark - 按钮事件

- (void)onGetCodeBtn{
    
    [_m_btnCode setEnabled:NO];
    _m_btnCode.layer.borderWidth = 0;
    
    self.m_iNum = 60;
    
    if (self.m_timer) {
        
        [self resetCodeBtn];
    }
    
    self.m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(resetTimer) userInfo:nil repeats:YES];
    [self.m_timer fire];
    
    
}


#pragma mark - 设置倒计时时间

- (void)resetTimer{
    
    if (_m_iNum <= 0) {
        
        [self resetCodeBtn];
        
        return;
    }
    
    NSString * str = [NSString stringWithFormat:@"%d S",_m_iNum--];
    [_m_btnCode setTitle:str forState:UIControlStateNormal];
    
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

/**
 * 初始化按钮状态
 */
- (void)resetCodeBtn {
    
    [_m_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_m_btnCode setEnabled:YES];
    _m_btnCode.layer.borderWidth = 1;
    [_m_timer invalidate];
}
@end

