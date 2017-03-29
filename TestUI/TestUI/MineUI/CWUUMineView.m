//
//  CWUUMineView.m
//  ColorfulWoodUIUser
//
//  Created by 大新 on 2017/2/24.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUMineView.h"
#import <Masonry.h>
#import <ColorfulWoodUIBase/CWUBDefine.h>
#import "CWUUMineViewUserCell.h"


@interface CWUUMineView ()<
UITableViewDelegate,
UITableViewDataSource
>


@end

@implementation CWUUMineView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = CWUBDefineColorBackGround;
        
        [self initWidgets];
    }
    
    return self;
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
        _m_tableView.backgroundColor = CWUBDefineColorBackGround;
        _m_tableView.dataSource = self;
        _m_tableView.delegate = self;
        _m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _m_tableView.tableFooterView = [UIView new];
        
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
            
            CWUUMineViewUserCell *cell =[CWUUMineViewUserCell cellWithTableView:tableView];
            [cell CWUUMineViewUserTableViewCell_settingWithHead:@"userHead" name:@"请登录..."];
            
            return cell;
        }
            
            break;
            
        default:{
            
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CWUUMineViewCell"];
            
            if (indexPath.section >= _m_arraySection.count) {
                
                CWUUTableViewInfoSection * section = _m_arraySection[indexPath.section-1];
                
                [cell.imageView setImage:[UIImage imageNamed:section.m_arrayCell[indexPath.row].m_cellImg]];
                
                cell.textLabel.text = section.m_arrayCell[indexPath.row].m_cellTitle;
                
                if (_m_arraySection[indexPath.section-1].m_arrayCell[indexPath.row].m_canClick) {
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                
                if (indexPath.row == section.m_arrayCell.count-1) {
                    
                    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);

                }else{
                    
                    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
                }
            }

            
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
    
    return 20.;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20.)];
    [headerView setBackgroundColor:CWUBDefineColorBackGround];
    
    return headerView;
}
#pragma mark - 对外功能

- (void) CWUUMineView_reloadTable{
    
    [_m_tableView reloadData];
}
@end
