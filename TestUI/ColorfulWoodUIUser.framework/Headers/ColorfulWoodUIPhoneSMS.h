//
//  ColorfulWoodUIPhoneSMS.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/24.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColorfulWoodUIPhoneSMS : UIView

/**
 * 输入手机号码
 */
@property(nonatomic, strong)UITextField* m_fieldPhone;

/**
 * 输入Code
 */
@property(nonatomic, strong)UITextField* m_fieldCode;


/**
 * 手机图片
 */
@property(nonatomic, strong)UIImageView* m_imgPhone;

/**
 * Code图片
 */
@property(nonatomic, strong)UIImageView* m_imgCode;

/**
 * 倒计时按钮
 */
@property(nonatomic, strong)UIButton* m_btnCode;

/**
 * 按钮
 */
@property(nonatomic, strong)UIButton* m_btnConfirm;

/**
 * 初始化按钮状态
 */
- (void)resetCodeBtn;
@end
