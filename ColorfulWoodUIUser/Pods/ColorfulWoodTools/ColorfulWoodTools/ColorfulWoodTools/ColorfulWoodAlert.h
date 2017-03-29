//
//  ColorfulWoodAlert.h
//  ColorfulWoodTools
//  提示弹窗
//  Created by 大新 on 2017/2/21.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorfulWoodAlert : NSObject
/**
 * 隐藏需要调用 + (void) hidden
 */
+ (void) showAlertWaitingNetwork;

/**
 * 隐藏需要调用 + (void) hidden
 */
+ (void) showAlertWithTitle:(NSString*)title;

/**
 * 自动隐藏
 */
+ (void) showAlertAutoHideWithTitle:(NSString*)title afterDelay:(NSTimeInterval)delay;

+ (void) hidden;

@end
