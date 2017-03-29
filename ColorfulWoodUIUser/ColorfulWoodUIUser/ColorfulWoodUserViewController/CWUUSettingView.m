//
//  CWUUSettingView.m
//  TestUI
//
//  Created by 大新 on 2017/3/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUSettingView.h"
#import <Masonry.h>
#import <ColorfulWoodUIBase/CWUBDefine.h>
#import <JKCategories/UIImage+JKColor.h>

@interface CWUUSettingView ()<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong)UIView *m_footerView;
@end

@implementation CWUUSettingView

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

#pragma mark - 功能
- (UIView*)m_footerView{
    
    if (!_m_footerView) {
        
        float fLeft   = 0;
        float fTop    = 0;
        float fWidth  = CWUBDefineDeviceWidth;
        float fHeight = 50.;
        CGRect rect = CGRectMake(fLeft, fTop, fWidth, fHeight);
        UIButton *button = [[UIButton alloc] initWithFrame:rect];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage jk_imageWithColor:[UIColor grayColor] ] forState:UIControlStateSelected];
       
        _m_footerView = [[UIView alloc] initWithFrame:rect];
        [_m_footerView addSubview:button];
    }
    
    return _m_footerView;
}


#pragma mark - tableView 代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_m_arraySection) {
        
        return _m_arraySection.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_m_arraySection && _m_arraySection.count>=section && _m_arraySection[section].m_arrayCell) {
        
        return _m_arraySection[section].m_arrayCell.count;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CWUBDefineScaleFrom_iPhone6s_Desgin(50.0f);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        default:{
            
            UITableViewCell * cell;
            
            if (indexPath.section == 1) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CWUUMineViewCell"];
            }else{
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CWUUMineViewCell"];
            }
            
            CWUUTableViewInfoSection * section = _m_arraySection[indexPath.section];
            
            [cell.imageView setImage:[UIImage imageNamed:section.m_arrayCell[indexPath.row].m_cellImg]];
            
            cell.textLabel.text = section.m_arrayCell[indexPath.row].m_cellTitle;
            
            if (_m_arraySection[indexPath.section].m_arrayCell[indexPath.row].m_canClick) {
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            if (indexPath.row == section.m_arrayCell.count-1) {
                
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
                
            }else{
                
                cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
            }
            
            if (indexPath.section == 1) {
                
                cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
            }
            
            if (indexPath.section == 0 && indexPath.row == 1) {
                cell.detailTextLabel.hidden = NO;
                cell.detailTextLabel.text = [self getCacheSize];
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

- (void) CWUUSettingView_reloadTable{
    
    [_m_tableView reloadData];
}

#pragma mark -private
- (NSString *)getCacheSize{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    CGFloat fileSize = [self folderSizeAtPath:cachPath];
    
    return [NSString stringWithFormat:@"%.2fM",fileSize];
}

- (CGFloat)folderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}

@end
