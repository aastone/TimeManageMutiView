//
//  TMSettingViewController.h
//  TimeManager
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMSettingViewControllerDelegate <NSObject>

- (void)clicked:(NSString *)value;

@end

@interface TMSettingViewController : UIViewController

@property (nonatomic, weak) id <TMSettingViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;

@end
