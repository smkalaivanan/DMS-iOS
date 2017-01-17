//
//  profileViewController.h
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


@interface profileViewController : UIViewController
{
    IBOutlet UIImageView *profileImg;
    IBOutlet UITextField *profileName;
    IBOutlet UITextField *email;
    IBOutlet UITextField *passoword;
    IBOutlet UITextField *phone;
    IBOutlet UIButton *edit;
    IBOutlet UIButton *save;
    IBOutlet UIButton *imgPicker;
}
-(IBAction)sidemMenu:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)edit:(id)sender;
@end
