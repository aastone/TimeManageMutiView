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

@interface TMDetailViewController () <UITextFieldDelegate>
{
    NSInteger secondsCountDown;
    NSInteger minutesCountDown;
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
            
            if (secondsCountDown) {
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
        
        if (secondsCountDown) {
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
        minutesCountDown++;
        self.timeCount.text = [NSString stringWithFormat:@"%ld min", (long)minutesCountDown];
    }
}

- (IBAction)reduceMinute:(id)sender {
    if ([self.clickBtn.titleLabel.text isEqualToString:[NSString stringWithFormat:@"Start"]]) {
        [self regexForTimeCount];
        if (minutesCountDown != 1) {
            minutesCountDown--;
        }
        self.timeCount.text = [NSString stringWithFormat:@"%ld min", (long)minutesCountDown];
    }
}

- (void)regexForTimeCount
{
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:self.timeCount.text options:0 range:NSMakeRange(0, [self.timeCount.text length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result = [self.timeCount.text substringWithRange:resultRange];
            minutesCountDown = [result intValue];
            secondsCountDown = minutesCountDown * 60;
        }
    }
}

- (void)timeFireMethod
{
    secondsCountDown--;
    if (secondsCountDown%60 == 0 && minutesCountDown > 1) {
        minutesCountDown-- ;
    }
    if (minutesCountDown >= 1) {
        self.timeCount.text = [NSString stringWithFormat:@"%d min %d s", minutesCountDown - 1 , secondsCountDown%60];
    }else{
        self.timeCount.text = [NSString stringWithFormat:@"%d min %d s", minutesCountDown, secondsCountDown%60];
    }
    self.timeCountValue = [NSMutableString stringWithString:self.timeCount.text];
    NSLog(@"正在倒计时：%@", self.timeCountValue);
    [self.delegate addItemViewController:self didFinishEnteringItem:self.timeCountValue];
    if (secondsCountDown == 0) {
        NSLog(@"000%@", self.timeCountValue);
        [countDownTimer invalidate];
    }
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
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    [self.delegate addItemViewController:self didFinishEnteringItem:self.timeCountValue];
}


@end
