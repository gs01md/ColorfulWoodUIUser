//
//  ColorfulWoodUIForget.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/15.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulWoodUIForget : UIView

/**
 * 输入密码
 */
@property(nonatomic, strong)UITextField* m_fieldPwd;

/**
 * 确认密码
 */
@property(nonatomic, strong)UITextField* m_fieldPwdConfig;

/**
 * 密码图片
 */
@property(nonatomic, strong)UIImageView* m_imgPwd;

/**
 * 确认密码图片
 */
@property(nonatomic, strong)UIImageView* m_imgPwdConfig;

/**
 * 按钮
 */
@property(nonatomic, strong)UIButton* m_btnConfirm;


@end
