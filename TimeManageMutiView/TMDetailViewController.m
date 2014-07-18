//
//  TMDetailViewController.m
//  TimeManager
//
//  Created by stone on 14-3-23.
//  Copyright (c) 2014年 stone. All rights reserved.
//

#import "TMDetailViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "TMTimeStore.h"
#import "TMItemModel.h"
#import "AHKActionSheet.h"

@interface TMDetailViewController () <UIAlertViewDelegate>
{
    NSTimer *countDownTimer;
    BOOL isCountingDown;
}

@end

@implementation TMDetailViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"TMDetailViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    task = [[TMItemModel alloc] init];
    
    NSLog(@"-----%@", [task tmp]);
    
    self.timeCount.text = @"1 min";
    self.timeCountValue = [NSMutableString stringWithString:self.timeCount.text];
    
    self.itemLabel.text = self.listArray[0]; //label 上呈现的东西，名字可以改下~
    buttonStatus = TMClickButtonStatusUnStarted;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Click Action

- (IBAction)clickAction:(id)sender {
    
    if(buttonStatus == TMClickButtonStatusPaused){
//        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        [self.clickBtn setTitle:[NSString stringWithFormat:@"Continue"] forState:UIControlStateNormal];
        [countDownTimer invalidate];
        buttonStatus = TMClickButtonStatusCounting;
    }else if(buttonStatus == TMClickButtonStatusCompleted){
        
    }else {
        if (buttonStatus == TMClickButtonStatusUnStarted) {
            [[self addMinuteButton] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [[self reduceMinuteButton] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [[self navigationController] setNavigationBarHidden:YES animated:YES];
            
            [[task taskStartTime] addObject:[NSMutableString stringWithString:[task currentTimeString]]];
            self.startTimeLabel.text = [NSString stringWithString:[task taskStartTime][0]];
        }
        [self.clickBtn setTitle:[NSString stringWithFormat:@"Pause"] forState:UIControlStateNormal];
            
        if ([TMTimeStore sharedStore].secondCountDown) {
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }else{
            [self regexForTimeCount];
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }
        buttonStatus = TMClickButtonStatusPaused;
    }
}

- (IBAction)addMinute:(id)sender {
    if ([self.clickBtn.titleLabel.text isEqualToString:[NSString stringWithFormat:@"Start"]]) {
        [self regexForTimeCount];
        [TMTimeStore sharedStore].minuteCountDown++;
        self.timeCount.text = [NSString stringWithFormat:@"%ld min", (long)[[TMTimeStore sharedStore] minuteCountDown]];
    }
}

- (IBAction)reduceMinute:(id)sender {
    if ([self.clickBtn.titleLabel.text isEqualToString:[NSString stringWithFormat:@"Start"]]) {
        [self regexForTimeCount];
        if ([TMTimeStore sharedStore].minuteCountDown != 1) {
            [TMTimeStore sharedStore].minuteCountDown--;
        }
        self.timeCount.text = [NSString stringWithFormat:@"%ld min", (long)[TMTimeStore sharedStore].minuteCountDown];
    }
}

- (void)regexForTimeCount
{
    [[TMTimeStore sharedStore] regexTimeCount:self.timeCount.text];
}

- (void)timeFireMethod
{
    self.timeCount.text = [NSString stringWithString:[[TMTimeStore sharedStore] timeFireMethod:self.timeCount.text With:countDownTimer]];
    NSLog(@"%@", self.timeCount.text);
    if ([self.timeCount.text isEqualToString:@"0 min 0 s"]) {
        buttonStatus = TMClickButtonStatusCompleted;
        
        [[task taskEndTime] addObject:[NSMutableString stringWithString:[task currentTimeString]]];
        self.endTimeLabel.text = [NSString stringWithString:[task taskEndTime][0]];
        
        [self completedAction];
        
    }
    
    [self.delegate addItemViewController:self didFinishEnteringItem:self.timeCountValue];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    [self.delegate addItemViewController:self didFinishEnteringItem:self.timeCountValue];
    [countDownTimer invalidate];
}

#pragma mark - Alter View

- (IBAction)dropTask:(id)sender
{
    UIAlertView *dropTaskAlterView = [[UIAlertView alloc] initWithTitle:@"Leave ?"
                                                        message:@"are u sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
    [dropTaskAlterView show];
}

- (IBAction)keepLightOn:(id)sender
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else {
        [[self navigationController] setNavigationBarHidden:NO animated:NO];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark - Action Sheet

- (void)completedAction
{
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"Controgulations! You completed your task!", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Redo", nil)
                              image:[UIImage imageNamed:@"Icon1"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Info tapped");
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Back to Home", nil)
                              image:[UIImage imageNamed:@"Icon2"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Favorite tapped");
                                [[self navigationController] setNavigationBarHidden:NO animated:NO];
                                [[self navigationController] popViewControllerAnimated:YES];
                            }];
    
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share", nil)
//                              image:[UIImage imageNamed:@"Icon3"]
//                               type:AHKActionSheetButtonTypeDefault
//                            handler:^(AHKActionSheet *as) {
//                                NSLog(@"Share tapped");
//                            }];
//    
//    [actionSheet addButtonWithTitle:NSLocalizedString(@"Delete", nil)
//                              image:[UIImage imageNamed:@"Icon4"]
//                               type:AHKActionSheetButtonTypeDestructive
//                            handler:^(AHKActionSheet *as) {
//                                NSLog(@"Delete tapped");
//                            }];
    
    [actionSheet show];
}




















@end
