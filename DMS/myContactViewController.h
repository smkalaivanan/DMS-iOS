//
//  myContactViewController.h
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCollectionViewCell.h"
#import "myUsersViewController.h"
#import "myBranchesViewController.h"
#import "subscriptionViewController.h"
#import "profileViewController.h"
#import "EditTableViewCell.h"
#import "HMSegmentedControl.h"



@interface myContactViewController : UIViewController<SWTableViewCellDelegate,SharedDelegate>
{
    IBOutlet UIView * segmentViewButton;
    IBOutlet UITableView *contactTable;
}
-(IBAction)sidemMenu:(id)sender;
-(IBAction)add:(id)sender;
@property(nonatomic,retain) IBOutlet UITableView * contactTable;
@end
