//
//  ChangePasswordViewController.m
//  DMS
//
//  Created by macbook on 02/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation ChangePasswordViewController

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

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(IBAction)submit:(id)sender
{
    
//    activity = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    activity.backgroundColor = [UIColor blackColor];
//    activity.alpha = 0.1;
//    [self.view addSubview:activity];
//    activity.hidden = NO;
   
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:oldPass.text,@"oldpassword",changePass.text,@"newpassword",confirmPass.text,@"confirm_password",[ObjShared.LoginDict valueForKey:@"user_id"],@"id", nil];
    
    [ObjShared callWebServiceWith_DomainName:@"change_password" postData:para];

}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -W.S Delegate Call
- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    [self.view endEditing:YES];

    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        [AppDelegate showAlert:@"Success" withMessage:[dict objectForKey:@"message"]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Error" withMessage:[dict objectForKey:@"message"]];
    }
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Check for Internet Connectivity"];
    }
//    activity.hidden = YES;
    
}
- (void) failResponseFromServer
{
    
    [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
    
//    activity.hidden = YES;
    
}


@end
