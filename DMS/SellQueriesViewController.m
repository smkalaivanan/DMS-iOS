//
//  SellQueriesViewController.m
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SellQueriesViewController.h"
#import "QueriesTableViewCell.h"
#import "SellAuctionViewController.h"
#import "SellPostingViewController.h"
#import "DashboardCollectionViewCell.h"
#import "SellApplyLoanViewController.h"
#import "InventoryViewController.h"

@interface SellQueriesViewController ()

@end

@implementation SellQueriesViewController
@synthesize sellQueriesTable;

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
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    [sellQueriesTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self callMakeid];
            [weakSelf.sellQueriesTable dg_stopLoading];
        });
    }
                                          loadingView:loadingView];
    
    [sellQueriesTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    
    [sellQueriesTable dg_setPullToRefreshBackgroundColor:sellQueriesTable.backgroundColor];

}
-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_queries_received" postData:para];
}
-(IBAction)showLeftMenuPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
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
    return [[sellQueriesDict valueForKey:@"mysellqueries"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"QueriesTableViewCell";
    
    QueriesTableViewCell * query =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    query.selectionStyle = UITableViewCellSelectionStyleNone;
    
    query.customerName.text=[[[sellQueriesDict valueForKey:@"mysellqueries"] valueForKey:@"dealer_name"] objectAtIndex:indexPath.row];
    query.carModel.text=[[[sellQueriesDict valueForKey:@"mysellqueries"] valueForKey:@"make"] objectAtIndex:indexPath.row];
    query.timeAgo.text=[[[sellQueriesDict valueForKey:@"mysellqueries"] valueForKey:@"days"] objectAtIndex:indexPath.row];
    query.customerMessage.text=[[[sellQueriesDict valueForKey:@"mysellqueries"] valueForKey:@"message"] objectAtIndex:indexPath.row];

    [query.customerImage setImageWithURL:[NSURL URLWithString:[[[sellQueriesDict valueForKey:@"mysellqueries"] valueForKey:@"imagelink"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    query.customerImage.layer.cornerRadius = query.customerImage.frame.size.width/2;
    query.customerImage.layer.masksToBounds = YES;

    return query;
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
    
    if (indexPath.row == 3)
    {
        cell.footIcon.image=[UIImage imageNamed:@"queries-white.png"];
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
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        sellQueriesDict= dict;
        [sellQueriesTable reloadData];
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
