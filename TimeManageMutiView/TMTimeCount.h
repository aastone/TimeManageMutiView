//
//  TMTimeCount.h
//  TimeManageMutiView
//
//  Created by stone on 6/13/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTimeCount : NSObject

@property (nonatomic) BOOL isCountingDown;
@property (nonatomic) NSInteger countdownValue;
@property (nonatomic) NSInteger minuteValue;
@property (nonatomic) NSInteger secondValue;

- (void)setCountDownValue:(BOOL)isCountingDown;

@end
