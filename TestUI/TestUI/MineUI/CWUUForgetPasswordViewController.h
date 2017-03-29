//
//  CWUUForgetPasswordViewController.h
//  TestUI
//
//  Created by 大新 on 2017/3/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>

@protocol CWUUForgetPasswordViewControllerDelegate <NSObject>

/**
 * 成功后返回
 */
- (void)CWUUForgetPasswordViewControllerDelegate_success;

@end

@interface CWUUForgetPasswordViewController : UIViewController

@property(nonatomic, weak) id<CWUUForgetPasswordViewControllerDelegate> delegate;

@property (nonatomic, strong) ColorfulWoodUIForget *m_view;

-(BOOL) onNext;

@end
