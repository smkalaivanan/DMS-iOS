//
//  FundingDetailViewController.m
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "FundingDetailViewController.h"
#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "MyQueriesViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "DashboardViewController.h"
#import "FundingDetailTableViewCell.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface FundingDetailViewController ()
{
    NSDictionary * revokeDict;
}
@end

@implementation FundingDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjShared = [SharedClass sharedInstance];
    
    
    NSLog(@"status label ----> %@",statusLabel.text);
    // Corner Radius for Enter button
    revokeButton.layer.cornerRadius = 10;
    revokeButton.layer.masksToBounds = NO;
    revokeButton.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    revokeButton.layer.shadowOpacity = 0.2;
    revokeButton.layer.shadowRadius = 2;
    revokeButton.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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
    
    //    0 PENDING
    //    1 INPROGRESS
    //    2 COMPLETED
    //    3 DISMISS
    //    4 REVOKE
    
    if ([[NSString stringWithFormat:@"%@",[ObjShared.applyFundingPageDict objectForKey:@"Status"]] isEqualToString: @"PENDING"])
    {
        statusLabel.text = @"PENDING";
        statusLabel.textColor = [UIColor redColor];
    }
    else if ([[NSString stringWithFormat:@"%@",[ObjShared.applyFundingPageDict objectForKey:@"Status"]] isEqualToString: @"INPROGRESS"])
    {
        statusLabel.text = @"INPROGRESS";
    }
    else if ([[NSString stringWithFormat:@"%@",[ObjShared.applyFundingPageDict objectForKey:@"Status"]] isEqualToString: @"COMPLETED"])
    {
        statusLabel.text = @"COMPLETED";
        statusLabel.textColor = [UIColor greenColor];
        revokeButton.hidden = YES;
    }
    else if ([[NSString stringWithFormat:@"%@",[ObjShared.applyFundingPageDict objectForKey:@"Status"]] isEqualToString: @"DISMISS"])
    {
        statusLabel.text = @"DISMISSED";
        revokeButton.hidden = YES;
    }
    else if ([[NSString stringWithFormat:@"%@",[ObjShared.applyFundingPageDict objectForKey:@"Status"]] isEqualToString: @"REVOKE"])
    {
        statusLabel.text = @"REVOKED";
        revokeButton.hidden = YES;
    }
}
-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[ObjShared.applyFundingPageDict objectForKey:@"Token"],@"ticketid", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_revoke_funding" postData:para];
    NSLog(@"param -----> %@",para);
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)revokeAction:(id)sender
{
    [self callMakeid];
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


#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ObjShared.applyFundingPageDict allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"FundingDetailTableViewCell";
    
    FundingDetailTableViewCell *fundingCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    fundingCell.detail.text=[NSString stringWithFormat:@"%@ :",[[ObjShared.applyFundingPageDict allKeys] objectAtIndex:indexPath.row]];
    fundingCell.name.text=[NSString stringWithFormat:@"%@",[[ObjShared.applyFundingPageDict allValues] objectAtIndex:indexPath.row]];
    
    fundingCell.selectionStyle = UITableViewCellSelectionStyleNone;

    return fundingCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        revokeDict= dict;
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
