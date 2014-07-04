//
//  TMTaskViewController.h
//  TimeManagerStoryboard
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMItemCell.h"
//#import "TMItemModel.h"
#import "TMDetailViewController.h"

@interface TMTaskViewController : UIViewController<JZSwipeCellDelegate, TMDetailViewControllerDelegate>
{
    NSString *passData;
    NSString *passTime;
}
@end
