//
//  ColorfulWoodUISMS.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/15.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWUBLeftImageFollowField.h"

@interface ColorfulWoodUISMS : UIView

/**
 * 验证码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_viewCode;

/**
 * 倒计时按钮
 */
@property(nonatomic, strong)UIButton* m_btnCode;

/**
 * 确认按钮
 */
@property(nonatomic, strong)UIButton* m_btnConfirm;

@end
