//
//  ColorfulWoodUISMS.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/15.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColorfulWoodUISMS : UIView

/**
 * code文本框
 */
@property(nonatomic, strong)UITextField* m_fieldCode;


/**
 * code图片
 */
@property(nonatomic, strong)UIImageView* m_imgCode;

/**
 * 倒计时按钮
 */
@property(nonatomic, strong)UIButton* m_btnCode;

/**
 * 确认按钮
 */
@property(nonatomic, strong)UIButton* m_btnConfirm;

@end
