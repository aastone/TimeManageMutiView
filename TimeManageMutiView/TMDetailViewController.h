//
//  TMDetailViewController.h
//  TimeManager
//
//  Created by stone on 14-3-23.
//  Copyright (c) 2014年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMDetailViewController;
@class TMItemModel;

@protocol TMDetailViewControllerDelegate <NSObject, UINavigationControllerDelegate>

- (void)addItemViewController: (TMDetailViewController *)controller didFinishEnteringItem:(NSString *)item;

- (NSString *)sharedInfo;

@end

typedef enum{
    TMClickButtonStatusUnStarted,
    TMClickButtonStatusPaused,
    TMClickButtonStatusCounting,
    TMClickButtonStatusCompleted
}TMClickButtonStatus;

@interface TMDetailViewController : UIViewController
{
    TMItemModel *task;
    TMClickButtonStatus buttonStatus;
}

@property (nonatomic) BOOL isSomethingEnabled;

@property (nonatomic, weak) id <TMDetailViewControllerDelegate> delegate;

@property (retain, nonatomic) NSMutableArray *listArray;

@property (weak, nonatomic) IBOutlet UILabel *timeCount;
@property (strong, nonatomic) NSMutableString *timeCountValue;

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
- (IBAction)clickAction:(id)sender;

- (IBAction)addMinute:(id)sender;
- (IBAction)reduceMinute:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addMinuteButton;
@property (weak, nonatomic) IBOutlet UIButton *reduceMinuteButton;
- (IBAction)dropTask:(id)sender;
- (IBAction)keepLightOn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@end
