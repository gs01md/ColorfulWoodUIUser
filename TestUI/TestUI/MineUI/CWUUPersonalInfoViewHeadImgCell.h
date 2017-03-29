//
//  CWUUPersonalInfoViewHeadImgCell.h
//  TestUI
//
//  Created by 大新 on 2017/3/20.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWUUPersonalInfoViewHeadImgCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void) CWUUPersonalInfoViewHeadImgCell_settingWithHead:(NSString*)imgHead name:(NSString*)name;
@end
