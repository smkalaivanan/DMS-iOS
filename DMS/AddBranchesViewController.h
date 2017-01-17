//
//  AddBranchesViewController.h
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
#import "subscriptionViewController.h"
#import "profileViewController.h"


@interface AddBranchesViewController : UIViewController
{
    IBOutlet UITextField *dealerName;
    IBOutlet UITextField *phone;
    IBOutlet UITextField *email;
    IBOutlet UITextField *address;
    IBOutlet UITextField *pincode;    
}

-(IBAction)save:(id)sender;
-(IBAction)back:(id)sender;

@end
