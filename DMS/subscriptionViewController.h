//
//  subscriptionViewController.h
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCollectionViewCell.h"
#import "myUsersViewController.h"
#import "myContactViewController.h"
#import "myBranchesViewController.h"
#import "profileViewController.h"
#import "subscriptionTableViewCell.h"


@interface subscriptionViewController : UIViewController
{
    IBOutlet UIButton *save;
}
-(IBAction)sidemMenu:(id)sender;


@end
