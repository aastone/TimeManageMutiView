//
//  TMSettingViewController.m
//  TimeManager
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMSettingViewController.h"

@interface TMSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TMSettingViewController

@synthesize tableView, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Account";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self tableViewInit];
    
}

#pragma mark - tableViewInit

- (void)tableViewInit
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)
                                             style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    NSLog(@"jj");
    [self.view addSubview:tableView];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [mtableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Settings";
    }else {
        cell.textLabel.text = @"Login up | Sign in";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"before");
    [self.delegate clicked:@"kkk"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
