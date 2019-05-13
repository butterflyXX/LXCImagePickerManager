//
//  LXCImagePickerManager.m
//  ActionSheetPicker-3.0
//
//  Created by 刘晓晨 on 2018/9/11.
//

#import "LXCImagePickerManager.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/PHPhotoLibrary.h>

@interface LXCImagePickerManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,copy)LXCImagePickerManagerImageBlock imageBlock;

@end

@implementation LXCImagePickerManager

-(void)showImagePickerActionSheetWithViewController:(UIViewController *)viewController ImageBlock:(LXCImagePickerManagerImageBlock)imageBlock {
    self.imageBlock = imageBlock;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camaraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getImageWitySourceType:UIImagePickerControllerSourceTypeCamera withViewController:viewController];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getImageWitySourceType:UIImagePickerControllerSourceTypePhotoLibrary withViewController:viewController];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:camaraAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (UIImagePickerController *)getImageWitySourceType:(UIImagePickerControllerSourceType)sourceType withViewController:(UIViewController *)viewController
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) return nil;
    
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = sourceType;
    
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    
    NSString *appName = [[NSBundle mainBundle].localizedInfoDictionary objectForKey:@"CFBundleDisplayName"];
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        //判断是否有相机权限
        NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
        
        if (!appName.length) {
            appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        };
        if(authStatus == AVAuthorizationStatusRestricted ||
           authStatus == AVAuthorizationStatusDenied) {
            NSString *errorStr = [NSString stringWithFormat:@"应用相机权限受限,请在iPhone的“设置-隐私-相机”选项中，允许%@访问你的相机。",appName];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [viewController presentViewController:alertController animated:YES completion:nil];
            
        } else {
            //必须使用present 方法
            [viewController presentViewController:ipc animated:YES completion:nil];
            
        }
    } else {
//        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
//            NSString *errorStr = [NSString stringWithFormat:@"应用相册权限受限,请在iPhone的“设置-隐私-相机”选项中，允许%@访问你的相机。",appName];
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
//            [viewController presentViewController:alertController animated:YES completion:nil];
//        } else {
//
//        }
        [viewController presentViewController:ipc animated:YES completion:nil];
    }
    return ipc;
}

// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.imageBlock) {
        self.imageBlock(image);
    }
//    [self.navigationController pushViewController:imageCropVC animated:YES];
    
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];

}

-(void)dealloc {
    NSLog(@"imageManager释放");
}

@end
