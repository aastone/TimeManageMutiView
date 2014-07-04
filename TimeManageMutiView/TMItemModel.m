//
//  TMItemModel.m
//  TimeManageMutiView
//
//  Created by stone on 7/4/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMItemModel.h"

@implementation TMItemModel

@synthesize itemTitle, itemCreateDate, itemCreateTime;

- (id)init
{
    self = [super init];
    if (self) {
        itemTitle = [[NSMutableArray alloc] init];
        itemCreateDate = [[NSMutableArray alloc] init];
        itemCreateTime = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addItem:(NSString *)itemT ToFile:(NSString *)fileName
{
    [itemTitle addObject:itemT];
    [itemTitle writeToFile:fileName atomically:YES];
    
    // add Time
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:@"yyyy-MM-dd"];
    [formatterTime setDateFormat:@"HH:mm:ss"];
    
    NSString *currentDate = [formatterDate stringFromDate:date];
    NSString *currentTime = [formatterTime stringFromDate:date];
    
    [itemCreateDate addObject:currentDate];
    [itemCreateTime addObject:currentTime];
    
}

@end
