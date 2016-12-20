//
//  ApplyFundingViewController.m
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "MyQueriesViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "DashboardViewController.h"
#import "ApplyFundingTableViewCell.h"
#import "MFSideMenu.h"
#import "AddFundingViewController.h"
#import "FundingDetailViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ApplyFundingViewController ()

@end

@implementation ApplyFundingViewController

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
    
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"make", nil];
    [ObjShared callWebServiceWith_DomainName:@"apibuyid" postData:para];
}
-(IBAction)side:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}
-(IBAction)add:(id)sender
{
    AddFundingViewController *addVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddFundingViewController"];
    [[self navigationController] pushViewController:addVC animated:YES];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"ApplyFundingTableViewCell";
    
    ApplyFundingTableViewCell *fundingCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    return fundingCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
    FundingDetailViewController *fundVC =[self.storyboard instantiateViewControllerWithIdentifier:@"FundingDetailViewController"];
    [[self navigationController] pushViewController:fundVC animated:YES];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
