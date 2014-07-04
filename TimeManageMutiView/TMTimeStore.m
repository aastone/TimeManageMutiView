//
//  TMTimeStore.m
//  TimeManageMutiView
//
//  Created by stone on 7/4/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMTimeStore.h"

@implementation TMTimeStore

@synthesize timeCountingValue, secondCountDown, minuteCountDown;

+ (TMTimeStore *)sharedStore
{
    static TMTimeStore *timeStore = nil;
    if (!timeStore) {
        timeStore = [[TMTimeStore alloc] init];
    }
    return timeStore;
}


- (void)regexTimeCount:(NSString *)timeLabelValue
{
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:timeLabelValue options:0 range:NSMakeRange(0, [timeLabelValue length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result = [timeLabelValue substringWithRange:resultRange];
            [self setMinuteCountDown:[result intValue]];
            [self setSecondCountDown:[self minuteCountDown] * 60];
        }
    }
}

@end
