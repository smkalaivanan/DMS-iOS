//
//  myUsersViewController.h
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCollectionViewCell.h"
#import "myContactViewController.h"
#import "myBranchesViewController.h"
#import "subscriptionViewController.h"
#import "profileViewController.h"
#import "myUserTableViewCell.h"
#import "HMSegmentedControl.h"


@interface myUsersViewController : UIViewController<SWTableViewCellDelegate,SharedDelegate>
{
    IBOutlet UIView * segmentViewButton;
}
-(IBAction)sidemMenu:(id)sender;
-(IBAction)add:(id)sender;
@property (nonatomic,retain) IBOutlet UITableView * userTableView;
@end
