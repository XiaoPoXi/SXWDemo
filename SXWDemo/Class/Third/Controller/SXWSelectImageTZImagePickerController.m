//
//  SXWSelectImageTZImagePickerController.m
//  SXWDemo
//
//  Created by JM001 on 2019/6/24.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWSelectImageTZImagePickerController.h"
#import "ImagesPickView.h"


@interface SXWSelectImageTZImagePickerController ()<ImagePickerViewDelegate>

@end

@implementation SXWSelectImageTZImagePickerController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发现";
    
}




//ImagesPickView *imageP = [[ImagesPickView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) andMaxImages:9 imagesNumPerRow:3];
//imageP.backgroundColor = [UIColor grayColor];
//imageP.delegate = self;
//[self.view addSubview:imageP];
//
//#pragma mark -ImagePickerViewDelegate
//- (void)imagePickerView:(UIView *)view didFinishPickPhoto:(NSArray<UIImage *> *)photos
//{
//    JMLog(@"----%@---",photos);
//}


@end
