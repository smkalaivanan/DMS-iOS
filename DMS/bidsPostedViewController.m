//
//  bidsPostedViewController.m
//  DMS
//
//  Created by macbook on 10/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "bidsPostedViewController.h"
#import "ApplyFundingViewController.h"
#import "MyQueriesViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "DashboardViewController.h"
#import "BidPostedTableViewCell.h"
#import "MFSideMenu.h"
#import "BidsDetailViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface bidsPostedViewController ()
{
    NSDictionary * bidDict;
}
@end

@implementation bidsPostedViewController

- (void)viewDidLoad
{
    ObjShared = [SharedClass sharedInstance];
    
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
    [self callMakeid];
    
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_bidding_list" postData:para];
    
    NSLog(@"para -----> %@",para);
}

-(IBAction)side:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];

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
    
    if (indexPath.row == 3)
    {
        cell.footIcon.image=[UIImage imageNamed:@"bids-white.png"];
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
    return [[bidDict valueForKey:@"bidding_list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BidPostedTableViewCell";
    
    BidPostedTableViewCell *bidCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    bidCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [bidCell.carImg setImageWithURL:[NSURL URLWithString:[[[bidDict valueForKey:@"bidding_list"] valueForKey:@"imagelink"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
    [bidCell.dealerImg setImageWithURL:[NSURL URLWithString:[[[bidDict valueForKey:@"bidding_list"] valueForKey:@"site_image"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    bidCell.modelName.text = [[[bidDict valueForKey:@"bidding_list"] valueForKey:@"make"] objectAtIndex:indexPath.row];
    bidCell.price.text = [[[bidDict valueForKey:@"bidding_list"] valueForKey:@"bidded_amount"] objectAtIndex:indexPath.row];
    bidCell.closingTime.text = [[[bidDict valueForKey:@"bidding_list"] valueForKey:@"closing_time"] objectAtIndex:indexPath.row];
    bidCell.posted.text = [[[bidDict valueForKey:@"bidding_list"] valueForKey:@"posted"] objectAtIndex:indexPath.row];
    
    if ([[[[bidDict valueForKey:@"bidding_list"] valueForKey:@"bid_image"] objectAtIndex:indexPath.row] isEqualToString:@"bid-won.png"])
    {
        bidCell.stausMessage.layer.cornerRadius = 5;
        bidCell.stausMessage.layer.masksToBounds = YES;
        bidCell.stausMessage.layer.backgroundColor = [UIColor greenColor].CGColor;
        bidCell.stausMessage.text = @"Won";
        bidCell.stausMessage.textColor = [UIColor whiteColor];
    }
    else if ([[[[bidDict valueForKey:@"bidding_list"] valueForKey:@"bid_image"] objectAtIndex:indexPath.row] isEqualToString:@"bid-ongoing.png"])
    {
        bidCell.stausMessage.layer.cornerRadius = 5;
        bidCell.stausMessage.layer.masksToBounds = YES;
        bidCell.stausMessage.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        bidCell.stausMessage.text = @"Ongoing";
        bidCell.stausMessage.textColor = [UIColor blackColor];
    }
    else
    {
        bidCell.stausMessage.layer.cornerRadius = 5;
        bidCell.stausMessage.layer.masksToBounds = YES;
        bidCell.stausMessage.layer.backgroundColor = [UIColor redColor].CGColor;
        bidCell.stausMessage.text = @"Closed";
        bidCell.stausMessage.textColor = [UIColor whiteColor];
    }
    
    return bidCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
    
    ObjShared.bidCaridDetail = [[bidDict valueForKey:@"bidding_list"]objectAtIndex:indexPath.row];
    NSLog(@"bid detail ----> %@",ObjShared.bidCaridDetail);
    
    BidsDetailViewController *bidVC =[self.storyboard instantiateViewControllerWithIdentifier:@"BidsDetailViewController"];
    [[self navigationController] pushViewController:bidVC animated:YES];
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        bidDict= dict;
        [bidTable reloadData];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Alert !!" withMessage:[bidDict valueForKey:@"message"]];
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
