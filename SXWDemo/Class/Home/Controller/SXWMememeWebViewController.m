//  SXWMememeWebViewController.m
//  SXWDemo
//
//  Created by JM001 on 2019/1/22.
//  Copyright © 2019 Xiaopoxi. All rights reserved.
//

#import "SXWMememeWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface SXWMememeWebViewController ()<WKNavigationDelegate,WKUIDelegate,SSZipArchiveDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * myweb;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic,strong)JSContext *context;

@end

@implementation SXWMememeWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"微博网页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    [self getversion];
}


- (void)addSubViews
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 15.0;
    configuration.preferences = preferences;
    preferences.javaScriptEnabled = YES;

    //初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    /**
     设置代理对象
     ScriptMessageHandler:WKScriptMessageHandler的代理对象
     name:跟后端协调好的响应名称
     **/
    [config.userContentController addScriptMessageHandler:self name:@"JSON.stringify(data)"];
    
    self.myweb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) configuration:configuration];
    self.myweb.navigationDelegate = self;
    self.myweb.UIDelegate = self;
    self.myweb.scrollView.bounces = false;
    
    [self.view addSubview:self.myweb];
}

//点击web界面跳转时候执行的方法
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    JMLog(@"createWebViewWithConfiguration");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    JMLog(@"页面开始加载时调用didStartProvisionalNavigation");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    JMLog(@"在收到响应后，决定是否跳转decidePolicyForNavigationResponse");
    return;
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    JMLog(@"当内容开始返回时调用didCommitNavigation");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    JMLog(@"页面加载完成之后调用didFinishNavigation");
    
}

/*
 接受js传递的事件
 **/
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message
{
    JMLog(@"接受js传递的事件%@",message.body);
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler
{
    NSString *startStr = @"JSON.stringify(data)";
    [self.myweb evaluateJavaScript:startStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        JMLog(@"value: %@ error: %@", response, error);
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    JMLog(@"====%@======",error);
    JMLog(@"页面加载失败");
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    JMLog(@"接收到服务器跳转请求之后调用didReceiveServerRedirectForProvisionalNavigation");
}

//请求当前项目压缩包版本号。如果版本号比本地版本号大或者本地没有，请求zip压缩包；如果版本号和本地一样，直接加载本地web数据。
-(void)getversion
{
    NSArray *documentArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path1 = [[documentArray lastObject] stringByAppendingPathComponent:@"Preferences"];
    if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/hybrid",path1]])
    {
        [self loadWebData];
//        [self rquestZipArchivePath:@"http://192.168.8.35/public.zip"];
    }else{
        [self rquestZipArchivePath:@"http://192.168.8.35/public.zip"];
    }

}
#pragma mark 请求zip地址
//请求到的压缩包数据，进行解压
-(void)rquestZipArchivePath:(NSString *)pathUrl
{
    //远程地址
    NSURL *URL = [NSURL URLWithString:pathUrl];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask * downloadTask= [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
                                              {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
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
                JMLog(@"删除本地文件");
                [fileManager removeItemAtPath:[cachesPath stringByAppendingPathComponent:filename] error:NULL];
                JMLog(@"%@",contents);
            }
        }
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error==nil)
        {
            //设置下载完成操作
            // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
            NSString *htmlFilePath = [filePath path];// 将NSURL转成NSString
            NSArray *documentArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [[documentArray lastObject] stringByAppendingPathComponent:@"Preferences/"];
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/public",path] error:nil];
            [self releaseZipFilesWithUnzipFileAtPath:htmlFilePath Destination:path];
            return ;
        }
        else
        {
            JMLog(@"%@",error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网页数据下载失败，请重启软件程序！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alert show];
        }
    }];
    [downloadTask resume];
}
#pragma mark 解压
//把压缩包数据解压到本地后，要想加载出来，必须把document数据复制到Preferences文件夹
/*
 第一个参数:要解压的文件在哪里
 第二个参数:文件应该解压到什么地方
 */
- (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath
{
    JMLog(@"压缩文件存在的位置======zipPath==%@==",zipPath);
    JMLog(@"解压到的位置==========unzipPath==%@==",unzipPath);

    NSError *error;
    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath overwrite:YES password:nil error:&error delegate:self])
    {
        NSString *path = [unzipPath stringByAppendingString:@"/public"];
        JMLog(@"path===%@=====",path);
        NSFileManager *fileManager1 = [NSFileManager defaultManager];
        NSString *tmpPath2 = NSTemporaryDirectory();
        JMLog(@"tmpPath2===%@=====",tmpPath2);

        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/public",tmpPath2]])
        {
            [fileManager1 removeItemAtPath:[NSString stringWithFormat:@"%@public",tmpPath2] error:nil];
        }
        [fileManager1 copyItemAtPath:[NSString stringWithFormat:@"%@/public",path] toPath:[NSString stringWithFormat:@"%@public",tmpPath2] error:nil];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self loadWebData];
        JMLog(@"解压缩成功！");
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"解压数据失败，请重启软件程序！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
}

- (void)loadWebData
{
    NSArray *LibraryArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *CachesPath = [[LibraryArray lastObject] stringByAppendingPathComponent:@"Preferences"];
    NSString *indexPath = [CachesPath stringByAppendingPathComponent:@"/hybrid/gerenzhongxin/gerenzhuye2.html"];
    NSURL *loadurl =[NSURL fileURLWithPath:indexPath];//fileURLWithPath后面跟的是文件目录不需要file:///
    JMLog(@"loadurl==%@==",loadurl);

    //创建访问权限URL
    NSString *accessURLStr = [[[LibraryArray lastObject] stringByAppendingPathComponent:@"Preferences"] stringByAppendingPathComponent:@""];

    NSURL *accessURL = [NSURL fileURLWithPath:accessURLStr];
    JMLog(@"如果readAccessURL引用一个目录，WebKit可能会加载该文件中的文件accessURL==%@==",accessURL);

    //第三步：进行加载
    /*
     要导航到的文件URL。
     允许读取访问的URL。
     如果readAccessURL引用单个文件，WebKit只能加载该文件。
     如果readAccessURL引用一个目录，WebKit可能会加载该文件中的文件。
     */
    [self.myweb loadFileURL:loadurl allowingReadAccessToURL:accessURL];
//    [self.myweb loadRequest:[NSURLRequest requestWithURL:loadurl]];

}
//加载本地沙盒目录下的index.html（本地沙盒目录指这几个：Library/Preferences、Library/Caches、Documents）
-(void)loadWebData1
{
    NSArray *LibraryArray =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *CachesPath = [[LibraryArray lastObject] stringByAppendingPathComponent:@"Preferences"];
    NSString *indexPath = [NSString stringWithFormat:@"file://%@/hybrid/gerenzhongxin/gerenzhuye2.html",CachesPath];
    NSURL * accessUrl = [[NSURL URLWithString:indexPath] URLByDeletingLastPathComponent];
    NSURL * loadurl = [NSURL URLWithString:indexPath];
    JMLog(@"HTML文件所在的位置=====loadurl==%@==",loadurl);

    JMLog(@"如果readAccessURL引用一个目录，WebKit可能会加载该文件中的文件accessURL==%@==",accessUrl);
    
    [self.myweb loadFileURL:loadurl allowingReadAccessToURL:accessUrl];
}
//当wkwebview总体的内存占用过大的时候，页面即将白屏，就会调用当前函数,再就是配合vc的viewwillapper方法，执行reload方法，基本就可以解决白屏的问题
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    [webView reload];
}


@end





////  SXWMememeWebViewController.m
////  SXWDemo
////
////  Created by JM001 on 2019/1/22.
////  Copyright © 2019 Xiaopoxi. All rights reserved.
////
//
//#import "SXWMememeWebViewController.h"
//#import <WebKit/WebKit.h>
//
//@interface SXWMememeWebViewController ()<WKNavigationDelegate,WKUIDelegate>
//
//@property (nonatomic, strong) WKWebView * wkWebView;
//@property (nonatomic, strong) UIProgressView * progressView;
//
//@end
//
//@implementation SXWMememeWebViewController
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.title = @"微博网页";
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self addSubViews];
//}
//- (void)addSubViews
//{
//
//
//
//    if (@available(iOS 9.0, *))
//    {
//        NSSet * websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
//        NSDate * dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
//        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//        }];
//    }
//    self.view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6];
//    //进度条初始化
//    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1,kScreenWidth, 2)];
//    self.progressView.trackTintColor = JMColor(245, 245, 245);
//    self.progressView.progressTintColor = JMColor(245, 75, 91);
//    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
//    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
//    [self.view addSubview:self.progressView];
//    self.progressView.progress = 0.1;
//    self.progressView.hidden = NO;
//
//    //    self.wkWebView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.wkWebView = [[WKWebView alloc] init];
//    self.wkWebView.backgroundColor = [UIColor clearColor];
//    self.wkWebView.UIDelegate = self;
//    self.wkWebView.navigationDelegate = self;
//    // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
//    [self.wkWebView setAllowsBackForwardNavigationGestures:true];
//    [self.view addSubview:self.wkWebView];
//    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(self.view.mas_top);
//        make.bottom.equalTo(self.view.mas_bottom).offset(64);
//    }];
//    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    NSString * str = [NSString stringWithFormat:@"%@",@"https://www.baidu.com/"];
//    NSURL * url = [NSURL URLWithString:str];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [self.wkWebView loadRequest:request];
//
//}
//
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"estimatedProgress"])
//    {
//        self.progressView.progress = self.wkWebView.estimatedProgress;
//        if (self.progressView.progress == 1)
//        {
//            /*
//             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
//             *动画时长0.25s，延时0.3s后开始动画
//             *动画结束后将progressView隐藏
//             */
//            WeakSelf(weakSelf);
//            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
//            } completion:^(BOOL finished)
//             {
//                 weakSelf.progressView.hidden = YES;
//             }];
//        }
//    }
//    else
//    {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//
////开始加载
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
//{
//    JMLog(@"开始加载网页");
//    //开始加载网页时展示出progressView
//    self.progressView.hidden = NO;
//    //开始加载网页的时候将progressView的Height恢复为1.5倍
//    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
//    //防止progressView被网页挡住
//    [self.view
//     bringSubviewToFront:self.progressView];
//}
//
////加载完成
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
//{
//    JMLog(@"加载完成");
//    //加载完成后隐藏progressView
//    self.progressView.hidden = YES;
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
//{
//    JMLog(@"加载失败");
//    //加载失败同样需要隐藏progressView
//    self.progressView.hidden = YES;
//    //    [ZHWarnView showError:@"加载失败"];
//}
//
////当wkwebview总体的内存占用过大的时候，页面即将白屏，就会调用当前函数,再就是配合vc的viewwillapper方法，执行reload方法，基本就可以解决白屏的问题
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
//{
//    [webView reload];
//}
//
//- (void)dealloc
//{
//    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
//}
//
//
//
////- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
////{
////    self.view1 = [[ShoppingCartChangeGoodsAttributeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1040 *kScale)];
////    [self.view1 showView];
////}
//
//
//
//@end
