//
//  TMViewController.h
//  TimeManageMutiView
//
//  Created by stone on 6/10/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateTabbar.h"

@interface TMViewController : UIViewController<AnimateTabbarDelegate>

@property (nonatomic, strong) UIView *childView;

@end
