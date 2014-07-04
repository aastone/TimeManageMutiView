//
//  TMTaskViewController.m
//  TimeManagerStoryboard
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMTaskViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "TMItemModel.h"

@interface TMTaskViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView *tableView;
    NSString *filename; // plist 文件名
    UITextField *textField; // 输入框
    CGRect bounds;
}

@end

@implementation TMTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.title = @"Task";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    bounds = [[UIScreen mainScreen] applicationFrame];
    
    item = [[TMItemModel alloc] init];
    
    //tabItem上的小数字
    [[self rdv_tabBarItem] setBadgeValue:@"3"];
    
    if (self.rdv_tabBarController.tabBar.translucent) {
        UIEdgeInsets inserts = UIEdgeInsetsMake(0,
                                                0,
                                                CGRectGetHeight(self.rdv_tabBarController.tabBar.frame),
                                                0);
        tableView.contentInset = inserts;
        tableView.scrollIndicatorInsets = inserts;
    }
    
    //0
    [item setItemTitle:[NSMutableArray arrayWithObject:@"jkjk"]];
    
    [[item itemTitle] addObject:@"dddd"];
//    NSLog(@"%@", [item itemTitle]);
    
    
    //plist
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
//    NSLog(@"path = %@",path);
    filename=[path stringByAppendingPathComponent:@"test.plist"];
    NSMutableArray *plistArray = [NSMutableArray arrayWithContentsOfFile:filename];
    
    if (plistArray) {
        [item setItemTitle:[NSMutableArray arrayWithArray:plistArray]];
    }else{
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }


    [self tableViewInit];
    [self addTapGesture];
}

#pragma mark - TabBar Method

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - TextField

- (void)addTapGesture
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)viewTapped
{
    if (textField.frame.origin.y > 0.001) {
        [textField resignFirstResponder];
        tableView.frame =  CGRectMake(0, -35, bounds.size.width, bounds.size.height);
        [self textFieldInit];
    }
}

- (void)textFieldInit
{
    if (textField.frame.origin.y < -39.0) {
        [textField setText:nil];
        textField.placeholder = @"接下来要做的事";
        textField.frame = CGRectMake(0, 0.01, 320, 44);
        tableView.frame = CGRectMake(0, 9, bounds.size.width, bounds.size.height);
    }else if(textField.frame.origin.y > 0.001){
//        NSLog(@"%f",textField.frame.origin.y);
        [textField setText:nil];
        textField.placeholder = @"接下来要做的事";
        textField.frame = CGRectMake(0, -60.0, 320, 44);
        tableView.frame = CGRectMake(0, -35, bounds.size.width, bounds.size.height);
    }else{
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0.01, 320, 44)];
//        NSLog(@"-----+++++%f", textField.frame.origin.y);
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"接下来要做的事";
        [self.view addSubview:textField];
        textField.delegate = self;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)atextField
{
    [textField resignFirstResponder];
    [self addNewItem];
    [self textFieldInit];
    tableView.frame =  CGRectMake(0, -35, bounds.size.width, bounds.size.height);
    
    return YES;
}


#pragma mark - Scroll view

- (void)scrollViewInit
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    scrollView.contentSize = self.view.frame.size;
    scrollView.delegate = self;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (tableView.contentOffset.y < -30) {
        tableView.frame =  CGRectMake(0, 9, bounds.size.width, bounds.size.height);
        [self textFieldInit];
    }
}

#pragma mark - Add New Item

// 增加cell的内容，并将内容存到plist文件中

- (void)addNewItem
{
    [item addItem:textField.text ToFile:filename];
    [tableView reloadData];
//    NSLog(@"%@--%@", [item itemCreateTime], [item itemTitle]);
}

#pragma mark - Init View

- (void)tableViewInit
{
//    NSLog(@"%f-%f-%f-%f",bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -35, bounds.size.width, bounds.size.height) style:UITableViewStyleGrouped];
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.7];
//    tableView.pagingEnabled = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (void)tableViewOriginChange
{
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 9, bounds.size.width, bounds.size.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning need-to-add-section function according date
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[item itemTitle] count];
}

- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    TMItemCell *cell = [mtableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TMItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [item itemTitle][[item itemTitle].count - indexPath.row - 1]];
    cell.delegate = self;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JZSwipeCellDelegate methods

- (void)swipeCell:(JZSwipeCell*)cell triggeredSwipeWithType:(JZSwipeType)swipeType
{
	if (swipeType != JZSwipeTypeNone)
	{
		NSIndexPath *indexPath = [tableView indexPathForCell:cell];
		if (indexPath)
		{
			[[item itemTitle] removeObjectAtIndex:([item itemTitle].count - indexPath.row - 1)];
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
	}
	
}

- (void)swipeCell:(JZSwipeCell *)cell swipeTypeChangedFrom:(JZSwipeType)from to:(JZSwipeType)to
{
	// perform custom state changes here
//	NSLog(@"Swipe Changed From (%d) To (%d)", from, to);
}

#pragma mark - Datail View

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create the next view controller.
    TMDetailViewController *detailViewController = [[TMDetailViewController alloc] initWithNibName:@"TMDetailViewController" bundle:nil];
    detailViewController.isSomethingEnabled = YES;
    detailViewController.delegate = self;
    detailViewController.title = @"Detail";

    passData = [[NSString alloc] initWithFormat:@"%@",[[item itemTitle] objectAtIndex:([item itemTitle].count - 1 - indexPath.row)]];

    detailViewController.listArray = [[NSMutableArray alloc] initWithObjects:passData, nil];
    if (passTime) {
        detailViewController.timeCountValue = [NSMutableString stringWithString:passTime];

    }
    
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)addItemViewController:(TMDetailViewController *)controller didFinishEnteringItem:(NSString *)item
{
    NSLog(@"this will %@", item);
    passTime = item;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
