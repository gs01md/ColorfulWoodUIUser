//
//  CWUUPhoneCodeViewController.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/24.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>

@protocol CWUUPhoneCodeViewControllerDelegate <NSObject>

/**
 * 成功后返回
 */
- (void)CWUUPhoneCodeViewControllerDelegate_success;

@end

@interface CWUUPhoneCodeViewController : UIViewController

@property(nonatomic, weak) id<CWUUPhoneCodeViewControllerDelegate> delegate;

@property (nonatomic, strong) ColorfulWoodUIPhoneSMS *m_view;
@end
