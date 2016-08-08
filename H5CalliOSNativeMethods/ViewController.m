//
//  ViewController.m
//  H5CalliOSNativeMethods
//
//  Created by demin on 16/8/8.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"h5" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:html baseURL:nil];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法，getOrderInfo就是调用的getOrderInfo方法名
    context[@"getOrderInfo"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是OC原生的弹出窗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        for (JSValue *jsVal in args) {
            NSLog(@"%@",jsVal.toString);
        }
        NSLog(@"-------End Log-------");
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
