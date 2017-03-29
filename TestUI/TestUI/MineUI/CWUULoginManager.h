//
//  CWUULoginManager.h
//  TestUI
//
//  Created by 大新 on 2017/3/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWUUUserDetailModel.h"

@interface CWUULoginManager : NSObject

@property (nonatomic, strong) CWUUUserDetailModel * m_userDetailModel;


+ (id)shareInstance;

- (void)saveUserDetail:(CWUUUserDetailModel*)detail;

/**
 * 退出后清除信息
 */
- (void)removeUserDetail;
@end
