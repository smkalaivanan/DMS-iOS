//
//  LoginViewController.h
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "DashboardViewController.h"

@interface LoginViewController : UIViewController<SharedDelegate>

{
    IBOutlet UITextField *userName;
    IBOutlet UITextField *password;
    IBOutlet UIButton *submit;
    IBOutlet UIButton *signUp;
    IBOutlet UIButton *forgotPassword;
    NSMutableData * receivedData;
    NSDictionary * loginDict;
}

-(IBAction)submitPressed:(id)sender;
-(IBAction)signUpPressed:(id)sender;
-(IBAction)forgotPasswordPressed:(id)sender;

@end
