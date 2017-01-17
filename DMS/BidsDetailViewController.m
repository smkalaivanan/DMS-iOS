//
//  BidsDetailViewController.m
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "BidsDetailViewController.h"
#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "MyQueriesViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "DashboardViewController.h"
#import "BidDetailTableViewCell.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BidsDetailViewController ()
{
    NSDictionary * bidDetailDict;
}
@end

@implementation BidsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ObjShared = [SharedClass sharedInstance];

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
    
    carName.text = [ObjShared.bidCaridDetail valueForKey:@"make"];
    
    [carImage setImageWithURL:[NSURL URLWithString:[ObjShared.bidCaridDetail valueForKey:@"imagelink"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    delarName.text = [ObjShared.LoginDict valueForKey:@"dealer_name"];

    [delarImage setImageWithURL:[NSURL URLWithString:[ObjShared.LoginDict valueForKey:@"dealer_img"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    delarImage.layer.cornerRadius = delarImage.frame.size.width /2;
    delarImage.layer.masksToBounds = YES;
    
    carImage.layer.cornerRadius = carImage.frame.size.width /2;
    carImage.layer.masksToBounds = YES;
    
    [self callMakeid];
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[ObjShared.bidCaridDetail valueForKey:@"car_id"],@"car_id", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_bidding_viewmore" postData:para];
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
    return [[bidDetailDict valueForKey:@"dealer_bid_list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BidDetailTableViewCell";
    
    BidDetailTableViewCell *bidCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    bidCell.selectionStyle = UITableViewCellSelectionStyleNone;

    bidCell.name.text = [[[bidDetailDict valueForKey:@"dealer_bid_list"] valueForKey:@"Dealername"] objectAtIndex:indexPath.row];
    
    bidCell.price.text = [[[bidDetailDict valueForKey:@"dealer_bid_list"] valueForKey:@"Amount"] objectAtIndex:indexPath.row];
    
    bidCell.time.text = [[[bidDetailDict valueForKey:@"dealer_bid_list"] valueForKey:@"Date"] objectAtIndex:indexPath.row];
    
    return bidCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}

-(IBAction)bidButton:(id)sender
{
    [self.view endEditing:YES];
    
    NSString * bidValueString = [NSString stringWithFormat:@"Your bid value is ₹ %@",bidText.text];
    
    if (bidText.text.length == 0)
    {
        [AppDelegate showAlert:@"Bidding !!" withMessage:@"Your bid amount can't be empty"];
    }
    else
    {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Bidding!!" message:bidValueString preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                            actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    
    [alertController addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",bidText.text,@"biddingamount",[ObjShared.bidCaridDetail valueForKey:@"car_id"],@"car_id",[ObjShared.bidCaridDetail valueForKey:@"dealer_id"],@"dealerid", nil];
                                   NSLog(@"bid param ----> %@",param);
                                   bidText.text=@"";
                                   [ObjShared callWebServiceWith_DomainName:@"api_addbidding_viewmore" postData:param];
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(IBAction)backButton:(id)sender
{
    [self.view endEditing:YES];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        bidDetailDict= dict;
        [bidDetailtable reloadData];
        delarPosition.text = [NSString stringWithFormat:@"%@",[bidDetailDict valueForKey:@"Position"]];
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
