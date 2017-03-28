//
//  CWUUSettingViewController.m
//  TestUI
//
//  Created by 大新 on 2017/3/27.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUSettingViewController.h"
#import <ColorfulWoodUIBase/ColorfulWoodUIBase.h>
#import <ColorfulWoodTools.h>
#import <BmobSDK/Bmob.h>
#import "CWUULoginManager.h"
#import "CWUUForgetPasswordViewController.h"

@interface CWUUSettingViewController ()<
CWUUTableViewInfoDelegate,
CWUUForgetPasswordViewControllerDelegate
>
@property(nonatomic, strong)CWUUForgetPasswordViewController * m_forgetPwdVC;
@end

@implementation CWUUSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CWUBDefineColorBackGround;
    
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    
    self.title = @"设置";
    
    [self.view addSubview:self.m_view];
}

#pragma mark - 事件
- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 属性
- (CWUUSettingView*)m_view{
    
    if (!_m_view) {
        
        _m_view = [[CWUUSettingView alloc] initWithFrame:self.view.frame];
        _m_view.delegate = self;
        
        CWUUTableViewInfoCell * cellChangeSecret = [CWUUTableViewInfoCell new];
        cellChangeSecret.m_cellTitle = @"修改密码";
        cellChangeSecret.m_canClick = YES;
        
        CWUUTableViewInfoCell * cellSetting = [CWUUTableViewInfoCell new];
        cellSetting.m_cellTitle = @"清除缓存";
        cellSetting.m_canClick = YES;
        
        CWUUTableViewInfoSection * sectionSetting = [CWUUTableViewInfoSection new];
        [sectionSetting.m_arrayCell addObject:cellChangeSecret] ;
        [sectionSetting.m_arrayCell addObject:cellSetting] ;
        
        [_m_view.m_arraySection addObject:sectionSetting];
        
        CWUUTableViewInfoCell * cellLogout = [CWUUTableViewInfoCell new];
        cellLogout.m_cellTitle = @"退出登录";
        cellLogout.m_canClick = NO;
        CWUUTableViewInfoSection * sectionLogout= [CWUUTableViewInfoSection new];
        [sectionLogout.m_arrayCell addObject:cellLogout] ;
        
        [_m_view.m_arraySection addObject:sectionLogout];
        
        [_m_view CWUUSettingView_reloadTable];
    }
    
    return _m_view;
}

- (CWUUForgetPasswordViewController*) m_forgetPwdVC{
    
    if (!_m_forgetPwdVC) {
        
        _m_forgetPwdVC = [CWUUForgetPasswordViewController new];
        _m_forgetPwdVC.delegate = self;
    }
    
    return _m_forgetPwdVC;
}

#pragma mark - 界面的代理
- (void) CWUUTableViewInfoDelegate_selected:(NSIndexPath *)indexPath{
    
    [self actionWithIndexPath:indexPath];
    
}

#pragma mark - 跳转
- (void)actionWithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.section) {
            
        case 0:{
            
            [self actionSection0WithIndexPath:indexPath];
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

- (void)actionSection0WithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
            
        case 0:{
            
            [self actionSection0Row0];
        }
            break;
            
        case 1:{
            
            [self actionSection0Row1];
        }
            break;
            
        default:
            break;
    }
    
}

- (void) actionSection0Row0{
    
    [self.navigationController pushViewController:self.m_forgetPwdVC animated:YES];
}

- (void) actionSection0Row1{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"缓存清除" message:@"确定清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.tag = 1000;
    [alertView show];
    
}

- (void)actionSection1WithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
            
        case 0:{
            
            [self actionSection1Row0];
        }
            break;
            
        default:
            break;
    }
    
}

- (void) actionSection1Row0{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"退出登录" message:@"确定退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.tag = 1001;
    [alertView show];
}

#pragma mark - UIAlertViewDelegate方法实现
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag) {
        case 1000:{
            
            if (buttonIndex == 1) {
                
                NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                for (NSString *p in files) {
                    NSError *error;
                    NSString *path = [cachPath stringByAppendingPathComponent:p];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                    }
                }
                
                [self.m_view CWUUSettingView_reloadTable];
            }
        }
            
            break;
            
        case 1001:{
            
            if (buttonIndex == 1) {
                
                [BmobUser logout];
                
                [[CWUULoginManager shareInstance] removeUserDetail];
                
                [self.m_view CWUUSettingView_reloadTable];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 修改密码代理


/**
 * 成功后返回
 */
- (void)CWUUForgetPasswordViewControllerDelegate_success{
    
    [self.navigationController popToViewController:self animated:YES];
}
@end
