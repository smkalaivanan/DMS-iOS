//
//  RegisterViewController.m
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface RegisterViewController ()
{
    NSString *sub;
    UIPickerView *cityPicker;
    NSArray * cityArray;
}
@end

@implementation RegisterViewController


#pragma AlertController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Corner Radius for Enter button
    signUp.layer.cornerRadius = 10;
    signUp.layer.masksToBounds = NO;
    signUp.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    signUp.layer.shadowOpacity = 0.2;
    signUp.layer.shadowRadius = 2;
    signUp.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    
    // Button color change in range
    NSMutableAttributedString * butString = [[NSMutableAttributedString alloc]
                                             initWithString:@"Already have an account ? Sign In"];
    [butString addAttribute:NSForegroundColorAttributeName
                      value:[UIColor redColor]
                      range:NSMakeRange(butString.length - 7,7)];
    [signinPressed setAttributedTitle:butString
                      forState:UIControlStateNormal];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:sub preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)signupPressed:(id)sender
{
    [self.view endEditing:YES];

    if (dealerName.text.length==0)
    {
        sub=@"Please enter the Dealer name";
    }
    else if (emailId.text.length==0)
    {
        sub=@"Please enter the E-mail name";
    }
    else if (![self isValidEmail:emailId.text])
    {
        sub=[NSString stringWithFormat:@"Invaild Email-Id"];
        
    }
    else if (contactNo.text.length==0)
    {
        sub=@"Please enter the contact number";
    }
    else if (contactNo.text.length<10)
    {
        sub=@"Enter Contact Number is less than 10 Character";
    }
    else if (city.text.length==0)
    {
        sub=@"Please enter your city";
    }
    else
    {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:dealerName.text,@"dealer_name",emailId.text,@"d_email",contactNo.text,@"d_mobile",city.text,@"d_city",@"registerpage",@"page_register", nil];
        
        [ObjShared callWebServiceWith_DomainName:@"registration_store" postData:para];
        NSLog(@"logging in....");
    }
    [AppDelegate showAlert:@"Required !!" withMessage:sub];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)signinPressed:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -IsValid Email

-(BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}

#pragma mark -textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Status Bar Hidden
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -W.S Delegate Call
- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success!!" message:@"Successfully Registered.Please check your email for password." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                       }];
        
        [alertController addAction:cancelAction];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       LoginViewController *loginVc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                       [self.navigationController pushViewController:loginVc animated:YES];
                                   }
                                   ];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Registration" withMessage:[dict valueForKey:@"message"]];
    }
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {
        [AppDelegate showAlert:@"Registration" withMessage:[dict valueForKey:@"message"]];
    }
}
- (void) failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}

@end
