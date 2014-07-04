//
//  TMAppDelegate.h
//  TimeManageMutiView
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSettingViewController.h"
#import "TMTaskViewController.h"
#import "TMExploreViewController.h"

@interface TMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
