//
//  CWUUMineViewController.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/24.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUMineViewController.h"
#import <BmobSDK/Bmob.h>
#import "CWUULoginViewController.h"
#import "CWUUPersonalInfoViewController.h"
#import "CWUUTableViewInfo.h"
#import "CWUUSettingViewController.h"

@interface CWUUMineViewController ()<
CWUUTableViewInfoDelegate,
CWUULoginViewControllerDelegate
>{
    CWUULoginViewController * m_loginViewController;
    CWUUPersonalInfoViewController * m_personalInfoViewController;
    
}

@property(nonatomic, strong)CWUUSettingViewController * m_settingViewController;

@end

@implementation CWUUMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的";
    
    [self.view addSubview:self.m_view];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.m_view CWUUMineView_reloadTable];
}

#pragma mark - 属性
- (CWUUMineView*)m_view{
    
    if (!_m_view) {
        
        _m_view = [[CWUUMineView alloc] initWithFrame:self.view.frame];
        _m_view.delegate = self;
        
        CWUUTableViewInfoCell * cellSetting = [CWUUTableViewInfoCell new];
        cellSetting.m_cellTitle = @"设置";
        cellSetting.m_cellImg = @"colorfulWoodUIUser_setting";
        cellSetting.m_canClick = YES;
        
//        CWUUTableViewInfoCell * cellAbout = [CWUUTableViewInfoCell new];
//        cellAbout.m_cellTitle = @"关于";
//        cellAbout.m_cellImg = @"colorfulWoodUIUser_about";
//        cellAbout.m_canClick = YES;
        
        CWUUTableViewInfoSection * sectionSetting = [CWUUTableViewInfoSection new];
        [sectionSetting.m_arrayCell addObject:cellSetting] ;
//        [sectionSetting.m_arrayCell addObject:cellAbout] ;
        
        [_m_view.m_arraySection addObject:sectionSetting];
        [_m_view CWUUMineView_reloadTable];
    }
    
    return _m_view;
}

- (CWUUSettingViewController*)m_settingViewController{
    
    if (!_m_settingViewController) {
    
        _m_settingViewController = [CWUUSettingViewController new];
    }
    
    return _m_settingViewController;
}

#pragma mark - 界面的代理
- (void) CWUUTableViewInfoDelegate_selected:(NSIndexPath *)indexPath{
    
    /**
     * 未登录时，先登录
     */
    if (![BmobUser currentUser]) {
        
        [self gotoLogin];
        
        return;
    }
    
    [self actionWithIndexPath:indexPath];
    
}

#pragma mark - 登录
- (void) gotoLogin{
    
    m_loginViewController = [[CWUULoginViewController alloc] init];
    m_loginViewController.delegate = self;
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:m_loginViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 * 登录成功代理
 */
- (void)CWUULoginViewControllerDelegate_success{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 跳转
- (void)actionWithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.section) {
            
        case 0:{
            
            [self actionSection0];
        }
            
            break;
            
        case 1:{
            
            [self actionSection1WithIndexPath:indexPath];
        }
            
            break;
            
        default:
            break;
    }

}

/**
 * 跳转到个人设置页面
 */
- (void)actionSection0{
    
    m_personalInfoViewController = [[CWUUPersonalInfoViewController alloc] init];
    
    [self.navigationController pushViewController:m_personalInfoViewController animated:YES];

}

- (void)actionSection1WithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
            
        case 0:{
            
            [self actionSection1Row0];
        }
            
            break;
            
        case 1:{
            
        }
            
            break;
            
        default:
            break;
    }
    
}

/**
 * 跳转到个人设置页面
 */
- (void)actionSection1Row0{
    
    [self.navigationController pushViewController:self.m_settingViewController animated:YES];
    
}

@end
