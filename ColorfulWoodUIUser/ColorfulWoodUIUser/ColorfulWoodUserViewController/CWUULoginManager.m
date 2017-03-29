//
//  CWUULoginManager.m
//  TestUI
//
//  Created by 大新 on 2017/3/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUULoginManager.h"

#define CWUUUserDetailLogin @"CWUUUserDetailLogin"

@implementation CWUULoginManager

#pragma mark - 单例
static CWUULoginManager * share = nil;

+ (id)shareInstance {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        share = [[self alloc] init];
        
    });
    
    return share;
}

-(CWUUUserDetailModel*)m_userDetailModel{
    
    if (!_m_userDetailModel) {
        
        _m_userDetailModel = [self getUserDetail];
    }
    
    if (!_m_userDetailModel) {
        
        _m_userDetailModel = [CWUUUserDetailModel new];
    }
    
    return _m_userDetailModel;
}

- (void)saveUserDetail:(CWUUUserDetailModel*)detail{
    
    _m_userDetailModel= detail;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.m_userDetailModel];
    [user setObject:data forKey:CWUUUserDetailLogin];
    [user synchronize];
}

- (void)removeUserDetail{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user removeObjectForKey:CWUUUserDetailLogin];
    [user synchronize];
    
    if (_m_userDetailModel) {
        
        [_m_userDetailModel resettingDetail];
    }
    
}

- (CWUUUserDetailModel*)getUserDetail{
    
    //获取字节流
    NSData *data =[[NSUserDefaults standardUserDefaults] objectForKey:CWUUUserDetailLogin];
    
    if (data) {
        
        //解码
        _m_userDetailModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    
    return _m_userDetailModel;
}

@end
