//
//  MFSideDrawerViewController.m
//  DMS
//
//  Created by Kalaivanan on 17/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "MFSideDrawerViewController.h"
#import "MFSideMenu.h"
#import "SideDrawerTableViewCell.h"
#import "ChangePasswordViewController.h"
#import "AppDelegate.h"
#import "InventoryViewController.h"
#import "DashboardViewController.h"
#import "profileViewController.h"

@interface MFSideDrawerViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation MFSideDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjShared = [SharedClass sharedInstance];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateProfile) name:@"UpdateProfile"  object:nil];

    menu=[[NSArray alloc]initWithObjects:@"Home",@"Buy",@"Sell",@"Manage",@"Communication",@"Report",@"Contact",@"Logout", nil];
    
    menuImg=[[NSArray alloc]initWithObjects:@"home.png",@"sell.png",@"Buy.png",@"Manage.png",@"communication.png",@"report.png",@"MenuContact.png",@"logout.png", nil];
    
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
}

#pragma mark -Update Profile
-(void)UpdateProfile
{
    NSLog(@"side page--->%@",ObjShared.LoginDict);

    nameLab.text=[NSString stringWithFormat:@"%@",[ObjShared.LoginDict objectForKey:@"dealer_name"]];
    addressLab.text=[NSString stringWithFormat:@"%@",[ObjShared.LoginDict objectForKey:@"dealer_address"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideDrawerTableViewCell *sideMenuCell;
    
    static NSString * cellIdentifier = @"SideDrawerTableViewCell";
    sideMenuCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    sideMenuCell.selectionStyle=UITableViewCellEditingStyleNone;
    
    sideMenuCell.iconName.text=[NSString stringWithFormat:@"%@",[menu objectAtIndex:indexPath.row]];
    
    sideMenuCell.iconImg.image=[UIImage imageNamed:[menuImg objectAtIndex:indexPath.row]];
    
    return sideMenuCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexpath-->%ld",(long)indexPath.row);
    if (indexPath.row == 1)
    {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
        
        
        DashboardViewController *dashVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
        
        [SharedClass NavigateTo:dashVC inNavigationViewController:appDelegate.navigationController animated:false];
    }
    else if (indexPath.row == 2)
    {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
        
        
        InventoryViewController *inventVC=[self.storyboard instantiateViewControllerWithIdentifier:@"InventoryViewController"];
        
        [SharedClass NavigateTo:inventVC inNavigationViewController:appDelegate.navigationController animated:false];
    }
    else if (indexPath.row == 3)
    {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
        
        
        profileViewController *profileVC=[self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
        
        [SharedClass NavigateTo:profileVC inNavigationViewController:appDelegate.navigationController animated:false];
    }

    else
    {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
//    ChangePasswordViewController *changeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
//    
//    [SharedClass NavigateTo:changeVC inNavigationViewController:appDelegate.navigationController animated:false];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(IBAction)profile:(id)sender
{
    NSLog(@"Clicked");
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
