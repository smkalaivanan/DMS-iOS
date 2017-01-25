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
    
    save.hidden=YES;
    
    ObjShared.footerArray = [[NSArray alloc] initWithObjects:@"search-white.png",
                   @"savecar-blue.png",
                   @"queries-blue.png",
                   @"bids-blue.png",
                   @"funding-blue.png",nil];
    
    ObjShared.manageFooterText = [[NSArray alloc] initWithObjects:@"Profile",
                                  @"Branches",
                                  @"Contact",
                                  @"Users",
                                  @"Subscription",nil];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    defaults  = [NSUserDefaults standardUserDefaults];

    [profileImg setImageWithURL:[NSURL URLWithString:[defaults valueForKey:@"dealer_img"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    profileName.text=[defaults valueForKey:@"dealerName"];
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
    edit.hidden=NO;
    save.hidden=YES;
    imgPicker.hidden=YES;
    profileName.userInteractionEnabled=NO;
    email.userInteractionEnabled=NO;
    passoword.userInteractionEnabled=NO;
    phone.userInteractionEnabled=NO;
}
-(IBAction)edit:(id)sender
{
    save.hidden=NO;
    edit.hidden=YES;
    imgPicker.hidden=YES;
    profileName.userInteractionEnabled=YES;
    email.userInteractionEnabled=YES;
    passoword.userInteractionEnabled=YES;
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

-(IBAction)changePassword:(id)sender
{
    ChangePasswordViewController *changeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    
    [SharedClass NavigateTo:changeVC inNavigationViewController:appDelegate.navigationController animated:YES];

}

@end
