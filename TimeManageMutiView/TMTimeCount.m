//
//  TMTimeCount.m
//  TimeManageMutiView
//
//  Created by stone on 6/13/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMTimeCount.h"

@implementation TMTimeCount

@synthesize minuteValue, secondValue, countdownValue;

+ (TMTimeCount *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TMTimeCount *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[TMTimeCount alloc] init];
    });
    return sSharedInstance;
}

- (NSInteger)setCountDownValue:(BOOL)isCountingDown
{
    if (isCountingDown) {
        return countdownValue;
    }else{
        return countdownValue;
    }
}



@end
