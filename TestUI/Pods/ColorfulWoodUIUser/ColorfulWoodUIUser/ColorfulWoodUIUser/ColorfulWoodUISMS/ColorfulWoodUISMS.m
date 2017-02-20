//
//  ColorfulWoodUISMS.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/15.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodUISMS.h"
#import "CWUBDefine.h"
#import "Masonry.h"
#import "CWUBLeftImageFollowField.h"

@interface ColorfulWoodUISMS ()

/**
 * 按钮倒计时
 */
@property int m_iNum;
@property (nonatomic, strong) NSTimer * m_timer;

/**
 * 验证码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewCode;

@end

@implementation ColorfulWoodUISMS

- (instancetype) init{
    
    if (self = [super init]) {
        
        [self initWidgets];
    }
    
    return self;
}

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
    
    [self addSubview:self.m_viewCode];
    [_m_viewCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.top.equalTo(self).offset(CWUBDefineMargin);
        make.height.equalTo(self).multipliedBy(1./2.5);
        
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
        
        make.height.equalTo(self).multipliedBy(1./2.5);
        make.left.equalTo(self).offset(CWUBDefineMargin);
        make.right.equalTo(self).offset(-CWUBDefineMargin);
        make.bottom.equalTo(self);
    }];
    
    
    
}

#pragma mark - 属性
- (CWUBLeftImageFollowField*)m_viewCode{
    
    if (!_m_viewCode) {
        
        _m_viewCode = [CWUBLeftImageFollowField new];
        _m_viewCode.layer.cornerRadius = 5.;
        _m_viewCode.layer.borderWidth = 0.5;
        _m_viewCode.layer.borderColor = CWUBDefineColorLine.CGColor;
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
        _m_btnCode.enabled = NO;
        _m_btnCode.layer.masksToBounds = YES;
        _m_btnCode.layer.cornerRadius = 4;
        _m_btnCode.layer.borderWidth = 0;
        [_m_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_m_btnCode setBackgroundImage:[self imageWithColor:CWUBDefineCreate_Color(10, 18, 50, 1) ] forState:UIControlStateNormal];
        [_m_btnCode setBackgroundImage:[self imageWithColor:[UIColor whiteColor] ] forState:UIControlStateHighlighted];
        
        _m_btnCode.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
        [_m_btnCode addTarget:self action:@selector(onGetCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _m_btnCode;
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
    
    self.m_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(resetTimer) userInfo:nil repeats:YES];
    [self.m_timer fire];
    
    
}

#pragma mark - 设置倒计时时间

- (void)resetTimer{
    
    if (_m_iNum <= 0) {
        
        [_m_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_m_btnCode setEnabled:YES];
        _m_btnCode.layer.borderWidth = 1;
        [_m_timer invalidate];
        
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
@end
