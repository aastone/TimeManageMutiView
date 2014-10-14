//
//  TMCommonDelegate.m
//  TimeManageMutiView
//
//  Created by stone on 10/14/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMCommonDelegate.h"
@implementation TMCommonDelegate

- (id)init
{
    self = [super init];
    TMSettingViewController *vc = [[TMSettingViewController alloc] init];
    vc.delegate = self;
    return self;
}

- (void)clicked:(NSString *)value
{
    NSLog(@"clicked");
}

@end
