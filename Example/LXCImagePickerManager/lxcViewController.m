//
//  lxcViewController.m
//  LXCImagePickerManager
//
//  Created by butterflyXX on 05/13/2019.
//  Copyright (c) 2019 butterflyXX. All rights reserved.
//

#import "lxcViewController.h"
#import "LXCImagePickerManager.h"

@interface lxcViewController ()

@end

@implementation lxcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LXCImagePickerManager *picker = [[LXCImagePickerManager alloc] init];
    [picker showImagePickerActionSheetWithViewController:self ImageBlock:^(UIImage *image) {
        NSLog(@"%@",image);
    }];
}

@end
