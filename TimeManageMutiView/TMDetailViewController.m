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

@interface TMDetailViewController () <UITextFieldDelegate>
{
    NSTimer *countDownTimer;
    BOOL buttonStatus;
    BOOL isCountingDown;
    UITextField *ifield;
    
    NSString *aiyou;
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
    
//    NSString *itemToPassBack = @"pass back";
//    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
    
    //判断是否在倒计时,需要告诉另外
    
    if (self.timeCountValue) {
        self.timeCount.text = self.timeCountValue;
        buttonStatus = YES;
        if (buttonStatus) {
            [self.clickBtn setTitle:[NSString stringWithFormat:@"Pause"] forState:UIControlStateNormal];
            
            if ([TMTimeStore sharedStore].secondCountDown) {
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            }else{
                [self regexForTimeCount];
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            }
            buttonStatus = NO;
        }
    }else{
        if (self.timeCountValue) {
            self.timeCount.text = self.timeCountValue;
        }else{
            self.timeCount.text = @"1 min";
            self.timeCountValue = [NSMutableString stringWithString:self.timeCount.text];
        }
    }
    
    // click action init
    self.startTime.text = self.listArray[0]; //label 上呈现的东西，名字可以改下~
    buttonStatus = YES;
    
    //textfield init
    [self textFieldInit];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tap Gesture

- (void)viewTapped
{
    [self.textField resignFirstResponder];
}

#pragma mark - Click Action

- (IBAction)clickAction:(id)sender {
    if (buttonStatus) {
        [self.clickBtn setTitle:[NSString stringWithFormat:@"Pause"] forState:UIControlStateNormal];
        
        if ([TMTimeStore sharedStore].secondCountDown) {
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }else{
            [self regexForTimeCount];
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }
        buttonStatus = NO;
    }else{
        [self.clickBtn setTitle:[NSString stringWithFormat:@"Continue"] forState:UIControlStateNormal];
        [countDownTimer invalidate];
        buttonStatus = YES;
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
    
    [self.delegate addItemViewController:self didFinishEnteringItem:self.timeCountValue];
}

#pragma mark - Text Field

- (void)textFieldInit
{
    self.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"Leave ?"
                                                        message:@"are u sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
    [alterView show];
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    [self.delegate addItemViewController:self didFinishEnteringItem:self.timeCountValue];
    [countDownTimer invalidate];
}

@end
