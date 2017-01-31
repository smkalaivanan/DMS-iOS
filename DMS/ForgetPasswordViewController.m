//
//  ForgetPasswordViewController.m
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate,SharedDelegate>
{
    NSString *sub;
    AppDelegate * appDelegate;
    UIView * activity;
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Include AppDelegate
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    ObjShared = [SharedClass sharedInstance];
    

    // Corner Radius for Enter button
    submit.layer.cornerRadius = 10;
    submit.layer.masksToBounds = NO;
    submit.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    submit.layer.shadowOpacity = 0.2;
    submit.layer.shadowRadius = 2;
    submit.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    // Button color change in range
    NSMutableAttributedString * butString = [[NSMutableAttributedString alloc]
                                             initWithString:@"Already have an account ? Sign In"];
    [butString addAttribute:NSForegroundColorAttributeName
                      value:[UIColor redColor]
                      range:NSMakeRange(butString.length - 7,7)];
    [existingAccount setAttributedTitle:butString
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

-(IBAction)submitPressed:(id)sender
{
    [self.view endEditing:YES];
    
    if (emailId.text.length==0)
    {
        sub=[NSString stringWithFormat:@"Please enter the Email-Id"];
        [self alert];
    }
    else
    {
//        activity = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        activity.backgroundColor = [UIColor blackColor];
//        activity.alpha = 0.1;
//        [self.view addSubview:activity];
//        activity.hidden = NO;
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:emailId.text,@"mailid", nil];
        
        [ObjShared callWebServiceWith_DomainName:@"forgot_password" postData:para];
    }
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)existingAccount:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma alertview Controller
-(void)alert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:sub preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:NO completion:nil];
}

#pragma mark -IsValid Email
-(BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}
//Status bar hidden
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success!!" message:[dict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
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
                                       [self.navigationController popViewControllerAnimated:NO];
                                   }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Failure" withMessage:[dict objectForKey:@"message"]];
    }
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {
        
    }
}
- (void) failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}
@end
