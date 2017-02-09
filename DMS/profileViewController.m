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
#import "ProfileTableViewCell.h"

@interface profileViewController ()
{
    NSString *base64String;
    NSUserDefaults *defaults;
    AppDelegate *appDelegate;
    ProfileTableViewCell * profileTableCell;
    UIImage *chosenimage;
}
@property(nonatomic,retain)IBOutlet UITableView * proTable;
@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults  = [NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    ObjShared.manageFooterArray = [[NSArray alloc] initWithObjects:@"profile-blue.png",
                   @"branches-blue.png",
                   @"contact-blue.png",
                   @"user-blue.png",
                   @"sub-blue.png",nil];
    
    ObjShared.manageFooterText = [[NSArray alloc] initWithObjects:@"Profile",
                                  @"Branches",
                                  @"Contacts",
                                  @"Users",
                                  @"Subscription",nil];
    
    profileTableCell.email.userInteractionEnabled = NO;
    profileTableCell.profileName.userInteractionEnabled = NO;
    profileTableCell.passoword.userInteractionEnabled = NO;
    profileTableCell.phone.userInteractionEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    profileTableCell.save.layer.cornerRadius = 10;
    profileTableCell.save.layer.masksToBounds = YES;
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [_proTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_proTable reloadData];
            profileTableCell.edit.hidden=NO;
            [weakSelf.proTable dg_stopLoading];
        });
    }
    loadingView:loadingView];
    [_proTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    [_proTable dg_setPullToRefreshBackgroundColor:_proTable.backgroundColor];
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
-(void)base64Converter
{
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

-(void)save:(UIButton *)sender
{
    [self base64Converter];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",profileTableCell.profileName.text,@"delaer_name",profileTableCell.phone.text,@"mobile_number",base64String,@"profile_image",@"updateprofile",@"page_name", nil];
    [ObjShared callWebServiceWith_DomainName:@"edit_account" postData:para];
    
    NSLog(@"para ----> %@",para);
}

-(void)edit:(UIButton *)sender
{
    profileTableCell.edit.hidden=YES;
    profileTableCell.save.hidden=NO;
    profileTableCell.imgPicker.hidden=NO;
    profileTableCell.profileName.userInteractionEnabled=YES;
    profileTableCell.phone.userInteractionEnabled=YES;
}

-(IBAction)sidemMenu:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)pic:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.allowsEditing= NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chosenimage = info[UIImagePickerControllerOriginalImage];
    profileTableCell.profileImg.image = chosenimage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)changePassword:(UIButton *)sender
{
    ChangePasswordViewController *changeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [SharedClass NavigateTo:changeVC inNavigationViewController:appDelegate.navigationController animated:YES];
}
#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ProfileTableViewCell";
    
    profileTableCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    profileTableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [profileTableCell.save addTarget:self
                         action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [profileTableCell.imgPicker addTarget:self
                              action:@selector(pic:) forControlEvents:UIControlEventTouchUpInside];
    [profileTableCell.chgPassword addTarget:self
                                   action:@selector(changePassword:) forControlEvents:UIControlEventTouchUpInside];
    [profileTableCell.edit addTarget:self
                                     action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    profileTableCell.save.hidden = YES;
    profileTableCell.imgPicker.hidden = YES;
    
    //asigning data from delegate
    profileTableCell.profileImg.layer.cornerRadius = profileTableCell.profileImg.frame.size.width / 2;
    profileTableCell.profileImg.layer.masksToBounds = YES;
    [profileTableCell.profileImg setImageWithURL:[NSURL URLWithString:[ObjShared.LoginDict valueForKey:@"dealer_img"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    profileTableCell.profileName.text=[ObjShared.LoginDict valueForKey:@"dealer_name"];
    profileTableCell.email.text=[ObjShared.LoginDict valueForKey:@"dealer_email"];
    profileTableCell.phone.text=[ObjShared.LoginDict valueForKey:@"dealer_mobile"];
    
    return profileTableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _proTable.frame.size.height-5;
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        profileTableCell.edit.hidden=NO;
        profileTableCell.save.hidden=YES;
        profileTableCell.imgPicker.hidden=YES;
        profileTableCell.profileName.userInteractionEnabled=NO;
        profileTableCell.phone.userInteractionEnabled=NO;
        
        ObjShared.LoginDict=dict;
        NSLog(@"login page--->%@",ObjShared.LoginDict);
        defaults  = [NSUserDefaults standardUserDefaults];
        [defaults setObject:ObjShared.LoginDict forKey:@"login_dict"];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateProfile" object: nil];
        
        [_proTable reloadData];
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

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    picker.showsCameraControls = NO;
    [self presentViewController:picker animated:YES
                     completion:^ {
                         [picker takePicture];
                     }];
}

-(void)dealloc
{
    [self.proTable dg_removePullToRefresh];
}


@end
