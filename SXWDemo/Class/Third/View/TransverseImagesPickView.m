//
//  TransverseImageView.m
//  SXWDemo
//
//  Created by JM001 on 2019/6/27.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "TransverseImagesPickView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <Photos/Photos.h>
#import <TZImagePickerController/UIView+Layout.h>
#import <TZImagePickerController/TZImageManager.h>
#import "SXWImagePickCollectionViewCell.h"


@interface TransverseImagesPickView ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/**图片存放父视图*/
@property (nonatomic, strong)UICollectionView *imageCollectionView;
/**最大可选图片数量*/
@property (nonatomic, assign)NSInteger maxImages;
/**每行展示的图片数量*/
@property (nonatomic, assign)NSInteger imagesCountPerRow;
/**已选择的图片*/
@property (nonatomic, strong)NSMutableArray *selectedPhotos;
/**已选择的资源*/
@property (nonatomic, strong)NSMutableArray *selectedAssets;

@property (nonatomic, assign)CGFloat offer;


@end

@implementation TransverseImagesPickView
#pragma makr - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame andMaxImages:(NSInteger)count imagesNumPerRow:(NSInteger)num
{
    if ([super initWithFrame:frame])
    {
        self.maxImages = count;
        self.imagesCountPerRow = num;
        self.selectedPhotos = [NSMutableArray array];
        self.selectedAssets = [NSMutableArray array];
        [self addSubview:self.imageCollectionView];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, self.imageCollectionView.frame.size.height);
    }
    return self;
}
#pragma makr - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.selectedPhotos.count == self.maxImages)
    {//如果选择的图片等于最大可选择数量，那么就返回最大数量
        return self.maxImages;
    }
    else
    {
        return _selectedPhotos.count + 1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXWImagePickCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXWImagePickCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == self.selectedPhotos.count)
    {
        //需要展示添加指示图片
        cell.contentImageView.image = [UIImage imageNamed:@"pr"];
        cell.deleteBtn.hidden = YES;
    }
    else
    {
        //普通的图片展示
        cell.contentImageView.image = _selectedPhotos[indexPath.row];
        cell.asset = self.selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
        [self layoutIfNeeded];
        [self.imageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];//横向
    }
    
    //删除图片的Block
    cell.deleteButtonClickBlock = ^(NSInteger tag)
    {
        [self deleteActionWithTag:indexPath.row];
    };
    
    return cell;
}
#pragma mark - 删除图片
- (void)deleteActionWithTag:(NSInteger)tag
{
    [_selectedAssets removeObjectAtIndex:tag];
    [_selectedPhotos removeObjectAtIndex:tag];
    [_imageCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
        [self.imageCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.imageCollectionView reloadData];
        [self layoutNewFrame];
    }];
    
    if ([self.delegate respondsToSelector:@selector(imagePickerView:didFinishPickPhoto:)])
    {
        [self.delegate imagePickerView:self didFinishPickPhoto:self.selectedPhotos];
    }
    [self layoutIfNeeded];
    [self.imageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];//横向
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    //    JMLog(@"scrollViewDidScroll");
//    CGPoint point=scrollView.contentOffset;
//    JMLog(@"------%f----------%f----------",point.x,point.y);
//    // 从中可以读取contentOffset属性以确定其滚动到的位置。
//    // 注意：当ContentSize属性小于Frame时，将不会出发滚动
//    
//}
#pragma mark -----------------CollectionView点击事件--------------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.selectedPhotos.count)
    {
        //点击的是添加cell
        if (self.selectedPhotos.count == self.maxImages)
        {
            //已经不能再选择图片了
            NSString *title = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Select a maximum of %zd photos"], self.maxImages];
            [[[TZImagePickerController alloc]init] showAlertWithTitle:title];
            return;
        }
        else
        {
            //选择图片
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                      {
                                          //判断权限
                                          AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                                          if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
                                          {
                                              UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
                                              UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                                                        {
                                                                            
                                                                        }];
                                              UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                                                        {
                                                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                                        }];
                                              [alertC addAction:action1];
                                              [alertC addAction:action2];
                                              [self.viewController presentViewController:alertC animated:YES completion:nil];
                                          }
                                          else
                                          {
                                              UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                              picker.delegate = self;
                                              picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                              [self.viewController presentViewController:picker animated:YES completion:nil];
                                          }
                                          
                                          
                                      }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                      {
                                          TZImagePickerController *picker = [[TZImagePickerController alloc]initWithMaxImagesCount:self.maxImages delegate:self];
                                          picker.selectedAssets = self.selectedAssets;
                                          picker.allowTakePicture = NO;
                                          [self.viewController presentViewController:picker animated:YES completion:nil];
                                      }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertC addAction:action1];
            [alertC addAction:action2];
            [alertC addAction:action3];
            [self.viewController presentViewController:alertC animated:YES completion:nil];
        }
    }
    else
    {
        //预览图片
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectedPhotos index:indexPath.row];
        imagePicker.allowPickingImage = NO;
        [self.viewController presentViewController:imagePicker animated:YES completion:nil];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TZImageManager manager]savePhotoWithImage:image completion:^(PHAsset *asset, NSError *error)
         {
             [self.selectedAssets addObject:asset];
             [self.selectedPhotos addObject:image];
             [self.imageCollectionView reloadData];
             [self layoutNewFrame];
             if ([self.delegate respondsToSelector:@selector(imagePickerView:didFinishPickPhoto:)])
             {
                 [self.delegate imagePickerView:self didFinishPickPhoto:self.selectedPhotos];
             }
         }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos
{
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [_imageCollectionView reloadData];
    [self layoutNewFrame];
    if ([self.delegate respondsToSelector:@selector(imagePickerView:didFinishPickPhoto:)])
    {
        [self.delegate imagePickerView:self didFinishPickPhoto:self.selectedPhotos];
    }
}

#pragma makr - 懒加载
- (UICollectionView *)imageCollectionView
{
    if (!_imageCollectionView)
    {
        //图片的宽度 图片直接的间隔是5
        CGFloat imgItemWidth = (self.frame.size.width - (self.imagesCountPerRow + 1) * 5) / self.imagesCountPerRow;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(imgItemWidth, imgItemWidth);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, imgItemWidth + 10) collectionViewLayout:layout];
        _imageCollectionView.backgroundColor = [UIColor grayColor];
        _imageCollectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
//        _imageCollectionView.scrollEnabled = NO;
//        _imageCollectionView.decelerationRate = 10;//我改的是10
        
        _imageCollectionView.showsHorizontalScrollIndicator = NO;
        _imageCollectionView.showsVerticalScrollIndicator = NO;
        _imageCollectionView.bounces = NO;
        _imageCollectionView.pagingEnabled = YES;
        [_imageCollectionView registerClass:[SXWImagePickCollectionViewCell class] forCellWithReuseIdentifier:@"SXWImagePickCollectionViewCell"];
    }
    return _imageCollectionView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //记录滑动的偏移量
    _offer = scrollView.contentOffset.x;
    JMLog(@"==偏移量======%f",_offer);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //fabs，取绝对值，当前滑动的偏移量较上次比较是大于10便触发
    if (fabs(scrollView.contentOffset.x -_offer) > 10)
    {
        //当前的滑动偏移量大于之前记录的偏移量，说明是右滑
        if (scrollView.contentOffset.x > _offer)
        {
            int i = scrollView.contentOffset.x/(100 * kScale)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            if (index.row < self.selectedPhotos.count)
            {
                [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
        }
        else
        {
            if (scrollView.contentOffset.x < 0)
            {
                //处于左边缘，继续左滑的时候
                NSIndexPath * index =  [NSIndexPath indexPathForRow:0 inSection:0];
                [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
            else
            {
                int i = scrollView.contentOffset.x/(100 * kScale)+1;
                NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
                [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
        }
    }
    else
    {
        int i = scrollView.contentOffset.x/(100 * kScale)+1;
        NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
        if (index.row < self.selectedPhotos.count)
        {
            [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
        else
        {
            [self.imageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedPhotos.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //fabs，取绝对值，当前滑动的偏移量较上次比较是大于20便触发
    if (fabs(scrollView.contentOffset.x -_offer) > 20)
    {
        if (scrollView.contentOffset.x > _offer)
        {
            int i = scrollView.contentOffset.x/(100 * kScale)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            if (index.row < self.selectedPhotos.count)
            {
                [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
        }
        else
        {
            int i = scrollView.contentOffset.x/(100 * kScale)+1;
            i = (i - 1)<0?0:(i - 1);
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

////系统动画停止是刷新当前偏移量_offer是我定义的全局变量
//
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    _offer = scrollView.contentOffset.x;
//    NSLog(@"end========%f",_offer);
//}
//
////滑动减速是触发的代理，当用户用力滑动或者清扫时触发
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    if (fabs(scrollView.contentOffset.x -_offer) > 1)
//    {
//        [self scrollToNextPage:scrollView];
//    }
//
//}
////用户拖拽是调用
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    if (fabs(scrollView.contentOffset.x -_offer) > 1)
//    {
//        [self scrollToNextPage:scrollView];
//    }
//}
//-(void)scrollToNextPage:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.x > _offer)
//    {
//        int i = scrollView.contentOffset.x/(220 *kScale)+1;
//        if (i >= self.selectedPhotos.count)
//        {
//            return;
//        }
//        NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
//        [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    }else{
//        int i = scrollView.contentOffset.x/(220 *kScale)+1;
//        if (i < 1) {
//            return;
//        }
//        NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
//        [self.imageCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    }
//}


#pragma mark - 重新设置视图尺寸
- (void)layoutNewFrame
{
//    NSInteger lineCount;
//    if (self.selectedPhotos.count == _maxImages)
//    {//九张就三行      六张就两行       三张就一行
//        lineCount = ceil(self.selectedPhotos.count / self.imagesCountPerRow);
//    }
//    else
//    {
//        lineCount = ceil(self.selectedPhotos.count / self.imagesCountPerRow) + 1;
//    }
//    //    NSInteger lineCount = ceil(self.selectedPhotos.count / self.imagesCountPerRow) + 1;
//    CGFloat imgItemWidth = (self.frame.size.width - (self.imagesCountPerRow + 1) * 5) / self.imagesCountPerRow;
//    self.imageCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, lineCount *(10 + imgItemWidth));
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.imageCollectionView.frame.size.height);
}


@end


//实现获取视图所在控制器的扩展
@implementation UIView (Extend)
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
