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

- (NSInteger)setCountDownValue:(BOOL)isCountingDown
{
    if (isCountingDown) {
        return countdownValue;
    }else{
        return countdownValue;
    }
}



@end
