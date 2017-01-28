//
//  SellPostingViewController.m
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SellPostingViewController.h"
#import "SellPostingTableViewCell.h"
#import "DashboardCollectionViewCell.h"
#import "SellAuctionViewController.h"
#import "SellQueriesViewController.h"
#import "SellApplyLoanViewController.h"
#import "InventoryViewController.h"

@interface SellPostingViewController ()

@end

@implementation SellPostingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObjShared = [SharedClass sharedInstance];
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
-(IBAction)showLeftMenuPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"viewmypost",@"page_name", nil];
    [ObjShared callWebServiceWith_DomainName:@"view_mypost_list" postData:para];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableView-Sample

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[postingDict valueForKey:@"myposting_list"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"SellPostingTableViewCell";
    
    SellPostingTableViewCell * post =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    post.selectionStyle = UITableViewCellSelectionStyleNone;
    
    post.titleLabel.text = [[[postingDict valueForKey:@"myposting_list"] valueForKey:@"model"] objectAtIndex:indexPath.row];
    post.priceLabel.text = [NSString stringWithFormat:@"₹ %@",[[[postingDict valueForKey:@"myposting_list"] valueForKey:@"price"] objectAtIndex:indexPath.row]];
    post.kilometerLabel.text =[NSString stringWithFormat:@"%@ Km|%@|%@|%@",
                               [[[postingDict valueForKey:@"myposting_list"] valueForKey:@"kms"] objectAtIndex:indexPath.row],
                               [[[postingDict valueForKey:@"myposting_list"] valueForKey:@"fuel_type"] objectAtIndex:indexPath.row],
                               [[[postingDict valueForKey:@"myposting_list"] valueForKey:@"year"] objectAtIndex:indexPath.row],
                               [[[postingDict valueForKey:@"myposting_list"] valueForKey:@"owner"] objectAtIndex:indexPath.row]];
    
    post.dateLabel.text =[NSString stringWithFormat:@"%@",[[[postingDict valueForKey:@"myposting_list"] valueForKey:@"mongopushdate"] objectAtIndex:indexPath.row]];
    
    [post.postingImage setImageWithURL:[NSURL URLWithString:[[[postingDict valueForKey:@"myposting_list"] valueForKey:@"imageurl"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return post;
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
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.inventoryFooterArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.inventoryFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 1)
    {
        cell.footIcon.image=[UIImage imageNamed:@"myposting-white.png"];
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
        SellApplyLoanViewController *loanVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SellApplyLoanViewController"];
        [[self navigationController] pushViewController:loanVC animated:NO];
        
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}
#pragma mark -W.S Delegate Call
- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]]isEqualToString:@"1"])
    {
        postingDict=dict;
        
        [sellPostingtable reloadData];
    }
    else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Alert !!" withMessage:[postingDict valueForKey:@"message"]];
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
