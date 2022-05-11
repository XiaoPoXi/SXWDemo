//
//  SXWHXPhotoViewController.m
//  SXWDemo
//
//  Created by xiaoxi on 2021/11/24.
//  Copyright © 2021 Xiaopoxi. All rights reserved.
//

#import "SXWHXPhotoViewController.h"
#import "HXPhotoPicker.h"
static const CGFloat kPhotoViewMargin = 12.0;

@interface SXWHXPhotoViewController ()

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;

@end

@implementation SXWHXPhotoViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.manager getLocalModelsInFileWithAddData:YES];
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, hxNavigationBarHeight + kPhotoViewMargin, self.view.hx_w - kPhotoViewMargin * 2, 0);
    [self.view addSubview:photoView];
    self.photoView = photoView;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存草稿" style:UIBarButtonItemStylePlain target:self action:@selector(savaClick)];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[deleteItem,saveItem];
}
- (void)savaClick
{
    if (!self.manager.afterSelectedArray.count)
    {
        [self.view hx_showImageHUDText:@"请先选择资源!"];
        return;
    }
    if (![self.manager saveLocalModelsToFile])
    {
        [self.view hx_showImageHUDText:@"保存草稿失败"];
    }
}
- (void)didNavBtnClick
{
    BOOL success = [self.manager deleteLocalModelsInFile];
    if (!success)
    {
        
    }
}
- (HXPhotoManager *)manager
{
    if (!_manager)
    {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 9;
        _manager.configuration.maxNum = 18;
        _manager.configuration.videoMaximumSelectDuration = 500.f;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.showDateSectionHeader = NO;
//        _manager.configuration.requestImageAfterFinishingSelection = YES;
        // 设置保存的文件名称
        _manager.configuration.localFileName = @"suibianshishi111111";
    }
    return _manager;
}

- (void)photoNavigationViewController:(HXCustomNavigationController *)photoNavigationViewController
                       didDoneAllList:(NSArray<HXPhotoModel *> *)allList
                               photos:(NSArray<HXPhotoModel *> *)photoList
                               videos:(NSArray<HXPhotoModel *> *)videoList
                             original:(BOOL)original
{
    JMLog(@"%@",allList);
}
@end
