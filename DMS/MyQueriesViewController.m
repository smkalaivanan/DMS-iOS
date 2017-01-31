//
//  MyQueriesViewController.m
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "MyQueriesViewController.h"
#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "DashboardViewController.h"
#import "MyQueriesTableViewCell.h"
#import "MFSideMenu.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface MyQueriesViewController ()
{
    NSDictionary * queriesDict;
}
@end

@implementation MyQueriesViewController
@synthesize queriesTable;

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
    [self callMakeid];
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    [queriesTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self callMakeid];
            [weakSelf.queriesTable dg_stopLoading];
        });
    }
                                        loadingView:loadingView];
    
    [queriesTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    
    [queriesTable dg_setPullToRefreshBackgroundColor:queriesTable.backgroundColor];

}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_queries_car" postData:para];
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
    
    if (indexPath.row == 2)
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
    return [[queriesDict valueForKey:@"queries_list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"MyQueriesTableViewCell";
    
    MyQueriesTableViewCell *queriesCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    queriesCell.selectionStyle = UITableViewCellSelectionStyleNone;

    [queriesCell.carImg setImageWithURL:[NSURL URLWithString:[[[queriesDict valueForKey:@"queries_list"] valueForKey:@"imagelink"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [queriesCell.dealerImg setImageWithURL:[NSURL URLWithString:[ObjShared.LoginDict objectForKey:@"dealer_img"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    queriesCell.dealerName.text = [[[queriesDict  valueForKey:@"queries_list"] valueForKey:@"dealer_name"]objectAtIndex:indexPath.row];
    
    queriesCell.carName.text = [[[queriesDict valueForKey:@"queries_list"] valueForKey:@"title"]objectAtIndex:indexPath.row];
    
    queriesCell.msg.text = [[[queriesDict valueForKey:@"queries_list"] valueForKey:@"message"]objectAtIndex:indexPath.row];
    
    queriesCell.time.text = [[[queriesDict valueForKey:@"queries_list"] valueForKey:@"Time"] objectAtIndex:indexPath.row];
    
    queriesCell.carImg.layer.cornerRadius = queriesCell.carImg.frame.size.width /2;
    queriesCell.carImg.layer.masksToBounds = YES;
    
    queriesCell.dealerImg.layer.cornerRadius = queriesCell.dealerImg.frame.size.width /2;
    queriesCell.dealerImg.layer.masksToBounds = YES;
    
    return queriesCell;
    
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
        queriesDict= dict;
        [queriesTable reloadData];
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
