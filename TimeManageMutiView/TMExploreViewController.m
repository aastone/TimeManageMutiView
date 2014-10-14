//
//  TMExploreViewController.m
//  TimeManageMutiView
//
//  Created by stone on 5/25/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMExploreViewController.h"
#import "RDVTabBarController.h"

@implementation TMExploreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Contact";

    }
    return self;
}

- (void)loadView
{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
    
    [wv setScalesPageToFit:YES];
    [self setView:wv];
}

- (UIWebView *)webView
{
    return (UIWebView *)[self view];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [NSURL URLWithString:@"http://sasoriforstone.sinaapp.com/"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"advice" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    NSLog(@"error");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finish");
}

@end
