//
//  LXCImagePickerManager.h
//  ActionSheetPicker-3.0
//
//  Created by 刘晓晨 on 2018/9/11.
//

#import <Foundation/Foundation.h>

typedef void(^LXCImagePickerManagerImageBlock)(UIImage *image);

@interface LXCImagePickerManager : NSObject

-(void)showImagePickerActionSheetWithViewController:(UIViewController *)viewController ImageBlock:(LXCImagePickerManagerImageBlock)imageBlock;

@end
