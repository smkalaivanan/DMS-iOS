//
//  AddFundingViewController.h
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFundingViewController : UIViewController
{
    IBOutlet UITextField *dealerName;
    IBOutlet UITextField *mobileNo;
    IBOutlet UITextField *amount;
    IBOutlet UITextField *city;
    IBOutlet UITextField *emailId;
    IBOutlet UITextField *dealershipName;
    IBOutlet UITextField *area;

    IBOutlet UILabel *financeName;
    IBOutlet UILabel *request;
    IBOutlet UIImageView *financeImg;
    IBOutlet UIImageView *dealerImg;
    IBOutlet UIButton * submitButton;
}

-(IBAction)back:(id)sender;
-(IBAction)sumbit:(id)sender;

@end
