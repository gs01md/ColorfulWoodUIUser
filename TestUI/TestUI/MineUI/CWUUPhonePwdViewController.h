//
//  CWUUPhonePwdViewController.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/16.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>

@protocol CWUUPhonePwdViewControllerDelegate <NSObject>

/**
 * 成功后返回
 */
- (void)CWUUPhonePwdViewControllerDelegate_success;

@end

@interface CWUUPhonePwdViewController : UIViewController

@property(nonatomic, weak) id<CWUUPhonePwdViewControllerDelegate> delegate;

@property (nonatomic, strong) ColorfulWoodUIPhonePwd *m_view;

-(BOOL) onNext;
@end
