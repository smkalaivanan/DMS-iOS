//
//  EditContactViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()<WCSContactPickerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *base64String;
    NSString *sub;
    NSMutableArray * newRoleArray;
    NSString *typeId;
    NSString *rows;
    UIImage *chosenimage;


}
@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor=[UIColor clearColor];
    contactType.inputView = picker;
    newRoleArray = [[NSMutableArray alloc] init];
    [newRoleArray addObjectsFromArray:[ObjShared.tagName valueForKey:@"dealer_contact_type"]];

    if (ObjShared.editContact == 1)
    {
        contactType.text=[ObjShared.contactArray valueForKey:@"contact_type"];
        contactOwner.text=[ObjShared.contactArray valueForKey:@"contact_owner"];
        profileName.text=[ObjShared.contactArray valueForKey:@"name"];
        email.text=[ObjShared.contactArray valueForKey:@"email"];
        phone.text=[ObjShared.contactArray valueForKey:@"mobilenum"];
        address.text=[ObjShared.contactArray valueForKey:@"address"];
        
        [profileImg setImageWithURL:[NSURL URLWithString:[ObjShared.contactArray valueForKey:@"contactimage"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }

    
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


#pragma PickerView
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return newRoleArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [newRoleArray valueForKey:@"contact_type"][row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    contactType.text = [NSString stringWithFormat:@"%@",[newRoleArray valueForKey:@"contact_type"][row]];
    typeId = [NSString stringWithFormat:@"%@",[newRoleArray valueForKey:@"contact_type_id"][row]];

    rows = [NSString stringWithFormat:@"%ld",(long)row];
    if (row == 0)
    {
        contactType.textColor = [UIColor grayColor];
    }
    else
    {
        contactType.textColor = [UIColor blackColor];
    }
}




#pragma mark -IsValid Email

-(BOOL)isValidEmail:(NSString *)emails
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:emails];
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
    return [ObjShared.manageFooterText count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.manageFooterArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.manageFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 2)
    {
        cell.footIcon.image=[UIImage imageNamed:@"contact-white.png"];
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
        myUsersViewController *userVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myUsersViewController"];
        [[self navigationController] pushViewController:userVC animated:NO];
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


-(IBAction)save:(id)sender
{
    [self base64Converter];

//    if(contactOwner.text.length == 0)
//    {
//        sub=@"Please enter the ";
//        
//    }
//    else if(contactType.text.length == 0)
//    {
//        
//    }
//    else if(profileName.text.length == 0)
//    {
//        
//    }
//    else if(phone.text.length == 0)
//    {
//        
//    }
//    else if(email.text.length == 0)
//    {
//        sub=@"Please enter the E-mail-Id";
//        
//    }
//    else if (![self isValidEmail:email.text])
//    {
//        sub=[NSString stringWithFormat:@"Invaild Email-Id"];
//        
//    }
//    
//    else if(address.text.length == 0)
//    {
//        
//    }
    if(ObjShared.editContact == 0)
    {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"addcontact",@"page_name",typeId,@"contact_type",contactOwner.text,@"contactowner",profileName.text,@"contactname", phone.text,@"contactnumber",email.text,@"contactmailid",address.text,@"contactaddress",[ObjShared.contactArray valueForKey:@"contact_id"],@"contact_id",base64String,@"contact_image",nil];
        NSLog(@"para--->%@",para);
        [ObjShared callWebServiceWith_DomainName:@"api_update_contact" postData:para];
        
    }
    else if(ObjShared.editContact == 1)
    {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"editcontact",@"page_name",typeId,@"contact_type",contactOwner.text,@"contactowner",profileName.text,@"contactname", phone.text,@"contactnumber",email.text,@"contactmailid",address.text,@"contactaddress",base64String,@"contact_image",nil];
        
        NSLog(@"para--->%@",para);
        
        [ObjShared callWebServiceWith_DomainName:@"api_add_contact" postData:para];
        
    }
    
//    [AppDelegate showAlert:@"Required !!" withMessage:sub];
    
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)pic:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.allowsEditing= NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)base64Converter
{
    profileImg.image = chosenimage;
    UIImage *image = chosenimage;
    UIImage *tempImage = nil;
    CGSize targetSize = CGSizeMake(200,200);
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
    thumbnailRect.origin = CGPointMake(0.0,0.0);
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [image drawInRect:thumbnailRect];
    tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    chosenimage = tempImage;
    NSData *dataImage = [[NSData alloc] init];
    dataImage = UIImageJPEGRepresentation(chosenimage, 0);
    base64String = [dataImage base64EncodedStringWithOptions:0];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chosenimage = info[UIImagePickerControllerOriginalImage];
    profileImg.image = chosenimage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)ContactPicker:(id)sender
{
    NSLog(@"Contact picker clicked");
//        if ([CNContactPickerViewController class]) {
//            CNContactPickerViewController *cVC = [[CNContactPickerViewController alloc] init];
//            [self.view.window.rootViewController presentViewController:cVC animated:YES completion:nil];
//        }
    WCSContactPicker * _picker = [[WCSContactPicker alloc] initWithDelegate:self];
    UINavigationController * controller = [[UINavigationController alloc] initWithRootViewController:_picker];
    [self presentViewController:controller animated:YES completion:NULL];
    
    
}

#pragma mark - WCSContactPicker Delegates

- (void)didCancelContactSelection
{
    NSLog(@"Canceled Contact Selection.");
}
- (void)picker:(WCSContactPicker *)picker didFailToAccessContacts:(NSError *)error
{
    NSLog(@"Failed to Access Contacts: %@", error.description);
}
- (void)picker:(WCSContactPicker *)picker didSelectContact:(Contact *)contact
{
    NSLog(@"Selected Contact: %@", contact.description);
    //    TxtMobile.text = contact.phones[0];
    //    _labelEmail.text = contact.emails[0];
    
    NSString * newString;
    
    profileName.text=contact.displayName;
    
    email.text=contact.emails[0];
    
    newString=[[[contact.phones[0] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""]stringByReplacingOccurrencesOfString:@"-" withString:@""];

    
    phone.text=newString;
    
    address.text=contact.addressString;
    
    NSLog(@"address -----> %@",contact.addressString);

    NSLog(@"Number -----> %@",contact.phones[0]);
    NSLog(@"Name ------> %@",newString);
    
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        [self.navigationController popViewControllerAnimated:YES];
  
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"No Records" withMessage:[dict valueForKey:@"message"]];
    }
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {}
}
- (void)failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}





@end
