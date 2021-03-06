//
//  AddLoanViewController.m
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "AddLoanViewController.h"
#import "ApplyLoanDetailViewController.h"
#import "SellApplyLoanViewController.h"
#import "SellQueriesViewController.h"
#import "SellAuctionViewController.h"
#import "SellPostingViewController.h"
#import "DashboardCollectionViewCell.h"
#import "InventoryViewController.h"


@interface AddLoanViewController ()
{
    NSDictionary * addLoanDict;
}
@end

@implementation AddLoanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObjShared = [SharedClass sharedInstance];
    
    // Corner Radius for Enter button
    submitButton.layer.cornerRadius = 10;
    submitButton.layer.masksToBounds = NO;
    submitButton.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    submitButton.layer.shadowOpacity = 0.2;
    submitButton.layer.shadowRadius = 2;
    submitButton.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",userNameField.text,@"customer_name",userContactField.text,@"customer_mobile",userEmailField.text,@"customer_emailid",userPanField.text,@"customer_pan",userAmountField.text,@"amount",@"applyloanpage",@"page_name", nil];
    [ObjShared callWebServiceWith_DomainName:@"add_inventoryloan" postData:para];
}


#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ObjShared.inventoryFooterText.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.inventoryFooterArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.inventoryFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 4)
    {
        cell.footIcon.image=[UIImage imageNamed:@"loan-white.png"];
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
        InventoryViewController *inventVC =[self.storyboard instantiateViewControllerWithIdentifier:@"InventoryViewController"];
        [[self navigationController] pushViewController:inventVC animated:NO];
    }
    else if (indexPath.row==1)
    {
        SellPostingViewController *postVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SellPostingViewController"];
        [[self navigationController] pushViewController:postVC animated:NO];
    }
    else if (indexPath.row==2)
    {
        SellAuctionViewController *auctionVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SellAuctionViewController"];
        [[self navigationController] pushViewController:auctionVC animated:NO];
    }
    else if (indexPath.row==3)
    {
        SellQueriesViewController *queriesVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SellQueriesViewController"];
        [[self navigationController] pushViewController:queriesVC animated:NO];
    }
    else if (indexPath.row==4)
    {
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}
-
(IBAction)backButton:(id)sender
{
    [[self navigationController] popViewControllerAnimated:NO];
}

-(IBAction)submitButton:(id)sender
{
    if (userNameField.text.length == 0 || userNameField.text.length < 25)
    {
        [AppDelegate showAlert:@"Alert" withMessage:@"Invalid user name"];
    }
    else if (![self validatePhone:[NSString stringWithFormat:@"+%@",userContactField.text]] || userContactField.text.length == 0)
    {
        [AppDelegate showAlert:@"Alert" withMessage:@"Invalid contact number"];
    }
    else if (![self isValidEmail:userEmailField.text] || userEmailField.text.length == 0)
    {
        [AppDelegate showAlert:@"Alert" withMessage:@"Invalid email"];
    }
    else if (![self validatePanCardNumber:userPanField.text])
    {
        [AppDelegate showAlert:@"Alert" withMessage:@"Invalid PAN number"];
    }
    else if (userAmountField.text.length == 0)
    {
        [AppDelegate showAlert:@"Alert" withMessage:@"Invalid amount"];
    }
    else
    {
        [self callMakeid];
    }
}
//PAN validation
- (BOOL) validatePanCardNumber: (NSString *) cardNumber {
    NSString *emailRegex = @"^[A-Z]{5}[0-9]{4}[A-Z]$";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [cardTest evaluateWithObject:cardNumber];
}

//PhoneNUmber Validation
- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

//Email Validation
-(BOOL)isValidEmail:(NSString *)email
{
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
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        addLoanDict= dict;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success!!" message:[addLoanDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [[self navigationController] popViewControllerAnimated:NO];
                                   }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:NO completion:nil];

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

