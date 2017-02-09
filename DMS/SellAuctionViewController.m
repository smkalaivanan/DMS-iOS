//
//  SellAuctionViewController.m
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//
#import "SellAuctionViewController.h"
#import "SellAuctionTableViewCell.h"
#import "SellPostingViewController.h"
#import "DashboardCollectionViewCell.h"
#import "SellQueriesViewController.h"
#import "SellApplyLoanViewController.h"
#import "InventoryViewController.h"

@interface SellAuctionViewController ()

@end

@implementation SellAuctionViewController
@synthesize autionTable;

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
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    [autionTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.autionTable dg_stopLoading];
        });
    }
                                               loadingView:loadingView];
    
    [autionTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    
    [autionTable dg_setPullToRefreshBackgroundColor:autionTable.backgroundColor];

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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"SellAuctionTableViewCell";
    
    SellAuctionTableViewCell * auction =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    auction.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return auction;
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
    
    if (indexPath.row == 2)
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
        InventoryViewController *inventVC =[self.storyboard instantiateViewControllerWithIdentifier:@"InventoryViewController"];
        [[self navigationController] pushViewController:inventVC animated:NO];
    }
    else if (indexPath.row==1)
    {
        SellPostingViewController *postingVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SellPostingViewController"];
        [[self navigationController] pushViewController:postingVC animated:NO];
    }
    else if (indexPath.row==2)
    {
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
-(void)dealloc
{
    [autionTable dg_removePullToRefresh];
}



@end
