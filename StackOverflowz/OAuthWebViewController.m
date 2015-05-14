//
//  OAuthWebViewController.m
//  StackOverflowz
//
//  Created by Brandon Roberts on 5/13/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "OAuthWebViewController.h"
#import <WebKit/WebKit.h>

@interface OAuthWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation OAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:self.webView];
  self.webView.navigationDelegate = self;
  
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?client_id=3197&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success"]];
  [self.webView loadRequest:request];
  
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  
  NSURLRequest *request = navigationAction.request;
  NSURL *url = request.URL;
  NSLog(@"URL: %@", url);

  
  
  
  
  decisionHandler(WKNavigationActionPolicyAllow);
}



@end
