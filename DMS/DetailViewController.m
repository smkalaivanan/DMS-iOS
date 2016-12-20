//
//  DetailViewController.m
//  DMS
//
//  Created by macbook on 23/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
@interface DetailViewController ()
{
    AppDelegate * appDelegate;

}
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Include DelegateMethod
    
    ObjShared = [SharedClass sharedInstance];

    //Include AppDelegate

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];


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

-(void)callMethod
{
//    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Chennai",@"City", nil];
//    [ObjShared callWebServiceWith_DomainName:@"apibuyid" postData:para];
}



//Status bar hidden
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -W.S Delegate Call
- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
    }
    
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {
        
    }
    
}

- (void) failResponseFromServer
{
    [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
}



@end
