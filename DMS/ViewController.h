//
//  ViewController.h
//  DMS
//
//  Created by Kalaivanan on 14/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController
{
    IBOutlet UIButton * signin;
    IBOutlet UIButton * signup;

}

-(IBAction)siginPressed:(id)sender;
-(IBAction)signupPressed:(id)sender;

@end

