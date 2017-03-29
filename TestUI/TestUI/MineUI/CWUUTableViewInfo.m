//
//  CWUUTableViewInfo.m
//  TestUI
//
//  Created by 大新 on 2017/3/21.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUTableViewInfo.h"


@implementation  CWUUTableViewInfoCell @end

@implementation  CWUUTableViewInfoSection

- (NSMutableArray<CWUUTableViewInfoCell *> *)m_arrayCell{
    
    if (!_m_arrayCell) {
        
        _m_arrayCell = [NSMutableArray<CWUUTableViewInfoCell *> new];
        
    }
    
    return _m_arrayCell;
}

@end

