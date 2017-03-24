//
//  CWUUUserDetail.m
//  TestUI
//
//  Created by 大新 on 2017/3/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUUserDetail.h"

#define CWUUUserDetailLogin @"CWUUUserDetailLogin"

@implementation CWUUUserDetail
#pragma mark - 单例
static CWUUUserDetail * share = nil;

+ (id)shareInstance {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        share = [[self alloc] init];
        [share getUserDetail];
        
    });
    
    return share;
}

- (void)saveUserDetail:(CWUUUserDetailModel*)detail{
    
    self.m_userDetailModel = detail;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.m_userDetailModel];
    [user setObject:data forKey:CWUUUserDetailLogin];
    [user synchronize];
}

- (CWUUUserDetailModel*)getUserDetail{
    
    //获取字节流
    NSData *data =[[NSUserDefaults standardUserDefaults] objectForKey:CWUUUserDetailLogin];
    //解码
    self.m_userDetailModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return self.m_userDetailModel;
}
@end
