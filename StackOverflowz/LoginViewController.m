//
//  LoginViewController.m
//  StackOverflowz
//
//  Created by Brandon Roberts on 5/13/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

#import "LoginViewController.h"
#import "OAuthWebViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginButtonPressed:(id)sender {
  
  OAuthWebViewController *webView = [[OAuthWebViewController alloc] init];
  [self presentViewController:webView animated:YES completion:^{
    
  }];
  
}

@end
