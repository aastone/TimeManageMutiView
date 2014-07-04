//
//  TMItemModel.h
//  TimeManageMutiView
//
//  Created by stone on 7/4/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMItemModel : NSObject

@property (nonatomic, strong) NSMutableArray *itemTitle;
@property (nonatomic, strong) NSDate *itemCreateDate;
@property (nonatomic, strong) NSMutableString *itemCreateTime;

- (void)addItem:(NSString *)itemTitle ToFile:(NSString *)fileName;

@end
