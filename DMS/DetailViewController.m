//
//  DetailViewController.m
//  DMS
//
//  Created by macbook on 23/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

//http://52.220.105.165/works/Mobile/vani/angular/basicinfo.html

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

    [self web];

    // Do any additional setup after loading the view.
    
}
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request
 navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL  isEqual: @"www.google.co.in"])
    {
        //do close window magic here!!
        [self stopLoading];
        return NO;
    }
    return YES;
}
-(void)stopLoading{
    [webView removeFromSuperview];
}

-(void)web
{
    NSURL *url=[NSURL URLWithString:@"www.google.co.in"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
