//
//  AddBranchesViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "AddBranchesViewController.h"
#import "SelectCityViewController.h"

@interface AddBranchesViewController ()
@end

@implementation AddBranchesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    ObjShared.Cityname=@"Select City";
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

    if (ObjShared.editBranch == 1)
    {
        dealerName.text=[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"dealer_name"]];
        email.text=[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"dealer_mail"]];
        phone.text=[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"dealer_contact_no"]];
        pincode.text=[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"dealer_pincode"]];
        address.text=[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"branch_address"]];
        [city setTitle:[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"dealer_city"]]forState:UIControlStateNormal];
    }
    
    [city setTitle:ObjShared.Cityname forState:UIControlStateNormal];
    save.layer.cornerRadius = 10;
    save.layer.masksToBounds = YES;
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
    
    if (indexPath.row == 1)
    {
        cell.footIcon.image=[UIImage imageNamed:@"branches-white.png"];
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
    if (dealerName.text.length == 0 )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the Dealer Name"];

    }
    else if (address.text.length == 0 )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the Address"];
        
    }
    else if ([city.titleLabel.text isEqualToString:@"City"] )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the City"];
        
    }
    else if (pincode.text.length == 0 )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the Pincode"];
        
    }
    else if (email.text.length == 0 )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the Email-Id"];
        
    }
    else if (phone.text.length == 0 )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the Phone Number"];
        
    }
    else if (phone.text.length == 0 )
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please Enter the Phone Number"];
        
    }
    else if(ObjShared.editBranch ==0)
    {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"addbranch",@"page_name",dealerName.text,@"dealer_name",phone.text,@"mobilenumber",address.text,@"branch_address",ObjShared.stateId,@"dealer_state",city.titleLabel.text,@"dealer_city",pincode.text,@"dealer_pincode",email.text,@"dealer_mail", nil];
        
        NSLog(@"para--->%@",para);
        [ObjShared callWebServiceWith_DomainName:@"api_add_branch" postData:para];
    }
    else if (ObjShared.editBranch ==1)
    {
        NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"editbranch",@"page_name",dealerName.text,@"dealer_name",phone.text,@"mobilenumber",address.text,@"branch_address",ObjShared.stateId,@"dealer_state",city.titleLabel.text,@"dealer_city",pincode.text,@"dealer_pincode",email.text,@"dealer_mail",[NSString stringWithFormat:@"%@",[ObjShared.branchArray valueForKey:@"branch_id"]],@"branchid", nil];
        NSLog(@"para--->%@",para);
        [ObjShared callWebServiceWith_DomainName:@"api_edit_branch" postData:para];
    }
}

-(IBAction)city:(id)sender
{
    [city setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SelectCityViewController *cityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];
    [self presentViewController:cityVC animated:NO completion: nil];
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict valueForKey:@"Result"]isEqualToString:@"1"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([[dict valueForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"No Records" withMessage:[dict valueForKey:@"message"]];
    }
    else if (![[NSString stringWithFormat:@"%@",[dict valueForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {
        
    }
}
- (void)failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}


@end
