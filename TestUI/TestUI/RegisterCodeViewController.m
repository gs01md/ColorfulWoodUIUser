//
//  RegisterCodeViewController.m
//  TestUI
//
//  Created by 大新 on 2017/2/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "RegisterCodeViewController.h"
#import <ColorfulWoodUIUser/ColorfulWoodUIUser.h>
#import <ColorfulWoodCategories.h>
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>

@interface RegisterCodeViewController ()
@property (nonatomic, strong) ColorfulWoodUISMS *m_view;
@end

@implementation RegisterCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(onBackBtn)];
    [self.view addSubview:self.m_view];
}

- (ColorfulWoodUISMS*)m_view{
    
    if (!_m_view) {
        
        CGRect rect = self.view.frame;
        rect.origin.y = 64.;
        rect.size.height = CWUBDefineScaleFrom_iPhone6s_Desgin(100);
        
        _m_view = [[ColorfulWoodUISMS alloc] initWithFrame:rect];
        _m_view.m_imgCode.image = [UIImage imageNamed:@"loginPwd"];
        [_m_view.m_btnConfirm setTitle:@"下一步" forState:UIControlStateNormal];
        [_m_view.m_btnConfirm addTarget:self action:@selector(onRegisterNext) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _m_view;
}


- (void)onBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRegisterNext{
    
    
}

@end
