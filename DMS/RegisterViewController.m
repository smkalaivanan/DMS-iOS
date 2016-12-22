//
//  RegisterViewController.m
//  DMS
//
//  Created by macbook on 16/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "RegisterViewController.h"

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
    
    cityArray = [[NSArray alloc] initWithObjects:@"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai",
                 @"Chennai", nil];
    
    
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
    
    [self pickerItems];
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

#pragma PickerView Delegates

-(void)pickerItems
{
    cityPicker = [[UIPickerView alloc]init];
    cityPicker.dataSource = self;
    cityPicker.delegate = self;
    [cityPicker setShowsSelectionIndicator:YES];
    
    [city setInputView:cityPicker];
    
    // creating a tool bar for done button.
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    city.inputAccessoryView = toolBar;
    
    city.delegate = self;
 
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thepickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        return [cityArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [cityArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    city.text = [ cityArray objectAtIndex:row];

}

-(void)doneTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [city resignFirstResponder];
    // perform some action
}

-(IBAction)signupPressed:(id)sender
{
    if (dealerName.text.length==0)
    {
        sub=@"Please enter the Dealer Name";
        [self alert];
    }
    else if (firstName.text.length==0)
    {
        sub=@"Please enter the Dealer Name";
        [self alert];
    }
    else if (emailId.text.length==0)
    {
        sub=@"Please enter the Dealer Name";
        [self alert];
    }
    else if (![self isValidEmail:emailId.text])
    {
        sub=[NSString stringWithFormat:@"Invaild Email-Id"];
        
        [self alert];
    }
    else if (contactNo.text.length==0)
    {
        sub=@"Please enter the Dealer Name";
        [self alert];
    }
    else if (contactNo.text.length<10)
    {
        sub=@"Enter Contact Number is less than 10 Character";
        [self alert];
    }
    else if (city.text.length==0)
    {
        sub=@"Please enter the Dealer Name";
        [self alert];
    }
    else
    {
        
//        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userName.text,@"email",password.text,@"password", nil];
//        [ObjShared callWebServiceWith_DomainName:@"user_login" postData:para];
        
        sub=@"Successfully Registered";
        [self alert];
    }
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
        [AppDelegate showAlert:@"valid User" withMessage:@"valid Username or Password"];
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
