//
//  CWUUTextFieldViewController.m
//  TestUI
//
//  Created by 大新 on 2017/3/27.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUTextFieldViewController.h"
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <ColorfulWoodTools/ColorfulWoodTools.h>


@implementation CWUUTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CWUBDefineColorBackGround;
    
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    [self rightWithText:@"保存" action:@selector(onSave)];
    
    [self.view addSubview:self.m_filed];
}

- (UITextField*)m_filed{
    
    if (!_m_filed) {
        CGRect rect;
        rect.origin.x = 10;
        rect.origin.y = 64.+10;
        rect.size.height = 50;
        rect.size.width = CWUBDefineDeviceWidth - rect.origin.x*2;
        _m_filed = [[UITextField alloc] initWithFrame:rect];
        _m_filed.placeholder = @"";
        _m_filed.layer.borderWidth = 1;
        _m_filed.layer.borderColor = CWUBDefineColorLine.CGColor;
        _m_filed.layer.cornerRadius = 5.;
    }
    
    return _m_filed;
}

#pragma mark - 事件
- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)onSave{
    
    NSString * text = [_m_filed.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (text.length <=0) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"请输入内容" afterDelay:1.5];
        
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(CWUUTextFieldViewControllerDelegate_save:)]) {
        
        [self.delegate CWUUTextFieldViewControllerDelegate_save:text];
    }
    
}
@end
