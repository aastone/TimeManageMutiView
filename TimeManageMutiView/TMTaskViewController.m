//
//  TMTaskViewController.m
//  TimeManagerStoryboard
//
//  Created by stone on 5/23/14.
//  Copyright (c) 2014 stone. All rights reserved.
//

#import "TMTaskViewController.h"

@interface TMTaskViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView *tableView;
    
    NSInteger itemCount; // cell count
    NSMutableArray *itemContent; // tableview cell 内容
    NSInteger rowsInSection; //tableview 行数、数组长度 -- 可以删掉，用itemContent.count代替
    
    NSString *filename; // plist 文件名
    UITextField *textField; // 输入框
    NSMutableArray *itemStartTime;
}

@end

@implementation TMTaskViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //0
    itemContent = [NSMutableArray arrayWithObjects:@"20140327", nil];
    
    //plist
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSLog(@"path = %@",path);
    filename=[path stringByAppendingPathComponent:@"test.plist"];
    NSMutableArray *plistArray = [NSMutableArray arrayWithContentsOfFile:filename];
    
    if (plistArray) {
        itemContent = [NSMutableArray arrayWithArray:plistArray];
    }else{
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }


    [self tableViewInit];
    [self addTapGesture];
    
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
    if (textField.frame.origin.y >65.0) {
        [textField resignFirstResponder];
        [self textFieldInit];
    }
}

- (void)textFieldInit
{
    if (textField.frame.origin.y < -39.0) {
        [textField setText:nil];
        textField.placeholder = @"接下来要做的事";
        textField.frame = CGRectMake(0, 66.0, 320, 44);
    }else if(textField.frame.origin.y >65.0){
        NSLog(@"%f",textField.frame.origin.y);
        [textField setText:nil];
        textField.placeholder = @"接下来要做的事";
        textField.frame = CGRectMake(0, -40.0, 320, 44);
    }else{
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 66, 320, 44)];
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
    if (textField.frame.origin.y >65.0) {
        [textField resignFirstResponder];
        [self addNewItem];
        [self textFieldInit];
    }
    return YES;
}


#pragma mark - Scroll view

- (void)scrollViewInit
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    scrollView.contentSize = self.view.frame.size;
    scrollView.delegate = self;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (tableView.contentOffset.y < -30) {
        [self textFieldInit];
    }
}

#pragma mark - Add New Item

- (void)addTimeLine
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:@"yyyy-MM-dd"];
    [formatterTime setDateFormat:@"HH:mm:ss"];
    
    //    NSString *currentDate = [formatterDate stringFromDate:date];
    NSString *currentTime = [formatterTime stringFromDate:date];
    
    [itemStartTime addObject:currentTime];
    
    itemCount++;
}

// 增加cell的内容，并将内容存到plist文件中
- (void)addItemContent
{
    [itemContent addObject:textField.text];
    itemCount ++;
    [itemContent writeToFile:filename atomically:YES];
}


- (void)addNewItem
{
    [self addItemContent];
    [tableView reloadData];
}

#pragma mark - Init View

- (void)tableViewInit
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    //    NSLog(@"%f-%f-%f-%f",bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, bounds.origin.y + 9.0, bounds.size.width, bounds.size.height) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    tableView.pagingEnabled = YES;
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
    return itemContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    TMItemCell *cell = [mtableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TMItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", itemContent[itemContent.count - indexPath.row - 1]];
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
			[itemContent removeObjectAtIndex:(itemContent.count - indexPath.row - 1)];
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
		}
	}
	
}

- (void)swipeCell:(JZSwipeCell *)cell swipeTypeChangedFrom:(JZSwipeType)from to:(JZSwipeType)to
{
	// perform custom state changes here
	NSLog(@"Swipe Changed From (%d) To (%d)", from, to);
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

    passData = [[NSString alloc] initWithFormat:@"%@",[itemContent objectAtIndex:(itemContent.count - 1 - indexPath.row)]];

    detailViewController.listArray = [[NSMutableArray alloc] initWithObjects:passData, nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)addItemViewController:(TMDetailViewController *)controller didFinishEnteringItem:(NSString *)item
{
    NSLog(@"this will %@", item);
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
