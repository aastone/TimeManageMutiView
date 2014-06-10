//
//  TMViewController.m
//  TimeManageMutiView
//
//  Created by stone on 6/10/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMViewController.h"
#import "TMTaskViewController.h"
#import "TMExploreViewController.h"

@interface TMViewController ()

@end

@implementation TMViewController

UIViewController *firstViewController;
UIViewController *secondViewController;
UIViewController *currentViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AnimateTabbarView *tabBar = [[AnimateTabbarView alloc] initWithFrame:self.view.frame];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    
    firstViewController = [[TMTaskViewController alloc] initWithNibName:@"TMTaskViewController" bundle:nil];
    [self addChildViewController:firstViewController];
    
    secondViewController = [[TMExploreViewController alloc] initWithNibName:@"TMExploreViewController" bundle:nil];
    [self addChildViewController:secondViewController];
    
    [self.childView addSubview:firstViewController.view];
    currentViewController = firstViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// callback
int g_flags=1;
-(void)FirstBtnClick{
    
    if(g_flags==1)
        return;
    [self transitionFromViewController:currentViewController toViewController:firstViewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        currentViewController=firstViewController;
        g_flags=1;
        
    }];
}
-(void)SecondBtnClick{
    if(g_flags==2)
        return;
    [self transitionFromViewController:currentViewController toViewController:secondViewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        currentViewController=secondViewController;
        g_flags=2;
        
    }];
    
}
-(void)ThirdBtnClick{
    //BarView.text=@"third";
}
-(void)FourthBtnClick{
    //BarView.text=@"fourth";
}

@end
