//
//  TMItemModel.m
//  TimeManageMutiView
//
//  Created by stone on 7/4/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMItemModel.h"

@implementation TMItemModel
{
    NSString *fileName;
}

//@synthesize itemTitle, itemCreateDate, itemCreateTime;
@synthesize itemDate ,taskEndTime, taskStartTime;
@synthesize itemsDictionary, tmp, itemsArray, countRowsArray;
@synthesize itemCreateDateString, itemCreateTimeString, itemTitleString, taskEndTimeString, taskStartTimeString, taskStatusString;

- (id)init
{
    self = [super init];
    if (self) {
//        itemTitle = [[NSMutableArray alloc] init];
//        itemCreateDate = [[NSMutableSet alloc] init];
//        itemCreateTime = [[NSMutableArray alloc] init];
//        
        taskStartTime = [[NSMutableArray alloc] init];
        taskEndTime = [[NSMutableArray alloc] init];
        
        itemsArray = [[NSMutableArray alloc] init];
        
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSLog(@"path = %@",path);
        fileName =[path stringByAppendingPathComponent:@"dicTest.plist"];
        NSMutableArray *plistArray = [NSMutableArray arrayWithContentsOfFile:fileName];
        
        if (plistArray) {
            [self setItemsArray:[NSMutableArray arrayWithArray:plistArray]];
        }else{
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:fileName contents:nil attributes:nil];
        }
        
//        [self sectionMethod];
        
//        [self rowsInSectionMethod];
        
//        itemsDictionary = [[NSMutableDictionary alloc] ini]
    }
    return self;
}

- (NSDictionary *)itemsDictionary
{
    NSArray *models = @[@"itemTitle", @"itemCreateDate",
                        @"itemCreateTime", @"taskStartTime", @"taskEndTime", @"taskStatus"];
    NSArray *stock = @[itemTitleString,
                       itemCreateDateString,
                       itemCreateTimeString,
                       taskStartTimeString,
                       taskEndTimeString,
                       taskStatusString];
    
    itemsDictionary = [NSDictionary dictionaryWithObjects:stock forKeys:models];
    
    return itemsDictionary;
}

- (void)addItem:(NSString *)itemT ToFile:(NSString *)fileNameL
{
    
    itemTitleString = [NSString stringWithString:itemT];
    itemCreateDateString = [NSString stringWithString:[self currentDateString]];
    itemCreateTimeString = [NSString stringWithString:[self currentTimeString]];
    taskStartTimeString = [[NSString alloc] init];
    taskEndTimeString = [[NSString alloc] init];
    taskStatusString = [[NSString alloc] init];

    [itemsArray addObject:[self itemsDictionary]];
    [itemDate addObject:[itemsDictionary valueForKey:@"itemCreateDate"]];
    
    [itemsArray writeToFile:fileName atomically:YES];
    NSLog(@"%@", [[itemsArray objectAtIndex:0] valueForKey:@"itemTitle"]);
//    [itemTitle addObject:itemTitleString];
//    [itemTitle writeToFile:fileNameL atomically:YES];
    
//    [itemCreateDate addObject:[self currentDateString]];
//    [itemCreateTime addObject:[self currentTimeString]];
    
}

- (NSString *)currentDateString
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDate = [formatterDate stringFromDate:date];
    return currentDate;
}

- (NSString *)currentTimeString
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc] init];
    [formatterTime setDateFormat:@"HH:mm:ss"];
    
    NSString *currentTime = [formatterTime stringFromDate:date];
    
    return currentTime;
}

//- (NSMutableSet *)itemCreateDate
//{
//    itemCreateDate = [itemsDictionary valueForKey:@"itemCreateDate"];
//    return itemCreateDate;
//}


#pragma mark - Plist

- (NSString *)plistFile
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    fileName =[path stringByAppendingPathComponent:@"dicTest.plist"];
    NSMutableArray *plistArray = [NSMutableArray arrayWithContentsOfFile:fileName];
    
    if (plistArray) {
        [self setItemsArray:[NSMutableArray arrayWithArray:plistArray]];
    }else{
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:fileName contents:nil attributes:nil];
    }
    return fileName;
}

/*

- (void)sectionMethod
{
    itemDate = [[NSMutableSet alloc] init];
    [itemDate addObjectsFromArray:[[self itemsArray] valueForKey:@"itemCreateDate"]];
    
    NSLog(@"sectionMethod %@", itemDate);
}

- (void)rowsInSectionMethod
{
    countRowsArray = [[NSMutableArray alloc] initWithCapacity:[itemDate count]];
    int j = 0;
    for (int i = 0; i < [itemDate count]; i++) {
        [countRowsArray insertObject:@"0" atIndex:i];
        if ([itemDate count] == 1) {
            [countRowsArray[i] addObject:[NSNumber numberWithInt:[itemsArray count]]];
        }else {
            int countRows = 0;
            while (j < [itemsArray count]) {
                if (j+1 < [itemsArray count]) {
                    NSString *tmpString = [NSString stringWithString:[[itemsArray objectAtIndex:j + 1] objectForKey:@"itemCreateDate"]];
                    NSString *tmpString2 = [NSString stringWithString:[[itemsArray objectAtIndex:j] objectForKey:@"itemCreateDate"]];
                    j ++;
                    if ([tmpString isEqualToString:tmpString2]) {                        countRows++;
//                        countRowsArray[i] = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:(countRows+1)]];
                        [countRowsArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:(countRows+1)]];
                    }else{
//                        countRowsArray[i] = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:(countRows+1)]];
                        [countRowsArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:(countRows+1)]];
                        countRows = 0;
                        i++;
                        [countRowsArray insertObject:@"0" atIndex:i];
                    }
                }else {
//                    countRowsArray[i] = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:(countRows+1)]];
                    [countRowsArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:(countRows+1)]];
                    i++;
                    j++;
                }
            }
        }
    }
}

- (NSMutableArray *)countRowsArray
{
    return countRowsArray;
}

*/




@end
