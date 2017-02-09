//
//  myContactViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "myContactViewController.h"
#import "EditContactViewController.h"
@interface myContactViewController ()
{
    NSMutableArray *contactType;
    NSString *typeId;
    NSDictionary *contactDict;
    
}
@end

@implementation myContactViewController
@synthesize contactTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contactType = [[NSMutableArray alloc]init];
    contactType = [[ObjShared.tagName valueForKey:@"dealer_contact_type"]valueForKey:@"contact_type"];
    typeId = @"1";

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ObjShared.editContact = 0;

    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    [self HMSegmentTagController];
    [self callMethod];

    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [contactTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [contactTable reloadData];
            [weakSelf.contactTable dg_stopLoading];
        });
    }
    loadingView:loadingView];
    [contactTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    [contactTable dg_setPullToRefreshBackgroundColor:contactTable.backgroundColor];
    
    
}

-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"viewcontactlist",@"page_name",typeId,@"contact_type", nil];
    
    NSLog(@"para--->%@",para);
    [ObjShared callWebServiceWith_DomainName:@"api_view_allcontact" postData:para];
}


-(void)HMSegmentTagController
{
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // Minimum code required to use the segmented control with the default styling.
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:contactType];
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

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    typeId=[NSString stringWithFormat:@"%ld",(long)segmentedControl.selectedSegmentIndex + 1 ];
    
    [self callMethod];
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl
{
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}



-(IBAction)sidemMenu:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(IBAction)add:(id)sender
{
    EditContactViewController *contactVC =[self.storyboard instantiateViewControllerWithIdentifier:@"EditContactViewController"];
    [[self navigationController] pushViewController:contactVC animated:NO];
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
    
    if (indexPath.row == 2)
    {
        cell.footIcon.image=[UIImage imageNamed:@"contact-white.png"];
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
    return [[[contactDict valueForKey:@"contact_list"] valueForKey:@"name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"EditTableViewCell";
    EditTableViewCell *editCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    editCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    editCell.dealerName.text=[[[contactDict valueForKey:@"contact_list"] valueForKey:@"name"] objectAtIndex:indexPath.row];
    editCell.email.text=[[[contactDict valueForKey:@"contact_list"] valueForKey:@"email"] objectAtIndex:indexPath.row];
    editCell.mobile.text=[[[contactDict valueForKey:@"contact_list"] valueForKey:@"mobilenum"] objectAtIndex:indexPath.row];
    editCell.place.text=[[[contactDict valueForKey:@"contact_list"] valueForKey:@"address"] objectAtIndex:indexPath.row];
    
    [editCell.userImg setImageWithURL:[NSURL URLWithString:[[[contactDict valueForKey:@"contact_list"] valueForKey:@"contactimage"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];


    NSMutableArray *rightUtilityButton = [NSMutableArray new];
    
    [rightUtilityButton sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.800f green:0.800f blue:0.800f alpha:1.0f]
                                                icon:[UIImage imageNamed:@"edit-50x50.png"]];
    [rightUtilityButton sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.000f green:0.000f blue:0.000f alpha:1.0f]
                                                icon:[UIImage imageNamed:@"delete-50x50.png"]];
    
    editCell.rightUtilityButtons = rightUtilityButton;
    editCell.delegate = self;
    return editCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *cellIndexPath = [contactTable indexPathForCell:cell];
    switch (index)
    {
        case 0:
        {
            // Delete button is pressed
            NSLog(@"Edit");
            
            ObjShared.editContact = 1;
            ObjShared.contactArray=[[contactDict valueForKey:@"contact_list"] objectAtIndex:cellIndexPath.row];
            
            NSLog(@"contact_list--->%@",ObjShared.contactArray);
            
            
            EditContactViewController *contactVC =[self.storyboard instantiateViewControllerWithIdentifier:@"EditContactViewController"];
            [[self navigationController] pushViewController:contactVC animated:NO];
            
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
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        contactDict = dict;
        [contactTable reloadData];

    }
    
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"3"])
    {
        [self callMethod];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"No Records" withMessage:[dict valueForKey:@"message"]];
    }
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {}
}
- (void)failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}

-(void)dealloc
{
    [contactTable dg_removePullToRefresh];
}



@end
