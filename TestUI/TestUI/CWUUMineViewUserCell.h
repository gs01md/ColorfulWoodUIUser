//
//  CWUUMineViewUserCell.h
//  TestUI
//
//  Created by 大新 on 2017/3/15.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWUUMineViewUserCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void) CWUUMineViewUserTableViewCell_settingWithHead:(NSString*)imgHead name:(NSString*)name;
@end
