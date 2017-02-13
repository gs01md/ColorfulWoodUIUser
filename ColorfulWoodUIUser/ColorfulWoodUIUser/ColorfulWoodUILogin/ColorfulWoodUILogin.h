//
//  ColorfulWoodUILogin.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/13.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWUBLeftImageFollowField.h"

@interface ColorfulWoodUILogin : UIView

/**
 * 输入手机号码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_fieldPhone;

/**
 * 输入密码
 */
@property(nonatomic, strong)CWUBLeftImageFollowField* m_fieldPwd;

@end
