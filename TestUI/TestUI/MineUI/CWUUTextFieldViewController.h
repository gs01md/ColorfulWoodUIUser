//
//  CWUUTextFieldViewController.h
//  TestUI
//
//  Created by 大新 on 2017/3/27.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CWUUTextFieldViewControllerDelegate <NSObject>

- (void)CWUUTextFieldViewControllerDelegate_save:(NSString*)text;

@end

@interface CWUUTextFieldViewController : UIViewController

@property(nonatomic, weak)id<CWUUTextFieldViewControllerDelegate>delegate;
@property(nonatomic,strong)UITextField * m_filed;

@end
