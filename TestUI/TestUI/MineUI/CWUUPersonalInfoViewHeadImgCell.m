//
//  CWUUPersonalInfoViewHeadImgCell.m
//  TestUI
//
//  Created by 大新 on 2017/3/20.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "CWUUPersonalInfoViewHeadImgCell.h"
#import <Masonry.h>
#import "CWUULoginManager.h"
#import <UIImageView+WebCache.h>

@interface CWUUPersonalInfoViewHeadImgCell ( )

@property (nonatomic, strong) UIImageView *m_imgHead;

@end

@implementation CWUUPersonalInfoViewHeadImgCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    /**
     *  标识符
     */
    static NSString *ID = @"CWUUPersonalInfoViewHeadImgCell";
    
    /**
     *  1.缓存中取
     */
    CWUUPersonalInfoViewHeadImgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        /**
         创建cell
         */
        cell = [[CWUUPersonalInfoViewHeadImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    [self mas_make];
}

- (void)mas_make{
    
    [_m_imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-0.);
        make.top.equalTo(self.contentView).offset(10.);
        make.bottom.equalTo(self.contentView).offset(-10.);
        make.width.equalTo(_m_imgHead.mas_height);
        
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


#pragma mark - 设置属性
-(void) CWUUPersonalInfoViewHeadImgCell_settingWithHead:(NSString*)imgHead name:(NSString*)name{
    
    CWUULoginManager * userDetail = [CWUULoginManager shareInstance];
    NSString* strPath = userDetail.m_userDetailModel.headImage;
    if (strPath && strPath.length>0) {
        NSURL * url = [NSURL URLWithString:strPath];
        [self.m_imgHead sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:imgHead]];
    }else{
        
        if (imgHead) {
            [self.m_imgHead setImage:[UIImage imageNamed:imgHead]];
        }
    }
        
    [self.textLabel setText:name];
    
}

@end

