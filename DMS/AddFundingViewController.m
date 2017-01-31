//
//  AddFundingViewController.m
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "AddFundingViewController.h"
#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "MyQueriesViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "DashboardViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface AddFundingViewController ()
{
    NSDictionary * addFundingDict;
}
@end

@implementation AddFundingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ObjShared = [SharedClass sharedInstance];

    // Corner Radius for Enter button
    submitButton.layer.cornerRadius = 10;
    submitButton.layer.masksToBounds = NO;
    submitButton.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    submitButton.layer.shadowOpacity = 0.2;
    submitButton.layer.shadowRadius = 2;
    submitButton.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
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
    
    [dealerImg setImageWithURL:[NSURL URLWithString:[ObjShared.LoginDict valueForKey:@"dealer_img"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    dealerImg.layer.cornerRadius = dealerImg.frame.size.width /2;
    dealerImg.layer.masksToBounds = YES;
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"addfundingpage",@"page_name",dealerName.text,@"dealername",mobileNo.text,@"dealermobileno",amount.text,@"requested_amount",city.text,@"dealercity",emailId.text,@"dealermailid",dealershipName.text,@"dealershipname",area.text,@"dealerarea", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_add_funding" postData:para];
    NSLog(@"param ----> %@",para);
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)sumbit:(id)sender
{
    NSLog(@"Submit clicked");
    if (mobileNo.text.length == 0)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Mobile number can't be empty"];
    }
    else if (mobileNo.text.length < 10)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Invalid mobile number"];
    }
    else if (mobileNo.text.length > 10)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Invalid mobile number"];
    }
    else if (emailId.text.length == 0)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Email id can't be empty"];
    }
    else if (![self isValidEmail:emailId.text])
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Invalid email"];
    }
    else
    {
        [self callMakeid];
    }
}

#pragma mark -IsValid Email

-(BOOL)isValidEmail:(NSString *)email
{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailPredicate evaluateWithObject:email];
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark -textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ObjShared.footerText.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.footerArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.footerText objectAtIndex:indexPath.row];
    
    
    
    if (indexPath.row == 4)
    {
        cell.footIcon.image=[UIImage imageNamed:@"funding-white.png"];
        cell.foorLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        cell.foorLabel.textColor = UIColorFromRGB(0X8397BC);
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        DashboardViewController *DashVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
        [[self navigationController] pushViewController:DashVC animated:NO];
        
    }
    else if (indexPath.row==1)
    {
        SavedcarViewController *savedVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SavedcarViewController"];
        [[self navigationController] pushViewController:savedVC animated:NO];
        
    }
    else if (indexPath.row==2)
    {
        MyQueriesViewController *queriesVC =[self.storyboard instantiateViewControllerWithIdentifier:@"MyQueriesViewController"];
        [[self navigationController] pushViewController:queriesVC animated:NO];
    }
    else if (indexPath.row==3)
    {
        bidsPostedViewController *bidVC =[self.storyboard instantiateViewControllerWithIdentifier:@"bidsPostedViewController"];
        [[self navigationController] pushViewController:bidVC animated:NO];
        
    }
    else if (indexPath.row==4)
    {
        ApplyFundingViewController *fundingVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ApplyFundingViewController"];
        [[self navigationController] pushViewController:fundingVC animated:NO];
        
    }
    //    NSLog(@"selected");
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        addFundingDict= dict;
        [[self navigationController]popViewControllerAnimated:NO];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Alert !!" withMessage:[dict valueForKey:@"message"]];
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
