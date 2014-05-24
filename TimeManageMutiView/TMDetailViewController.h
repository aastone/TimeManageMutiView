//
//  TMDetailViewController.h
//  TimeManager
//
//  Created by stone on 14-3-23.
//  Copyright (c) 2014年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMDetailViewController;

@protocol TMDetailViewControllerDelegate <NSObject>

- (void)addItemViewController: (TMDetailViewController *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface TMDetailViewController : UIViewController

@property (nonatomic) BOOL isSomethingEnabled;

@property (nonatomic, weak) id <TMDetailViewControllerDelegate> delegate;

@property (retain, nonatomic) NSMutableArray *listArray;

@property (weak, nonatomic) IBOutlet UILabel *timeCount;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
- (IBAction)clickAction:(id)sender;

- (IBAction)addMinute:(id)sender;
- (IBAction)reduceMinute:(id)sender;
@end
