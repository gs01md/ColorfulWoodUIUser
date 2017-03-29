//
//  CWUUPersonalInfoView.h
//  TestUI
//
//  Created by 大新 on 2017/3/21.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWUUTableViewInfo.h"

@interface CWUUPersonalInfoView : UIView

@property(nonatomic, weak)id<CWUUTableViewInfoDelegate> delegate;

@property(nonatomic, strong) UITableView * m_tableView;

/**
 * tableView的section数组
 */
@property(nonatomic, strong) NSMutableArray<CWUUTableViewInfoSection *> * m_arraySection;


- (void) CWUUPersonalInfoView_reloadTable;
@end
