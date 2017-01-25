//
//  ApplyLoanDetailViewController.m
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "ApplyLoanDetailViewController.h"
#import "ApplyLoanDetailTableViewCell.h"
#import "SellApplyLoanViewController.h"
#import "SellQueriesViewController.h"
#import "SellAuctionViewController.h"
#import "SellPostingViewController.h"
#import "DashboardCollectionViewCell.h"
#import "InventoryViewController.h"

@interface ApplyLoanDetailViewController ()
{
    NSDictionary * revokeDict;
    NSMutableDictionary * tableData;
}
@end

@implementation ApplyLoanDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObjShared = [SharedClass sharedInstance];
    
    statusLabel.text = [ObjShared.sellApplyFundingDict objectForKey:@"status"];
    
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    tableData = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.sellApplyFundingDict valueForKey:@"tokenid"],@"Token Id",[ObjShared.sellApplyFundingDict valueForKey:@"customername"],@"Customer",[ObjShared.sellApplyFundingDict valueForKey:@"customermobileno"],@"Mobile",[ObjShared.sellApplyFundingDict valueForKey:@"customermailid"],@"Email",[ObjShared.sellApplyFundingDict valueForKey:@"amount"],@"Amount",[ObjShared.sellApplyFundingDict valueForKey:@"date"],@"Date", nil];
    
    if ([[ObjShared.sellApplyFundingDict valueForKey:@"status"] isEqualToString:@"COMPLETED"])
    {
        statusLabel.textColor = [UIColor greenColor];
        redLabel.hidden = YES;
    }
    else if ([[ObjShared.sellApplyFundingDict valueForKey:@"status"] isEqualToString:@"REVOKE"] || [[ObjShared.sellApplyFundingDict valueForKey:@"status"] isEqualToString:@"DISMISS"])
    {
        statusLabel.textColor = [UIColor redColor];
        redLabel.hidden = YES;
    }
    else if([[ObjShared.sellApplyFundingDict valueForKey:@"status"] isEqualToString:@"INPROGRESS"])
    {
        statusLabel.textColor = [UIColor grayColor];
    }
    else
    {
        statusLabel.textColor = [UIColor redColor];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[ObjShared.sellApplyFundingDict objectForKey:@"ticket_id"],@"ticketid", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_revoke_funding" postData:para];
    NSLog(@"param -----> %@",para);
}
-(IBAction)revokeAction:(id)sender
{
    [self callMakeid];
}
-(IBAction)backButton:(id)sender
{
    [[self navigationController] popViewControllerAnimated:NO];
}
#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableData allKeys].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ApplyLoanDetailTableViewCell";
    
    ApplyLoanDetailTableViewCell * applyLoan =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    applyLoan.selectionStyle = UITableViewCellSelectionStyleNone;
    
    applyLoan.applyLoanUserKey.text = [NSString stringWithFormat:@"%@ :",[[tableData allKeys] objectAtIndex:indexPath.row]];
    applyLoan.applyLoanUserDetail.text = [NSString stringWithFormat:@"%@",[[tableData allValues] objectAtIndex:indexPath.row]];
    
    return applyLoan;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.footerArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.inventoryFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 4)
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
        [AppDelegate showAlert:@"Alert !!" withMessage:[revokeDict valueForKey:@"message"]];
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
