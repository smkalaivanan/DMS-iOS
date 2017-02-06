//
//  EdituserViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "EdituserViewController.h"

@interface EdituserViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *rows;
    NSMutableArray * newRoleArray;
}
@end

@implementation EdituserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor=[UIColor clearColor];
    role.inputView = picker;
    newRoleArray = [[NSMutableArray alloc] init];
    [newRoleArray addObject:@"Select role"];
    [newRoleArray addObjectsFromArray:[[ObjShared.tagName valueForKey:@"User_role_list"]valueForKey:@"master_role_name"]];
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
    save.layer.cornerRadius = 10;
    save.layer.masksToBounds = YES;
}
-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",profileName.text,@"dealer_name",phone.text,@"mobilenumber",email.text,@"dealer_mail",rows,@"user_role",@"addnewuser",@"page_name", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_add_user" postData:para];
}

#pragma PickerView
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return newRoleArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return newRoleArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    role.text = newRoleArray[row];
    rows = [NSString stringWithFormat:@"%ld",(long)row];
    if (row == 0)
    {
        role.textColor = [UIColor grayColor];
    }
    else
    {
        role.textColor = [UIColor blackColor];
    }
}

#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ObjShared.manageFooterText count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.manageFooterArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.manageFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 3)
    {
        cell.footIcon.image=[UIImage imageNamed:@"user-white.png"];
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
        profileViewController *profileVC =[self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
        [[self navigationController] pushViewController:profileVC animated:NO];
        
    }
    else if (indexPath.row==1)
    {
        myBranchesViewController *branchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myBranchesViewController"];
        [[self navigationController] pushViewController:branchVC animated:NO];
    }
    else if (indexPath.row==2)
    {
        myContactViewController *contactVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myContactViewController"];
        [[self navigationController] pushViewController:contactVC animated:NO];
    }
    else if (indexPath.row==3)
    {
//        myUsersViewController *userVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myUsersViewController"];
//        [[self navigationController] pushViewController:userVC animated:NO];
    }
    else if (indexPath.row==4)
    {
        subscriptionViewController *subVC =[self.storyboard instantiateViewControllerWithIdentifier:@"subscriptionViewController"];
        [[self navigationController] pushViewController:subVC animated:NO];
    }
    
    NSLog(@"selected");

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}
#pragma Email Validator
-(BOOL)isValidEmail:(NSString *)emailid
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailid];
}

#pragma mark -textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)save:(id)sender
{
    if (phone.text.length == 0)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Mobile number can't be empty"];
    }
    else if (profileName.text.length == 0)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Name can't be empty"];
    }
    else if (phone.text.length < 10)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Invalid mobile number"];
    }
    else if (phone.text.length > 10)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Invalid mobile number"];
    }
    else if (email.text.length == 0)
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Email id can't be empty"];
    }
    else if (![self isValidEmail:email.text])
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Invalid email"];
    }
    else if ([role.text isEqualToString:@"Select role"])
    {
        [AppDelegate showAlert:@"Required" withMessage:@"Please select user role"];
    }
    else
    {
        [self callMakeid];
    }
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    
}
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success!!" message:[dict objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
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
        [AppDelegate showAlert:@"Alert!" withMessage:[dict valueForKey:@"message"]];
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
