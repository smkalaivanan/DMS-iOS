//
//  profileViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "profileViewController.h"
#import "ChangePasswordViewController.h"
#import "AppDelegate.h"

@interface profileViewController ()
{
    NSString *base64String;
    NSUserDefaults *defaults;
    AppDelegate *appDelegate;
}
@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults  = [NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    save.hidden=YES;
    ObjShared.manageFooterArray = [[NSArray alloc] initWithObjects:@"profile-blue.png",
                   @"branches-blue.png",
                   @"contact-blue.png",
                   @"user-blue.png",
                   @"sub-blue.png",nil];
    
    ObjShared.manageFooterText = [[NSArray alloc] initWithObjects:@"Profile",
                                  @"Branches",
                                  @"Contact",
                                  @"Users",
                                  @"Subscription",nil];
    
    email.userInteractionEnabled = NO;
    profileName.userInteractionEnabled = NO;
    passoword.userInteractionEnabled = NO;
    phone.userInteractionEnabled = NO;
    imgPicker.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    //asigning data from delegate
    [profileImg setImageWithURL:[NSURL URLWithString:[[defaults valueForKey:@"login_dict"]valueForKey:@"dealer_img"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    profileName.text=[[defaults valueForKey:@"login_dict"]valueForKey:@"dealer_name"];
    email.text=[[defaults valueForKey:@"login_dict"]valueForKey:@"dealer_email"];
    phone.text=[[defaults valueForKey:@"login_dict"]valueForKey:@"dealer_mobile"];
    
    save.layer.cornerRadius = 10;
    save.layer.masksToBounds = YES;
    profileImg.layer.cornerRadius = profileImg.frame.size.width / 2;
    profileImg.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (indexPath.row == 0)
    {
        cell.footIcon.image=[UIImage imageNamed:@"profile-white.png"];
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
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",profileName.text,@"delaer_name",phone.text,@"mobile_number",base64String,@"profile_image", nil];
    [ObjShared callWebServiceWith_DomainName:@"edit_account" postData:para];
}
-(IBAction)edit:(id)sender
{
    edit.hidden=YES;
    save.hidden=NO;
    imgPicker.hidden=NO;
    profileName.userInteractionEnabled=YES;
    phone.userInteractionEnabled=YES;
}

-(IBAction)sidemMenu:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
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
    base64String = [dataImage base64EncodedStringWithOptions:0];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)changePassword:(id)sender
{
    ChangePasswordViewController *changeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [SharedClass NavigateTo:changeVC inNavigationViewController:appDelegate.navigationController animated:YES];
}
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        edit.hidden=NO;
        save.hidden=YES;
        imgPicker.hidden=YES;
        profileName.userInteractionEnabled=NO;
        phone.userInteractionEnabled=NO;
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
