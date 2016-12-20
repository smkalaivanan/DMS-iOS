//
//  ChangePasswordViewController.h
//  DMS
//
//  Created by macbook on 02/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
{
    IBOutlet UITextField *oldPass;
    IBOutlet UITextField *changePass;
    IBOutlet UITextField *confirmPass;
    IBOutlet UIButton *submit;
    UIView * activity;

    
}
-(IBAction)back:(id)sender;
-(IBAction)submit:(id)sender;
@end
