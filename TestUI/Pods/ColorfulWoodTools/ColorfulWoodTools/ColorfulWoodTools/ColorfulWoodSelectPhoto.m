//
//  ColorfulWoodSelectPhoto.m
//  ColorfulWoodTools
//
//  Created by 大新 on 2017/3/21.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodSelectPhoto.h"
#import "ColorfullWoodToolDefine.h"

@interface ColorfulWoodSelectPhoto()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIActionSheetDelegate
>{
    
    UIActionSheet *m_sheet;
}

@property(nonatomic, weak)UIViewController* m_viewController;

@end


@implementation ColorfulWoodSelectPhoto
#pragma mark - 点击头像

/**
 *  点击头像
 *
 *  @param viewController 显示视图
 */
- (instancetype)initWithWithView:(UIViewController*)viewController{
    
    if (self = [super init]) {
     
        self.m_viewController = viewController;
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            m_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            [m_sheet addButtonWithTitle:@"拍照"];
            [m_sheet addButtonWithTitle:@"从手机相册选择"];
            [m_sheet addButtonWithTitle:@"取消"];
            m_sheet.cancelButtonIndex = m_sheet.numberOfButtons - 1;
            
        } else {
            
            m_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            [m_sheet addButtonWithTitle:@"使用相册"];
            [m_sheet addButtonWithTitle:@"取消"];
            m_sheet.cancelButtonIndex = m_sheet.numberOfButtons - 1;
        }
        
        m_sheet.tag = 255;
        [m_sheet showInView:self.m_viewController.view];
    }
    
    return self;

}
#pragma mark - UIActionSheetDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 2:
                    // 取消
                    return;
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.navigationController.delegate=self;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self.m_viewController presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarHidden=NO;
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __weak ColorfulWoodSelectPhoto *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        
         __strong ColorfulWoodSelectPhoto *strongSelf = weakSelf;
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (image.size.width!=image.size.height)
        {
            image=[strongSelf handleImage:image withSize:CGSizeMake(MIN(image.size.height, image.size.width), MIN(image.size.height, image.size.width))];
        }
        
        if ([strongSelf.delegate respondsToSelector:@selector(ColorfulWoodSelectPhotoDelegate_success:)]) {
            
            [strongSelf.delegate ColorfulWoodSelectPhotoDelegate_success:image];
        }
        
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size{
    
    CGSize originalsize = [originalImage size];
    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height){
        
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate){
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}
@end
