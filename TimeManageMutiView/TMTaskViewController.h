//
//  TMTaskViewController.h
//  TimeManagerStoryboard
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMItemCell.h"
#import "TMDetailViewController.h"

@class TMItemModel;

@interface TMTaskViewController : UIViewController<JZSwipeCellDelegate, TMDetailViewControllerDelegate>
{
    NSString *passData;
    NSString *passTime;
    TMItemModel *item;
}

@property (nonatomic, strong) NSString *rrrrr;
@end
