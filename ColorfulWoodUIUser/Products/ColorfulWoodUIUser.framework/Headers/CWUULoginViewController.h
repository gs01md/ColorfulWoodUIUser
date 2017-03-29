//
//  CWUULoginViewController.h
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/1/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CWUULoginViewControllerDelegate <NSObject>

/**
 * 登录成功
 */
- (void)CWUULoginViewControllerDelegate_success;

@end

@interface CWUULoginViewController : UIViewController

@property(nonatomic, weak) id<CWUULoginViewControllerDelegate> delegate;


@end

