//
//  RegisterViewController.m
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "registrationTableViewCell.h"

@interface RegisterViewController ()
{
    NSString *sub;
    UIPickerView *cityPicker;
    NSArray * cityArray;
    UIActivityIndicatorView *loadingIndicator;
    registrationTableViewCell *branchCell;
}
@end

@implementation RegisterViewController
@synthesize registerTableview;
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
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    [registerTableview dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [registerTableview reloadData];
            [weakSelf.registerTableview dg_stopLoading];
        });
    }
                                          loadingView:loadingView];
    
    [registerTableview dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    
    [registerTableview dg_setPullToRefreshBackgroundColor:registerTableview.backgroundColor];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [loadingIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [loadingIndicator stopAnimating];
    NSString *currentURL = branchCell.webScreen.request.URL.absoluteString;
    NSLog(@"current url ---> %@",currentURL);
    
    if ([currentURL isEqualToString:@"http://52.221.57.201/doapiregister"])
    {backButton.hidden =NO;}
    else
    {backButton.hidden = YES;}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"registrationTableViewCell";
    
    branchCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    branchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Webview URL request
    NSString *stringurl=[NSString stringWithFormat:@"http://52.221.57.201/doapiregister"];
    NSURL *url=[NSURL URLWithString:stringurl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    [branchCell.webScreen loadRequest:theRequest];
    branchCell.webScreen.delegate = self;
    
    branchCell.webScreen.scrollView.scrollEnabled = NO;
    branchCell.webScreen.scrollView.bounces = NO;
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width /2, self.view.frame.size.height/2, 20,20)];
    [loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setHidesWhenStopped:YES];
    [branchCell.webScreen addSubview:loadingIndicator];
    
    return branchCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height;
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
        sub=@"Please enter the E-mail-Id";
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
