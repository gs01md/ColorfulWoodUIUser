//
//  ColorfulWoodUILogin.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/13.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulWoodUILogin : UIView

/**
 * 输入手机号码
 */
@property(nonatomic, strong)UITextField* m_fieldPhone;

/**
 * 输入密码
 */
@property(nonatomic, strong)UITextField* m_fieldPwd;


/**
 * 手机图片
 */
@property(nonatomic, strong)UIImageView* m_imgPhone;

/**
 * 密码图片
 */
@property(nonatomic, strong)UIImageView* m_imgPwd;

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
