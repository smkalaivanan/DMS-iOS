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
    IBOutlet UITableView * messageTable;
    AppDelegate * appDelegate;
}
@end

@implementation MessageSideDrawerViewController

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

@end