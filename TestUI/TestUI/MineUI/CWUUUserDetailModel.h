//
//  CWUUUserInfoModel.h
//  TestUI
//
//  Created by 大新 on 2017/3/24.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CWUUUserDetailModel : JSONModel<NSCoding>
@property (nonatomic, retain) NSString <Optional>* nickName;
@property (nonatomic, retain) NSString <Optional>* headImage;

/**
 * 重置数据
 */
- (void)resettingDetail;
@end

