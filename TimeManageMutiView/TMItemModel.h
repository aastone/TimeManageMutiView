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
@property (nonatomic, strong) NSMutableArray *itemCreateDate;
@property (nonatomic, strong) NSMutableArray *itemCreateTime;


// 增加新的item 自动保存到plist文件中
- (void)addItem:(NSString *)itemTitle ToFile:(NSString *)fileName;


@end
