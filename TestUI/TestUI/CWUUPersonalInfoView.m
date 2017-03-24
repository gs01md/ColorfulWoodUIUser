//
//  CWUUPersonalInfoView.m
//  TestUI
//
//  Created by 大新 on 2017/3/21.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUPersonalInfoView.h"
#import <Masonry.h>
#import "CWUUPersonalInfoViewHeadImgCell.h"
#import <ColorfulWoodUIBase/CWUBDefine.h>

@interface CWUUPersonalInfoView ()<
UITableViewDelegate,
UITableViewDataSource
>



@end

@implementation CWUUPersonalInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = CWUBDefineColorBackGround;
        
        [self initWidgets];
    }
    
    return self;
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    
    [super layoutSublayersOfLayer:layer];
    
    [self.m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
}

/**
 * 布局
 */
- (void)initWidgets{
    
    [self addSubview:self.m_tableView];
    [_m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        
        
    }];
}

#pragma mark - 属性
- (UITableView*)m_tableView{
    
    if (!_m_tableView) {
        
        _m_tableView = [UITableView new];
        _m_tableView.dataSource = self;
        _m_tableView.delegate = self;
        _m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _m_tableView.backgroundColor = CWUBDefineColorBackGround;
        
    }
    
    return _m_tableView;
}

- (NSMutableArray<CWUUTableViewInfoSection *> *)m_arraySection{
    
    if (!_m_arraySection) {
        
        _m_arraySection = [NSMutableArray<CWUUTableViewInfoSection *> new];
        
    }
    
    return _m_arraySection;
}

#pragma mark - tableView 代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_m_arraySection) {
        
        return _m_arraySection.count+1;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    if (_m_arraySection && _m_arraySection.count>=section && _m_arraySection[section-1].m_arrayCell) {
        
        return _m_arraySection[section-1].m_arrayCell.count;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CWUBDefineScaleFrom_iPhone6s_Desgin(100.0f);
    }
    
    return CWUBDefineScaleFrom_iPhone6s_Desgin(50.0f);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0:{
            
            CWUUPersonalInfoViewHeadImgCell *cell =[CWUUPersonalInfoViewHeadImgCell cellWithTableView:tableView];
            [cell CWUUPersonalInfoViewHeadImgCell_settingWithHead:@"userHead" name:@"头像"];
            
            return cell;
        }
            
            break;
            
        default:{
            
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CWUUPersonalInfoView"];
            
            if (indexPath.section >= _m_arraySection.count) {
                
                CWUUTableViewInfoSection * section = _m_arraySection[indexPath.section-1];
                
                [cell.imageView setImage:[UIImage imageNamed:section.m_arrayCell[indexPath.row].m_cellImg]];
                
                CWUUTableViewInfoCell * cellInfo = section.m_arrayCell[indexPath.row];
                cell.textLabel.text = cellInfo.m_cellTitle;
                cell.detailTextLabel.text = cellInfo.m_cellDetail;
                
                if (_m_arraySection[indexPath.section-1].m_arrayCell[indexPath.row].m_canClick) {
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                
                if (indexPath.row == section.m_arrayCell.count-1) {
                    
                    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
                    
                }else{
                    
                    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
                }
            }
            
            [cell layoutSubviews];
            return cell;
        }
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(CWUUTableViewInfoDelegate_selected:)]) {
        [self.delegate CWUUTableViewInfoDelegate_selected:indexPath];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 0;
    }
    
    return 20.;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20.)];
    [headerView setBackgroundColor:CWUBDefineColorBackGround];
    
    return headerView;
}

#pragma mark - 对外功能

- (void) CWUUPersonalInfoView_reloadTable{
    
    [_m_tableView reloadData];
}
@end
