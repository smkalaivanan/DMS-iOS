//
//  ForgetPasswordViewController.h
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ForgetPasswordViewController : UIViewController
{
    IBOutlet UITextField *emailId;
    
    IBOutlet UIButton *submit;
    IBOutlet UIButton *existingAccount;
    NSMutableData * receivedData;
    NSDictionary * forgotDict;
}
-(IBAction)submitPressed:(id)sender;
-(IBAction)back:(id)sender;

@end
