//
//  EditContactViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()
{
    NSString *base64String;
}
@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ObjShared.manageFooterText count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.footerArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.manageFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0)
    {
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
    else if (indexPath.row==3)
    {
        subscriptionViewController *subVC =[self.storyboard instantiateViewControllerWithIdentifier:@"subscriptionViewController"];
        [[self navigationController] pushViewController:subVC animated:NO];
        
    }
    else if (indexPath.row==4)
    {
        myContactViewController *contactVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myContactViewController"];
        [[self navigationController] pushViewController:contactVC animated:NO];
        
    }
    else if (indexPath.row==5)
    {
        myBranchesViewController *branchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myBranchesViewController"];
        [[self navigationController] pushViewController:branchVC animated:NO];
        
    }
    else if (indexPath.row==6)
    {
        myUsersViewController *userVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myUsersViewController"];
        [[self navigationController] pushViewController:userVC animated:NO];
        
    }
    NSLog(@"selected");
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}


-(IBAction)save:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    NSLog(@"info-->%@",info);
    UIImage *chosenimage = info[UIImagePickerControllerOriginalImage];
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
    //    NSLog(@"new size %lu", (unsigned long)[dataImage length]);
    base64String = [dataImage base64EncodedStringWithOptions:0];
    //    NSLog(@"%@", base64String);
    
    profileImg.layer.cornerRadius = profileImg.frame.size.width / 2;
    profileImg.clipsToBounds = YES;
    
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




@end
