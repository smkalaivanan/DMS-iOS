//
//  LoginViewController.m
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "DashboardViewController.h"
#import "LandingViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController ()
{
    NSString *sub;
    AppDelegate * appDelegate;
    UIView * activity;
}

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    //Include AppDelegate
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    ObjShared = [SharedClass sharedInstance];
    
    // Button color change in range
    NSMutableAttributedString * butString = [[NSMutableAttributedString alloc]
                                             initWithString:@"Don't have an account ? Sign Up"];
   [butString addAttribute:NSForegroundColorAttributeName
                     value:[UIColor redColor]
                     range:NSMakeRange(butString.length - 7,7)];
   [signUp setAttributedTitle:butString
                     forState:UIControlStateNormal];
    
    // Corner Radius for Enter button
    submit.layer.cornerRadius = 10;
    submit.layer.masksToBounds = NO;
    submit.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    submit.layer.shadowOpacity = 0.2;
    submit.layer.shadowRadius = 2;
    submit.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
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

#pragma Button Action

-(IBAction)submitPressed:(id)sender
{
    [self.view endEditing:YES];

    if(userName.text.length==0)
    {
        [AppDelegate showAlert:@"" withMessage:@"Please enter the Email-Id"];
    }
    else if(password.text.length==0)
    {
        [AppDelegate showAlert:@"" withMessage:@"Please enter the Password"];
    }
    else
    {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userName.text,@"email",password.text,@"password", nil];
        [ObjShared callWebServiceWith_DomainName:@"user_login" postData:para];
    }
}

-(IBAction)signUpPressed:(id)sender
{
    RegisterViewController *registerVc =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [[self navigationController] pushViewController:registerVc animated:YES];
}

-(IBAction)forgotPasswordPressed:(id)sender
{
    ForgetPasswordViewController *forgotPasswordVc =[self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordViewController"];
    [[self navigationController] pushViewController:forgotPasswordVc animated:YES];
}

#pragma mark -textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Status bar hidden
-(BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dictor
{
    NSLog(@"in success");

    NSLog(@"Dict--->%@",dictor);
       if ([[dictor objectForKey:@"Result"]isEqualToString:@"1"])
        {
            ObjShared.LoginDict=dictor;
            NSLog(@"login page--->%@",ObjShared.LoginDict);

            [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateProfile" object: nil];

            LandingViewController *landingVC =[self.storyboard instantiateViewControllerWithIdentifier:@"LandingViewController"];
            [[self navigationController] pushViewController:landingVC animated:YES];
        }
        else if ([[dictor objectForKey:@"Result"]isEqualToString:@"0"])
        {
             [AppDelegate showAlert:@"Invalid User" withMessage:[NSString stringWithFormat:@"%@",[dictor objectForKey:@"message"]]];
        }
        else if (![[NSString stringWithFormat:@"%@",[dictor objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dictor != nil)
        {
            
        }
    
}

- (void) failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}

@end
