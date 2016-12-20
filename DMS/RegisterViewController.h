//
//  RegisterViewController.h
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface RegisterViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,SharedDelegate>
{
    IBOutlet UITextField *dealerName;
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *emailId;
    IBOutlet UITextField *contactNo;
    IBOutlet UITextField *city;

    IBOutlet UIButton *signUp;
    IBOutlet UIButton *signinPressed;
}
-(IBAction)signupPressed:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)signinPressed:(id)sender;

@end
