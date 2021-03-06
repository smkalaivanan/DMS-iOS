//
//  EditContactViewController.h
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
#import "WCSContactPicker.h"


@interface EditContactViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *profileImg;
    IBOutlet UITextField *contactType;
    IBOutlet UITextField *contactOwner;
    IBOutlet UITextField *profileName;
    IBOutlet UITextField *email;
    IBOutlet UITextField *address;
    IBOutlet UITextField *phone;
    IBOutlet UIButton *save;
}
-(IBAction)save:(id)sender;
-(IBAction)back:(id)sender;
- (IBAction)pic:(id)sender;
- (IBAction)ContactPicker:(id)sender;

@end
