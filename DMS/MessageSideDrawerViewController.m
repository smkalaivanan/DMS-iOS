//
//  MessageSideDrawerViewController.m
//  DMS
//
//  Created by Kalaivanan on 11/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "MessageSideDrawerViewController.h"
#import "MessageSideDrawerTableViewCell.h"
#import "AppDelegate.h"

@interface MessageSideDrawerViewController ()
{
    NSString * tableString;
    NSString * tableTime;
    UIImage * tableImage;
    AppDelegate * appDelegate;
}
@end

@implementation MessageSideDrawerViewController
@synthesize messageTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    ObjShared = [SharedClass sharedInstance];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    tableString = @"successfully updated the password to database";
    tableTime = @"13 hours ago";
    tableImage = [UIImage imageNamed:@"message-icon-chat.png"];
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [messageTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.messageTable dg_stopLoading];
        });
    }
    loadingView:loadingView];
    [messageTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    [messageTable dg_setPullToRefreshBackgroundColor:messageTable.backgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)segment:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        tableString = @"System password has been changed successfully";
        tableTime = @"13 hours ago";
        tableImage = [UIImage imageNamed:@"message-icon-chat.png"];
        [messageTable reloadData];
    }
    else
    {
        tableString = @"Ragav enquired about your new post";
        tableTime = @"3 days ago";
        tableImage = [UIImage imageNamed:@"chat-icon-message"];
        [messageTable reloadData];
    }
}

#pragma UITableView-Sample

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"MessageSideDrawerTableViewCell";
    MessageSideDrawerTableViewCell * messageSD =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    messageSD.selectionStyle = UITableViewCellSelectionStyleNone;
    messageSD.messageLabel.text = tableString;
    messageSD.timeStampLabel.text = tableTime;
    messageSD.imageHolder.image = tableImage;
    return messageSD;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)dealloc
{
    [messageTable dg_removePullToRefresh];
}

@end
