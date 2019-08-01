//
//  SXWZipArchiveHTMLViewController.m
//  SXWDemo
//
//  Created by XiaoXi on 2019/7/27.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//  解压zip 加载h5

#import "SXWZipArchiveHTMLViewController.h"
#import "SSZipArchive.h"
#import <WebKit/WebKit.h>
#import "AFNetworking.h"
#import <EventKit/EventKit.h>


@interface SXWZipArchiveHTMLViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate,SSZipArchiveDelegate>

@property(nonatomic,copy)NSString * urlstr;
@property(nonatomic,copy)NSString * decodestr;
@property (nonatomic, strong) WKWebView * wkWebView;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SXWZipArchiveHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下载zip";
    [self addbtn];
}



-(void)btnlcick:(UIButton*)btn
{
    switch (btn.tag)
    {
        case 666://下载 http://192.168.8.35/hybrid/add.zip
            [self rquestZipArchivePath:@"http://192.168.8.35/public.zip" andHtmlVersion:@"666"];
            break;
        case 667://解压
            [self releaseZipFilesWithUnzipFileAtPath:self.urlstr Destination:self.decodestr];
            
            break;
        case 668://展示
            [self addSubViews11];
            break;
        case 669://添加提醒
            [self tixing];
            break;
        case 670://删除提醒
            [self shanchutixing];
            break;
            
            
            
        default:
            break;
    }
}


- (void)shanchutixing
{
    [[EventCalendar sharedEventCalendar] deleteEventCalendarWithNotificition:@"ALARMNOTIFICATION"];
}


//提醒
- (void)tixing
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1 = [formatter dateFromString:@"2019-08-01 11:40:00"];
    NSDate *date2 = [formatter dateFromString:@"2019-08-01 12:40:00"];

    //alarmArray 里面是设置提醒，添加一个开始前多久提醒 按秒计算的 负值就是提前多少秒开始
    [[EventCalendar sharedEventCalendar] createEventCalendarTitle:@"淘宝秒杀提醒" location:@"倒计时10s提醒" startDate:date1 endDate:date2 allDay:NO alarmArray:@[@"-180"] WithNotification:@"ALARMNOTIFICATION"];
    

    
//    EKEventStore *store = [[EKEventStore alloc] init];
//
//    if ([store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
//
//        [store requestAccessToEntityType:(EKEntityTypeEvent) completion:^(BOOL granted, NSError * _Nullable error) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//
//                if (error)
//                {
//                    JMLog(@"添加失败，，错误了。。。");
//                }
//                else if (!granted)
//                {
//                    JMLog(@"不允许使用日历，没有权限");
//                }
//                else
//                {
//
//                    EKEvent *event = [EKEvent eventWithEventStore:store];
//                    event.title = @"这是一个 title";
//                    event.location = @"这是一个 location";
//
//
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//                    NSDate *date = [formatter dateFromString:@"2019-08-01 12:59:33"];
//
//                    // 提前一个小时开始
//                    NSDate *startDate = [NSDate dateWithTimeInterval:-3600 sinceDate:date];
//                    // 提前一分钟结束
//                    NSDate *endDate = [NSDate dateWithTimeInterval:60 sinceDate:date];
//
//                    event.startDate = startDate;
//                    event.endDate = endDate;
//                    event.allDay = NO;
//
//                    // 添加闹钟结合（开始前多少秒）若为正则是开始后多少秒。
//                    EKAlarm *elarm2 = [EKAlarm alarmWithRelativeOffset:-20];
//                    [event addAlarm:elarm2];
//                    EKAlarm *elarm = [EKAlarm alarmWithRelativeOffset:-10];
//                    [event addAlarm:elarm];
//
//                    [event setCalendar:[store defaultCalendarForNewEvents]];
//
//                    NSError *error = nil;
//                    [store saveEvent:event span:EKSpanThisEvent error:&error];
//                    if (!error) {
//                        JMLog(@"添加时间成功");
//                        //添加成功后需要保存日历关键字
//                        NSString *iden = event.eventIdentifier;
//                        // 保存在沙盒，避免重复添加等其他判断
//                        [[NSUserDefaults standardUserDefaults] setObject:iden forKey:@"my_eventIdentifier"];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                    }
//
//                }
//            });
//        }];
//    }
}

//下载zip
-(void)rquestZipArchivePath:(NSString *)pathUrl andHtmlVersion:(NSString *)version
{
    //远程地址
    NSURL *URL = [NSURL URLWithString:pathUrl];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask * downloadTask =[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        double curr=(double)downloadProgress.completedUnitCount;
        double total=(double)downloadProgress.totalUnitCount;
        JMLog(@"下载进度==%.2f",curr/total);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        JMLog(@"block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径==%@",targetPath);

        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        //再次之前先删除本地文件夹里面相同的文件夹
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:cachesPath error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        NSString *extension = @"zip";
        while ((filename = [e nextObject]))
        {
            if ([[filename pathExtension] isEqualToString:extension])
            {
                JMLog(@"删除");
                [fileManager removeItemAtPath:[cachesPath stringByAppendingPathComponent:filename] error:NULL];
            }
        }
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)
    {
        //设置下载完成操作
        JMLog(@"设置下载完成操作");
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        NSString *htmlFilePath = [filePath path];// 将NSURL转成NSString
        NSArray *documentArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
       
        NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:@"Preferences"];
        
        //创建文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/html",path] error:nil];
        self.urlstr = htmlFilePath;
        JMLog(@"要解压的文件在==%@==",self.urlstr)
        self.decodestr = path;
        JMLog(@"文件应该解压到什么地方==%@==",self.decodestr)

    }];
    [downloadTask resume];
}
#pragma mark 解压
- (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath
{
    JMLog(@"%@,%@",zipPath,unzipPath);
    NSError *error;
    /*
     第一个参数:要解压的文件在哪里
     第二个参数:文件应该解压到什么地方
     */
    //[SSZipArchive unzipFileAtPath:@"/Users/xiaomage/Desktop/demo.zip" toDestination:@"/Users/xiaomage/Desktop/xx"];

    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath overwrite:YES password:nil error:&error delegate:self])
    {
        JMLog(@"success");
    }
    else
    {
        JMLog(@"-------%@-------",error);
    }
    // 压缩包的全路径(包括文件名)
    //    NSString *destinationPath = zipPath;
    // 目标路径,
    NSString *destinationPath = unzipPath;
    // 解压, 返回值代表是否解压完成
//    Boolean b = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
    
    //    ------------ 带回调的解压    ------------
    Boolean b1 = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        // entry : 解压出来的文件名
        //entryNumber : 第几个, 从1开始
        //total : 总共几个
        JMLog(@"解压出来的文件名------%@, 第几个, 从1开始-----%ld, 总共几个-----%ld  names:---%@", entry, entryNumber, total,destinationPath);
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        //path : 被解压的压缩吧全路径
        //succeeded 是否成功
        // error 错误信息
        JMLog(@"completionHandler:%@, , succeeded:%d, error:%@", path, succeeded, error);
    }];
    
}

#pragma mark - SSZipArchiveDelegate
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo
{
    JMLog(@"将要解压%d",zipInfo.number_entry);
    
}
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPat uniqueId:(NSString *)uniqueId
{
    JMLog(@"解压完成！");
}

-(void)addbtn
{
    NSArray * arr =@[@"下载",@"解压",@"展示html",@"添加到系统提醒事件",@"删除系统提醒事件",@"111"];
    for (int i=0; i<arr.count; i++)
    {
        UIButton* btn =[[UIButton alloc]init];
        btn.backgroundColor=[UIColor orangeColor];
        btn.frame=CGRectMake((i%2) *200+10, 100 +(i/2) *150, 180, 80);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag=666+i;
        [btn addTarget:self action:@selector(btnlcick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

- (void)addSubViews11
{
    if (@available(iOS 9.0, *))
    {
        NSSet * websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate * dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }
    self.view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6];
    //进度条初始化
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1,kScreenWidth, 2)];
    self.progressView.trackTintColor = JMColor(245, 245, 245);
    self.progressView.progressTintColor = JMColor(245, 75, 91);
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    self.progressView.progress = 0.1;
    self.progressView.hidden = NO;
    
    
    //初始化WKWebViewConfiguration
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    /**
     设置代理对象
     ScriptMessageHandler:WKScriptMessageHandler的代理对象
     name:跟后端协调好的响应名称
     **/
//    [config.userContentController addScriptMessageHandler:self name:@"yuansheng"];
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
    self.wkWebView.backgroundColor = [UIColor clearColor];
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
    [self.wkWebView setAllowsBackForwardNavigationGestures:true];
    
//
    NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:@"Preferences"];
    NSString *indexPath = [NSString stringWithFormat:@"file://%@/hybrid/gerenzhongxin/gerenzhuye2.html",path];

    NSURL * accessUrl = [[NSURL URLWithString:indexPath] URLByDeletingLastPathComponent];
    
    [self.wkWebView loadFileURL:[NSURL URLWithString:indexPath] allowingReadAccessToURL:accessUrl];
    
    
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(64);
    }];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
}

/*
 接受js传递的事件
 **/
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message
{
    NSString *messageStr = [NSString stringWithFormat:@"%@",message.body];
    if ([messageStr isEqualToString:@"222"])
    {
        //跳转控制器A
        JMLog(@"111111");
    }
    if ([messageStr isEqualToString:@"pushVcB"])
    {
        //跳转控制器B
    }
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler
{
    NSString *startStr = @"startUploadImgCB('start')";
    [self.wkWebView evaluateJavaScript:startStr completionHandler:^(id _Nullable response, NSError * _Nullable error)
    {
        JMLog(@"value: %@ error: %@", response, error);
    }];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1)
        {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            WeakSelf(weakSelf);
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished)
             {
                 weakSelf.progressView.hidden = YES;
             }];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    JMLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view
     bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    JMLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    JMLog(@"====%@======",error);
    JMLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
    //    [ZHWarnView showError:@"加载失败"];第二种就是如果你存的是文件html，有引用css、image这些资源文件，有可能是引用路径的事
}

//当wkwebview总体的内存占用过大的时候，页面即将白屏，就会调用当前函数,再就是配合vc的viewwillapper方法，执行reload方法，基本就可以解决白屏的问题
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    [webView reload];
}

- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}



@end
