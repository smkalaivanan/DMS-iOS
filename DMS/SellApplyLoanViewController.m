//
//  SellApplyLoanViewController.m
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SellApplyLoanViewController.h"
#import "ApplyLoanTableViewCell.h"
#import "SellQueriesViewController.h"
#import "SellAuctionViewController.h"
#import "SellPostingViewController.h"
#import "DashboardCollectionViewCell.h"
#import "InventoryViewController.h"
#import "AddLoanViewController.h"
#import "ApplyLoanDetailViewController.h"


@interface SellApplyLoanViewController ()
{
    NSDictionary * sellApplyDict;
}
@end

@implementation SellApplyLoanViewController
@synthesize sellApplyTabel;

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
    
    [sellApplyTabel dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self callMakeid];
            [weakSelf.sellApplyTabel dg_stopLoading];
        });
    }
                                               loadingView:loadingView];
    
    [sellApplyTabel dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    
    [sellApplyTabel dg_setPullToRefreshBackgroundColor:sellApplyTabel.backgroundColor];

}

-(IBAction)showLeftMenuPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"viewloanpage",@"page_name", nil];
    [ObjShared callWebServiceWith_DomainName:@"viewapplyloan_list" postData:para];
}
#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[sellApplyDict valueForKey:@"loan_list"] count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ApplyLoanTableViewCell";
    
    ApplyLoanTableViewCell * loan =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    loan.selectionStyle = UITableViewCellSelectionStyleNone;
    
    loan.customerName.text=[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"customername"]objectAtIndex:indexPath.row];
    loan.customerEmail.text=[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"customermailid"]objectAtIndex:indexPath.row];
    loan.customerNumber.text=[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"customermobileno"]objectAtIndex:indexPath.row];
    loan.customerStatus.text=[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"status" ] objectAtIndex:indexPath.row];
    
    if ([[NSString stringWithFormat:@"%@",[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"status" ] objectAtIndex:indexPath.row]] isEqualToString:@"COMPLETED"])
    {
        loan.customerStatus.textColor = [UIColor greenColor];
    }
    else if ([[NSString stringWithFormat:@"%@",[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"status" ] objectAtIndex:indexPath.row]] isEqualToString:@"INPROGRESS"])
    {
        loan.customerStatus.textColor = [UIColor grayColor];
    }
    else
    {
        loan.customerStatus.textColor = [UIColor redColor];
    }
    
    [loan.customerImage setImageWithURL:[NSURL URLWithString:[[[sellApplyDict valueForKey:@"loan_list"] valueForKey:@"bankimage" ] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return loan;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ObjShared.sellApplyFundingDict = [[sellApplyDict valueForKey:@"loan_list"] objectAtIndex:indexPath.row];
    NSLog(@"obj share ---> %@",ObjShared.sellApplyFundingDict);
    ApplyLoanDetailViewController *applyDetailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ApplyLoanDetailViewController"];
    [[self navigationController] pushViewController:applyDetailVC animated:NO];
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
    
    if (indexPath.row == 4)
    {
        cell.footIcon.image=[UIImage imageNamed:@"loan-white.png"];
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
-(IBAction)AddButton:(id)sender
{
    AddLoanViewController *addLoanVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddLoanViewController"];
    [[self navigationController] pushViewController:addLoanVC animated:NO];
    
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        sellApplyDict= dict;
        [sellApplyTabel reloadData];
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

-(void)dealloc
{
    [sellApplyTabel dg_removePullToRefresh];
}

@end
