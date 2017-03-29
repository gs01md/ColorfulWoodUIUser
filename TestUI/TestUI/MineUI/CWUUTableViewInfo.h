//
//  CWUUTableViewInfo.h
//  TestUI
//
//  Created by 大新 on 2017/3/21.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * table的单个cell
 */
@interface CWUUTableViewInfoCell : NSObject

/**
 * 标题
 */
@property(nonatomic, strong) NSString * m_cellTitle;

/**
 * 详情
 */
@property(nonatomic, strong) NSString * m_cellDetail;

/**
 * 图标
 */
@property(nonatomic, strong) NSString * m_cellImg;

/**
 * 是否可以点击，点击则显示右侧箭头图标
 */
@property(nonatomic, assign) BOOL m_canClick;

@end


/**
 * table的单个Section
 */
@interface CWUUTableViewInfoSection : NSObject


/**
 * section的cell数组
 */
@property(nonatomic, strong) NSMutableArray<CWUUTableViewInfoCell *> * m_arrayCell;


@end

@protocol CWUUTableViewInfoDelegate <NSObject>

- (void) CWUUTableViewInfoDelegate_selected:(NSIndexPath *)indexPath;

@end
