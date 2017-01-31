//
//  CompareViewController.m
//  DMS
//
//  Created by apple on 1/30/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "CompareViewController.h"
#import "CompareTableViewCell.h"

@interface CompareViewController ()
{
    NSDictionary * compareDict;
    IBOutlet UITableViewCell * compareTable;
    AppDelegate * appDelegate;
}
@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ObjShared = [SharedClass sharedInstance];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self callMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-
(void)viewWillAppear:(BOOL)animated
{
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
}
-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [ObjShared callWebServiceWith_DomainName:@"api_buy_compare" getData:para];
}
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
}
- (void)failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}
-(IBAction)showLeftMenuPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

@end
