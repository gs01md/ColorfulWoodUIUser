//
//  CWUUMineViewUserCell.m
//  TestUI
//
//  Created by 大新 on 2017/3/15.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUMineViewUserCell.h"
#import <Masonry.h>
#import "UIImageView+WebCache.h"
#import "CWUUUserDetail.h"

@interface CWUUMineViewUserCell ( )

@property (nonatomic, strong) UIImageView *m_imgHead;
@property (nonatomic, strong) UILabel *m_labelName;

@end

@implementation CWUUMineViewUserCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    /**
     *  标识符
     */
    static NSString *ID = @"CWUUMineViewUserCell";
    
    /**
     *  1.缓存中取
     */
    CWUUMineViewUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        /**
         创建cell
         */
        cell = [[CWUUMineViewUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createView];
    }
    
    return self;
}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    
    [super layoutSublayersOfLayer:layer];
    
    self.m_imgHead.layer.cornerRadius = 5.;
    
}

- (void)createView{
    
    [self.contentView addSubview:self.m_imgHead];
    [self.contentView addSubview:self.m_labelName];
    
    [self mas_make];
}

- (void)mas_make{
    
    [_m_imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10.);
        make.top.equalTo(self.contentView).offset(10.);
        make.bottom.equalTo(self.contentView).offset(-10.);
        make.width.equalTo(_m_imgHead.mas_height);
        
        
        
    }];
    
    [_m_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_m_imgHead.mas_right).offset(10.);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
        make.height.equalTo(self.contentView);
        
    }];
    
}

#pragma mark - 属性

-(UIImageView*)m_imgHead{
    
    if (!_m_imgHead) {
        
        _m_imgHead = [UIImageView new];
        _m_imgHead.clipsToBounds = YES;
        
    }
    
    return _m_imgHead;
}

-(UILabel*)m_labelName{
    
    if (!_m_labelName) {
        
        _m_labelName = [UILabel new];
    }
    
    return _m_labelName;
}

#pragma mark - 设置属性
-(void) CWUUMineViewUserTableViewCell_settingWithHead:(NSString*)imgHead name:(NSString*)name{
    
    CWUUUserDetail * userDetail = [CWUUUserDetail shareInstance];
    NSString* strPath = userDetail.m_userDetailModel.headImage;
    if (strPath && strPath.length>0) {
        NSURL * url = [NSURL URLWithString:strPath];
        [self.m_imgHead sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:imgHead]];
    }else{
        
        if (imgHead) {
            [self.m_imgHead setImage:[UIImage imageNamed:imgHead]];
        }
    }
    
    NSString* strName = userDetail.m_userDetailModel.nickName;
    
    if (strName && strName.length>0) {
        
        [self.m_labelName setText:strName];
        
    }else{
        
        if (name) {
            
            [self.m_labelName setText:name];
        }
    }

    
}

@end

