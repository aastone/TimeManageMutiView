//
//  TMItemModel.h
//  TimeManageMutiView
//
//  Created by stone on 7/4/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMItemModel : NSObject


//@property (nonatomic, strong) NSMutableArray *itemTitle;
@property (nonatomic, strong) NSMutableSet *itemDate;
//@property (nonatomic, strong) NSMutableArray *itemCreateTime;
@property (nonatomic, strong) NSMutableArray *taskStartTime;
@property (nonatomic, strong) NSMutableArray *taskEndTime;

@property (nonatomic, strong) NSString *tmp;

@property (nonatomic, strong) NSDictionary *itemsDictionary;
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) NSMutableArray *countRowsArray;

@property (nonatomic, strong) NSString *itemTitleString;
@property (nonatomic, strong) NSString *itemCreateDateString;
@property (nonatomic, strong) NSString *itemCreateTimeString;
@property (nonatomic, strong) NSString *taskStartTimeString;
@property (nonatomic, strong) NSString *taskEndTimeString;
@property (nonatomic, strong) NSString *taskStatusString;


// 增加新的item 自动保存到plist文件中
- (void)addItem:(NSString *)itemTitle ToFile:(NSString *)fileName;

- (NSString *)currentTimeString;

@end
