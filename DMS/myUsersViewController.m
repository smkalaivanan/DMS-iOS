//
//  myUsersViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "myUsersViewController.h"
#import "EdituserViewController.h"

@interface myUsersViewController ()
{
    NSMutableArray *rightUtilityButton;
    NSDictionary * myuserDict;
}
@end

@implementation myUsersViewController
@synthesize userTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self HMSegmentTagController];
    rightUtilityButton = [NSMutableArray new];

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
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"viewuserlist",@"page_name", nil];
    [ObjShared callWebServiceWith_DomainName:@"api_view_user" postData:para];
    NSLog(@"para ----> %@",para);
}
-(void)HMSegmentTagController
{
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // Minimum code required to use the segmented control with the default styling.
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Trending", @"News", @"Library",@"Trending"]];
    segmentedControl.frame = CGRectMake(0, 0, viewWidth, segmentViewButton.frame.size.height);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl.backgroundColor = UIColorFromRGB(0X173E84);
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    [segmentViewButton addSubview:segmentedControl];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

-(IBAction)sidemMenu:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ObjShared.manageFooterText count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.footIcon.image = [UIImage imageNamed:[ObjShared.manageFooterArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [ObjShared.manageFooterText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 3)
    {
        cell.footIcon.image=[UIImage imageNamed:@"user-white.png"];
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
        profileViewController *profileVC =[self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
        [[self navigationController] pushViewController:profileVC animated:NO];
        
    }
    else if (indexPath.row==1)
    {
        myBranchesViewController *branchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myBranchesViewController"];
        [[self navigationController] pushViewController:branchVC animated:NO];
    }
    else if (indexPath.row==2)
    {
        myContactViewController *contactVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myContactViewController"];
        [[self navigationController] pushViewController:contactVC animated:NO];
    }
    else if (indexPath.row==3)
    {
        myUsersViewController *userVC =[self.storyboard instantiateViewControllerWithIdentifier:@"myUsersViewController"];
        [[self navigationController] pushViewController:userVC animated:NO];
    }
    else if (indexPath.row==4)
    {
        subscriptionViewController *subVC =[self.storyboard instantiateViewControllerWithIdentifier:@"subscriptionViewController"];
        [[self navigationController] pushViewController:subVC animated:NO];
    }
    
    NSLog(@"selected");
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}

#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[myuserDict valueForKey:@"branch_list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"myUserTableViewCell";
    
    myUserTableViewCell *userCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    userCell.userId.text = [NSString stringWithFormat:@"%@",[[[myuserDict valueForKey:@"branch_list"] valueForKey:@"branch_id"] objectAtIndex:indexPath.row]];
    userCell.role.text = [NSString stringWithFormat:@"%@",[[[myuserDict valueForKey:@"branch_list"] valueForKey:@"user_email"] objectAtIndex:indexPath.row]];
    userCell.branch.text = [[[myuserDict valueForKey:@"branch_list"] valueForKey:@"user_role"] objectAtIndex:indexPath.row];
    
    [rightUtilityButton sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.008f green:0.208f blue:0.569f alpha:1.0f]
                                            icon:[UIImage imageNamed:@"edit-50x50.png"]];
    [rightUtilityButton sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.020f green:0.263f blue:0.706f alpha:1.0f]
                                                icon:[UIImage imageNamed:@"edit-50x50.png"]];
    userCell.rightUtilityButtons = rightUtilityButton;
    userCell.delegate = self;
    
    return userCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}
-(void)headerBuyButton:(UIButton *)sender
{
    NSLog(@"action performed");
}
-(IBAction)add:(id)sender
{
    EdituserViewController *userVC =[self.storyboard instantiateViewControllerWithIdentifier:@"EdituserViewController"];
    [[self navigationController] pushViewController:userVC animated:NO];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            // Delete button is pressed
            NSLog(@"Edit");
            break;
        }
        case 1:
        {
            // Delete button is pressed
            NSLog(@"Delete");
            break;
        }
        default:
            break;
    }
}
#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        myuserDict = dict;
        [userTableView reloadData];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Alert!" withMessage:[dict valueForKey:@"message"]];
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
