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
        itemCreateDate = [NSDate date];
        NSLog(@"%@", itemCreateDate);
    }
    return self;
}

- (void)addItem:(NSString *)itemT ToFile:(NSString *)fileName
{
    [itemTitle addObject:itemT];
    [itemTitle writeToFile:fileName atomically:YES];
    
}

@end
