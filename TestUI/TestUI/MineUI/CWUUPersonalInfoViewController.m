//
//  CWUUPersonalInfoViewController.m
//  TestUI
//
//  Created by 大新 on 2017/3/20.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUPersonalInfoViewController.h"
#import <ColorfulWoodTools.h>
#import "CWUUTableViewInfo.h"
#import <ColorfulWoodUIBase/CWUBDefine.h>
#import <BmobSDK/Bmob.h>
#import "CWUUUserDetailModel.h"
#import "CWUULoginManager.h"
#import "CWUUTextFieldViewController.h"

@interface CWUUPersonalInfoViewController ()<
CWUUTableViewInfoDelegate,
ColorfulWoodSelectPhotoDelegate,
CWUUTextFieldViewControllerDelegate
>{
    
    ColorfulWoodSelectPhoto * photo;
    CWUUTextFieldViewController * m_nickNameVC;
}

@end

@implementation CWUUPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    [self leftWithButtonImage:[UIImage imageNamed:@"btn_back"] action:@selector(backBtn)];
    
    [self.view addSubview:self.m_view];
}

#pragma mark - 属性
- (CWUUPersonalInfoView*)m_view{
    
    if (!_m_view) {
        
        _m_view = [[CWUUPersonalInfoView alloc] initWithFrame:self.view.frame];
        _m_view.delegate = self;
        
        [self reloadTable];

    }
    
    return _m_view;
}

#pragma mark - 功能
- (void)reloadTable {
    
    [self.m_view.m_arraySection removeAllObjects];
    
    CWUULoginManager * detail = [CWUULoginManager shareInstance];
    CWUUTableViewInfoCell * cellNickName = [CWUUTableViewInfoCell new];
    cellNickName.m_cellTitle = @"昵称";
    cellNickName.m_cellDetail = detail.m_userDetailModel.nickName;
    cellNickName.m_canClick = YES;
    
    CWUUTableViewInfoCell * cellPhone = [CWUUTableViewInfoCell new];
    cellPhone.m_cellTitle = @"手机";
    cellPhone.m_cellDetail = [BmobUser currentUser].mobilePhoneNumber;
    cellPhone.m_canClick = NO;
    
    //        CWUUTableViewInfoCell * cellEmail = [CWUUTableViewInfoCell new];
    //        cellEmail.m_cellTitle = @"邮箱";
    //        cellEmail.m_cellDetail = [BmobUser currentUser].email;
    //        cellEmail.m_canClick = YES;
    
    CWUUTableViewInfoSection * sectionSetting = [CWUUTableViewInfoSection new];
    [sectionSetting.m_arrayCell addObject:cellPhone];
    [sectionSetting.m_arrayCell addObject:cellNickName];
    //        [sectionSetting.m_arrayCell addObject:cellEmail];
    
    [_m_view.m_arraySection addObject:sectionSetting];
    [_m_view CWUUPersonalInfoView_reloadTable];
}

#pragma mark - 事件
- (void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - cell点击代理事件
- (void) CWUUTableViewInfoDelegate_selected:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            [self actionSection0WithIndexPath:indexPath];
            break;
            
        case 1:
            [self actionSection1WithIndexPath:indexPath];
            break;
            
        default:
            break;
    }
}

#pragma mark cell点击代理事件: section 0
- (void)actionSection0WithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [self actionSection0Row0];
            break;
            
        default:
            break;
    }
}

- (void)actionSection0Row0{
    
    photo = [[ColorfulWoodSelectPhoto alloc] initWithWithView:self];
    photo.delegate = self;
    
}

#pragma mark cell点击代理事件: section 1
- (void)actionSection1WithIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
        case 1:
            [self actionSection1Row1];
            break;
            
        default:
            break;
    }
}

- (void)actionSection1Row1{
    
    m_nickNameVC = [CWUUTextFieldViewController new];
    m_nickNameVC.title = @"更改昵称";
    m_nickNameVC.m_filed.placeholder = @"请输入昵称";
    m_nickNameVC.delegate = self;
    [self.navigationController pushViewController:m_nickNameVC animated:YES];
    
    
}


#pragma mark - 选择图片代理

/**
 * 选择好图片
 */
- (void)ColorfulWoodSelectPhotoDelegate_success:(UIImage*)img{
    
    if (![BmobUser currentUser]) {
        
        [ColorfulWoodAlert showAlertAutoHideWithTitle:@"未登录" afterDelay:2.];
        return;
    }
    
    [ColorfulWoodAlert showAlertWithTitle:@"上传中"];
    
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%@%ld.jpg", [BmobUser currentUser].objectId ,(long)[senddate timeIntervalSince1970]];
    date2 = [NSString stringWithFormat:@"HeadImageWithUserId_%@.jpg",[BmobUser currentUser].objectId];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
    
    BmobFile * file = [[BmobFile alloc] initWithFileName:date2 withFileData:imageData];
    
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            
            NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:[BmobUser currentUser].objectId,@"objectId", @"headImage",@"field",file.url,@"value",nil];
            
            [BmobCloud callFunctionInBackground:@"UpdateUserInfo" withParameters:dic block:^(id object, NSError *error) {
                
                BmobError * bmobError = [NSDictionary checkWithBmobDic:object];
                
                if (bmobError.m_code == BmobErrorType_Success) {
                    
                    CWUUUserDetailModel * info = [[CWUUUserDetailModel alloc]initWithDictionary:object[@"content"] error:nil];
                    CWUULoginManager * detail = [CWUULoginManager shareInstance];
                    [detail saveUserDetail:info];
                    
                    //执行成功时调用
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:@"头像上传成功" afterDelay:2.];
                    
                    [self.m_view CWUUPersonalInfoView_reloadTable];
                    
                }else{
                    
                    switch (bmobError.m_code) {
                        case 201:
                            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"数据无效" afterDelay:2.];
                            break;
                            
                        default:
                            [ColorfulWoodAlert showAlertAutoHideWithTitle:bmobError.m_strError afterDelay:2.];
                            break;
                    }
                    
                }
                
            }] ;

            
        }else{
            
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"上传失败" afterDelay:2.];
        }
        
    }];
    
    return;
    
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:[BmobUser currentUser].objectId block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
                [obj1 setObject:@"test@email.com" forKey:@"email"];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}

#pragma mark - 设置昵称代理
- (void)CWUUTextFieldViewControllerDelegate_save:(NSString*)text {
    
    [self.navigationController popToViewController:self animated:YES];
    
    NSDictionary  *dic = [NSDictionary  dictionaryWithObjectsAndKeys:[BmobUser currentUser].objectId,@"objectId", @"nickName",@"field",text,@"value",nil];
    
    [BmobCloud callFunctionInBackground:@"UpdateUserInfo" withParameters:dic block:^(id object, NSError *error) {
        
        BmobError * bmobError = [NSDictionary checkWithBmobDic:object];
        
        if (bmobError.m_code == BmobErrorType_Success) {
            
            CWUUUserDetailModel * info = [[CWUUUserDetailModel alloc]initWithDictionary:object[@"content"] error:nil];
            CWUULoginManager * detail = [CWUULoginManager shareInstance];
            [detail saveUserDetail:info];
            
            //执行成功时调用
            [ColorfulWoodAlert showAlertAutoHideWithTitle:@"昵称更改成功" afterDelay:2.];
            
            [self reloadTable];
            
        }else{
            
            switch (bmobError.m_code) {
                case 201:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:@"数据无效" afterDelay:2.];
                    break;
                    
                default:
                    [ColorfulWoodAlert showAlertAutoHideWithTitle:bmobError.m_strError afterDelay:2.];
                    break;
            }
            
        }
        
    }] ;
    

}
@end
