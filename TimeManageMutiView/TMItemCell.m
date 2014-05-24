//
//  TMItemCell.m
//  TimeManager
//
//  Created by stone on 14-3-18.
//  Copyright (c) 2014年 stone. All rights reserved.
//

#import "TMItemCell.h"

@implementation TMItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		// set the 4 icons for the 4 swipe types
		self.imageSet = SwipeCellImageSetMake([UIImage imageNamed:@"pac-man"], [UIImage imageNamed:@"blinky"], [UIImage imageNamed:@"ice-cream"], [UIImage imageNamed:@"balloons"]);
		self.colorSet = SwipeCellColorSetMake([UIColor greenColor], [UIColor redColor], [UIColor brownColor], [UIColor orangeColor]);
    }
    return self;
}

+ (NSString*)cellID
{
	return @"ExampleCell";
}

@end
