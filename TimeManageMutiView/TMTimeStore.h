//
//  TMTimeStore.h
//  TimeManageMutiView
//
//  Created by stone on 7/4/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTimeStore : NSObject

+ (TMTimeStore *)sharedStore;

@property (strong, nonatomic) NSMutableString *timeCountingValue;

@property (nonatomic) NSInteger secondCountDown;
@property (nonatomic) NSInteger minuteCountDown;

- (void)regexTimeCount:(NSString *)timeLabelValue;
//- (void)timeFireMethod:

@end
