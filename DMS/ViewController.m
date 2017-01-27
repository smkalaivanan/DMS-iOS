//
//  ViewController.m
//  DMS
//
//  Created by Kalaivanan on 14/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<SharedDelegate>
{
    IQKeyboardReturnKeyHandler *returnKeyHandler;
    AppDelegate * appDelegate;
    NSString * notRechable;
}
@property(nonatomic,retain)UISegmentedControl* segControl;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // IQKeyboardReturnKeyHandler Delegates
    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    [returnKeyHandler setLastTextFieldReturnKeyType:UIReturnKeyDone];
    
    // Corner Radius for signin button
    signin.layer.cornerRadius = 20;
    signin.layer.masksToBounds = NO;
    signin.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for signin button
    signin.layer.shadowOpacity = 0.2;
    signin.layer.shadowRadius = 2;
    signin.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);

    //border for signup button
    signup.layer.borderWidth=1.0f;
    signup.layer.borderColor=UIColorFromRGB(0X42C0EC).CGColor;//blue
    signup.layer.cornerRadius=20;
    signup.layer.masksToBounds = NO;
    signup.layer.shadowColor = [UIColor blackColor].CGColor;

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    ObjShared = [SharedClass sharedInstance];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            ObjShared.collectionZ = 0;
            NSLog(@"iphone 4");
        }
        if(result.height == 568)
        {
            NSLog(@"iphone 5");
            ObjShared.collectionZ = -10;
        }
        if (result.height == 667)
        {
            NSLog(@"iphone 6");
            ObjShared.collectionZ = 1;
        }
        if (result.height == 736)
        {
            NSLog(@"iphone 6+");
            ObjShared.collectionZ = 10;
        }
    }
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

-(IBAction)signupPressed:(id)sender
{
    //push to register page
    RegisterViewController *registerVc =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [[self navigationController] pushViewController:registerVc animated:NO];
    
}

-(IBAction)siginPressed:(id)sender
{
    NSLog(@"enter");
    
    //push to login page
    LoginViewController *loginVc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVc animated:YES];
}

#pragma Custom Keyboard

-(void)previousAction:(UITextField*)textField
{
    NSLog(@"%@ : %@",textField,NSStringFromSelector(_cmd));
}

-(void)nextAction:(UITextField*)textField
{
    NSLog(@"%@ : %@",textField,NSStringFromSelector(_cmd));
}

-(void)doneAction:(UITextField*)textField
{
    NSLog(@"%@ : %@",textField,NSStringFromSelector(_cmd));
}

- (UIToolbar *)keyboardToolBar
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"Previous", @"Next"]];
    self.segControl.momentary = YES;
//    [self.segControl addTarget:self action:@selector(changeRow:) forControlEvents:(UIControlEventValueChanged)];
    [self.segControl setEnabled:NO forSegmentAtIndex:0];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithCustomView:self.segControl];
    
    NSArray *itemsArray = @[nextButton];
    
    [toolbar setItems:itemsArray];
    
    return toolbar;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (!textField.inputAccessoryView)
    {
        
        textField.inputAccessoryView = [self keyboardToolBar];
    }
    if (textField.tag)
    {
        
        [self.segControl setEnabled:NO forSegmentAtIndex:1];
        [self.segControl setEnabled:YES forSegmentAtIndex:0];
    }
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

@end
