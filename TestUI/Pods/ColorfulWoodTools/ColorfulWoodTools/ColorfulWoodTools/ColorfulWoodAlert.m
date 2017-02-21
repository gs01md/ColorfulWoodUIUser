//
//  ColorfulWoodAlert.m
//  ColorfulWoodTools
//
//  Created by 大新 on 2017/2/21.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodAlert.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define ColorfulWoodAlertKeyWindow [UIApplication sharedApplication].keyWindow

@implementation ColorfulWoodAlert

+ (void) showAlertWaitingNetwork{
    
    [ColorfulWoodAlert hidden];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:ColorfulWoodAlertKeyWindow animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
}


+ (void) showAlertAutoHideWithTitle:(NSString*)title afterDelay:(NSTimeInterval)delay{
    
    [ColorfulWoodAlert hidden];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:ColorfulWoodAlertKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    if (title) {
        
        hud.labelText = title;
    }
    
    
    [hud hide:YES afterDelay:delay];
    
}

/**
 * 隐藏需要调用 + (void) hidden
 */
+ (void) showAlertWithTitle:(NSString*)title{
    
    [ColorfulWoodAlert hidden];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:ColorfulWoodAlertKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    if (title) {
        
        hud.labelText = title;
    }
}

+ (void) hidden{
    
    [MBProgressHUD hideAllHUDsForView:ColorfulWoodAlertKeyWindow animated:YES];
}

@end
