//
//  CWUUCodeViewController.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>

@protocol CWUUCodeViewControllerDelegate <NSObject>

/**
 * 注册成功，需要自动返回
 */
- (void)CWUUCodeViewControllerDelegate_success;

@end

@interface CWUUCodeViewController : UIViewController

@property (nonatomic, weak) id<CWUUCodeViewControllerDelegate>delegate;
@property (nonatomic, strong) NSString * m_phone;
@property (nonatomic, strong) NSString * m_pwd;
@property (nonatomic, strong) ColorfulWoodUISMS *m_view;

- (BOOL)checkInputCode;
@end
