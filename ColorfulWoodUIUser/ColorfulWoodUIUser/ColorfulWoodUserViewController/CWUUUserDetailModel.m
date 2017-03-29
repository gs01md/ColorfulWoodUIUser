//
//  CWUUUserInfoModel.m
//  TestUI
//
//  Created by 大新 on 2017/3/24.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUUserDetailModel.h"

@implementation CWUUUserDetailModel
//解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        _nickName = [aDecoder decodeObjectForKey:@"nickName"];
        _headImage = [aDecoder decodeObjectForKey:@"headImage"];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_headImage forKey:@"headImage"];
    [aCoder encodeObject:_nickName forKey:@"nickName"];
}

- (void)resettingDetail{
    
    self.nickName = @"";
    self.headImage = @"";
}

@end
