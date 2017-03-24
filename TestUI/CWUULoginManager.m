//
//  CWUULoginManager.m
//  TestUI
//
//  Created by 大新 on 2017/3/17.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUULoginManager.h"

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


@end
