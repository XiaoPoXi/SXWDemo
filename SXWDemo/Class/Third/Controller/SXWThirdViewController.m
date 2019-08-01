//
//  SXWThirdViewController.m
//  SXWDemo
//
//  Created by JM001 on 2018/12/26.
//  Copyright © 2018 Xiaopoxi. All rights reserved.
//

#import "SXWThirdViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JWCacheURLProtocol.h"

@interface SXWThirdViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * wkWebView;
@property (nonatomic, strong) UIProgressView * progressView;


@end

@implementation SXWThirdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [JWCacheURLProtocol startListeningNetWorking];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的";
    [self addSubViews];
    
    //创建button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 200, 80, 50);
    [btn setTitle:@"调用JS事件" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}
/*
 原生调用h5测试方法:callh5("alt",json格式数据)
 */

//button点击事件
- (void)btnClick
{
    //调用JS函数
    /*
     alt(88888) alt是js定义的方法   888是传递的参数 传递到js   '{"name":"xiaoming"}'
     **/
//    NSString * jsStr = [NSString stringWithFormat:@"callh5('%@')",@""];
    NSString *jscript1 = [NSString stringWithFormat:@"callh5('%@','{%@}');", @"alt", @"\"username\":\"xiaoming\",\"password\":\"123456\""];
    ;
    JMLog(@"%@",jscript1);
    [self.wkWebView evaluateJavaScript:jscript1 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}

- (void)addSubViews
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
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    /**
     设置代理对象
     ScriptMessageHandler:WKScriptMessageHandler的代理对象
     name:跟后端协调好的响应名称
     **/
    [config.userContentController addScriptMessageHandler:self name:@"pipeline"];
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.wkWebView.backgroundColor = [UIColor clearColor];
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
    [self.wkWebView setAllowsBackForwardNavigationGestures:true];
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(64);
    }];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSString * str = [NSString stringWithFormat:@"%@",@"http://192.168.8.35/hybrid/gerenzhongxin/gerenzhuye2.html"];
    NSURL * url = [NSURL URLWithString:str];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    
}

/*
 接受js传递的事件
 **/
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message
{
    JMLog(@"----%@----",message.body);

    if ([message.body isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *messageDic = message.body;
        
        JMLog(@"----%@----",messageDic);
        //跳转控制器A
        JMLog(@"111111");
    }
    
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
    JMLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
    //    [ZHWarnView showError:@"加载失败"];
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


////
////  SXWThirdViewController.m
////  SXWDemo
////
////  Created by JM001 on 2018/12/26.
////  Copyright © 2018 Xiaopoxi. All rights reserved.
////
//
//#import "SXWThirdViewController.h"
//#import "WKWebViewJavascriptBridge.h"
//#import <WebKit/WebKit.h>
//
//
//@interface SXWThirdViewController ()<WKNavigationDelegate>
//
//@property WKWebViewJavascriptBridge* bridge;
//@property WKWebView *webview;
//
//@end
//
//@implementation SXWThirdViewController
//
//-(void)restart{
//    [self viewDidAppear:true];
//}
//
//
//- (void)viewDidAppear:(BOOL)animated {
//    if (_bridge) {
//        _bridge = nil;
//        //每次显示这个页面的时候都初始化。
//        self.webview = nil;
//    }
//
//    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
//    webView.backgroundColor = [UIColor greenColor];
//    webView.navigationDelegate = self;
//    self.webview = webView;
//    [self.view addSubview:webView];
//    [WKWebViewJavascriptBridge enableLogging];
//    //做一些初始化工作。并且换回一个bridge
//    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
//    //设置bridge对应的webview的delegate
//    [_bridge setWebViewDelegate:self];
//
//    [_bridge registerHandler:@"OC提供方法给JS调用" handler:^(id data, WVJBResponseCallback responseCallback) {
//        //NSLog(@"testObjcCallback called: %@", data);
//        responseCallback(@"OC发给JS的返回值");
//    }];
//
//
//    [self renderButtons:webView];
//
//    [self loadExamplePage:webView];
//}
//
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"webViewDidStartLoad");
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"webViewDidFinishLoad");
//}
//
//- (void)renderButtons:(WKWebView*)webView {
//    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
//
//    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [callbackButton setTitle:@"点击OC调用JS" forState:UIControlStateNormal];
//    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view insertSubview:callbackButton aboveSubview:webView];
//    callbackButton.frame = CGRectMake(10, 400, 100, 35);
//    callbackButton.titleLabel.font = font;
//
//    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [reloadButton setTitle:@"重新开始" forState:UIControlStateNormal];
//    [reloadButton addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
//    [self.view insertSubview:reloadButton aboveSubview:webView];
//    reloadButton.frame = CGRectMake(110, 400, 100, 35);
//    reloadButton.titleLabel.font = font;
//}
//
//- (void)callHandler:(id)sender {
//    id data = @{ @"OC调用JS方法": @"OC调用JS方法的参数" };
//    [_bridge callHandler:@"OC调用JS提供的方法" data:data responseCallback:^(id response) {
//        // NSLog(@"testJavascriptHandler responded: %@", response);
//    }];
//}
//
//- (void)loadExamplePage:(WKWebView*)webView {
////    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
////    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
////    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
////    [webView loadHTMLString:appHtml baseURL:baseURL];
//    NSString * str = [NSString stringWithFormat:@"%@",@"http://192.168.8.67:8085/ExampleApp.html"];
//    NSURL * url = [NSURL URLWithString:str];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//}
//
//@end
