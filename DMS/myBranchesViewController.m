//
//  myBranchesViewController.m
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "myBranchesViewController.h"
#import "AddBranchesViewController.h"

@interface myBranchesViewController ()
{
    NSDictionary *branchDict;
    IBOutlet UITableView *branchTable;
}
@end

@implementation myBranchesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)sidemMenu:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(IBAction)add:(id)sender
{
    AddBranchesViewController *branchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddBranchesViewController"];
    [[self navigationController] pushViewController:branchVC animated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    ObjShared.editBranch=0;

    [self callMethod];

}

-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"viewbranchlist",@"page_name", nil];
    
    NSLog(@"para--->%@",para);
    [ObjShared callWebServiceWith_DomainName:@"api_branch_list" postData:para];
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
    
    if (indexPath.row == 1)
    {
        cell.footIcon.image=[UIImage imageNamed:@"branches-white.png"];
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
    return [[[branchDict valueForKey:@"branch_list"]valueForKey:@"dealer_name"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"branchTableViewCell";
    
    branchTableViewCell *branchCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    branchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    branchCell.dealerName.text=[NSString stringWithFormat:@"%@",[[[branchDict valueForKey:@"branch_list"] valueForKey:@"dealer_name"] objectAtIndex:indexPath.row]];
    branchCell.address.text=[NSString stringWithFormat:@"%@",[[[branchDict valueForKey:@"branch_list"] valueForKey:@"branch_address"]objectAtIndex:indexPath.row]];
    branchCell.mobile.text=[NSString stringWithFormat:@"%@",[[[branchDict valueForKey:@"branch_list"] valueForKey:@"dealer_contact_no"]objectAtIndex:indexPath.row]];
    branchCell.email.text=[NSString stringWithFormat:@"%@",[[[branchDict valueForKey:@"branch_list"] valueForKey:@"dealer_mail"]objectAtIndex:indexPath.row]];
    
    branchCell.status.text=[NSString stringWithFormat:@"%@",[[[branchDict valueForKey:@"branch_list"] valueForKey:@"dealer_status"]objectAtIndex:indexPath.row]];


    
    
    NSMutableArray *rightUtilityButton = [NSMutableArray new];
    
    
    [rightUtilityButton sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.008f green:0.208f blue:0.569f alpha:1.0f]
                                                icon:[UIImage imageNamed:@"edit-50x50.png"]];
    
    [rightUtilityButton sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.020f green:0.263f blue:0.706f alpha:1.0f]
                                                icon:[UIImage imageNamed:@"delete-50x50.png"]];

    
    branchCell.rightUtilityButtons = rightUtilityButton;
    branchCell.delegate = self;
    
    return branchCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            // Delete button is pressed
            NSLog(@"Edit");
            
            ObjShared.editBranch=1;
            
            ObjShared.branchArray=[[branchDict valueForKey:@"branch_list"] objectAtIndex:index];
            
            
            NSLog(@"branch--->%@",ObjShared.branchArray);
            
            AddBranchesViewController *branchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddBranchesViewController"];
            [[self navigationController] pushViewController:branchVC animated:NO];

            break;
        }
        case 1:
        {
            // Delete button is pressed
            
//        session_user_id:1402
//            id:2
//        page_name:deletebranch
            
            NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",@"deletebranch",@"page_name",[[[branchDict valueForKey:@"branch_list"] valueForKey:@"branch_id"]objectAtIndex:index],@"id", nil];
            
            NSLog(@"para--->%@",para);
            
            [ObjShared callWebServiceWith_DomainName:@"api_delete_branch" postData:para];
            
            
            
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
        branchDict = dict;
    
        [branchTable reloadData];
        
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
    {
        
    }
}
- (void)failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}


@end
