//
//  SavedcarViewController.m
//  DMS
//
//  Created by macbook on 08/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SavedcarViewController.h"
#import "DashboardViewController.h"
#import "MyQueriesViewController.h"
#import "bidsPostedViewController.h"
#import "ApplyFundingViewController.h"
#import "AppDelegate.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SavedcarViewController ()
{
    SearchTableViewCell *searchCell;
    headerTableViewCell *header;
    NSMutableArray *tags;
    AppDelegate * appDelegate;
    NSDictionary *search_Dict;
    NSMutableArray * newArray;
    NSInteger * senderNumber;
}

@end

@implementation SavedcarViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    search_Dict=[[NSDictionary alloc]init];
    newArray = [[NSMutableArray alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    ObjShared = [SharedClass sharedInstance];

    [self callMethod];
    [self likeArray];
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

-(void)likeArray
{
    int c = 10;
    
    like = [[NSMutableArray alloc]initWithCapacity:c];
    for (int i = 0; i<c; i++)
    {
        [like addObject:@"0"];
    }
}
-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"549",@"session_user_id", nil];
    [ObjShared callWebServiceWith_DomainName:@"apiview_savedcars" postData:para];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (indexPath.row == 1)
    {
        cell.foorLabel.textColor = [UIColor whiteColor];
        cell.footIcon.image=[UIImage imageNamed:@"savecar-white.png"];
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

    NSLog(@"selected");
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}

#pragma UITableView-Sample

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"SearchTableViewCell";
    
    searchCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    searchCell.carName.text=[NSString stringWithFormat:@"%@-%@",[[newArray valueForKey:@"make"] objectAtIndex:indexPath.row],[[newArray valueForKey:@"model"] objectAtIndex:indexPath.row]];
    
    searchCell.CarKm.text=[NSString stringWithFormat:@"%@ |%@ |%@ |%@",[[newArray valueForKey:@"kilometer_run"] objectAtIndex:indexPath.row],[[newArray valueForKey:@"fuel_type"] objectAtIndex:indexPath.row],[[newArray valueForKey:@"registration_year"] objectAtIndex:indexPath.row],[[newArray valueForKey:@"owner_type"] objectAtIndex:indexPath.row]];
    
    searchCell.carPrice.text=[NSString stringWithFormat:@"₹ %@",[[newArray valueForKey:@"price"]objectAtIndex:indexPath.row]];
    
    searchCell.address.text=[NSString stringWithFormat:@"%@",[[newArray valueForKey:@"car_address_1"]objectAtIndex:indexPath.row]];
    
    searchCell.postedDate.text=[NSString stringWithFormat:@"%@",[[newArray valueForKey:@"daysstmt"]objectAtIndex:indexPath.row]];
    
    searchCell.PhotoNumber.text=[NSString stringWithFormat:@"%@",[[newArray valueForKey:@"noimages"]objectAtIndex:indexPath.row]];
    
    
    [searchCell.carImage setImageWithURL:[NSURL URLWithString:[[newArray valueForKey:@"imagelinks"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [searchCell.siteImage setImageWithURL:[NSURL URLWithString:[[newArray valueForKey:@"site_image"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    [searchCell.bidImage setImageWithURL:[NSURL URLWithString:[[newArray valueForKey:@"bid_image"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    //    NSLog(@"price-->%@,posted---->%@,photo--->%@",[[search_Dict valueForKey:@"car_listing"] valueForKey:@"daysstmt"],[[search_Dict valueForKey:@"car_listing"] valueForKey:@"price"],);
    
    searchCell.reminder.tag=indexPath.row;
    searchCell.heart.tag = indexPath.row;
    [searchCell.heart addTarget:self
                         action:@selector(animateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[like objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"like-white.png"] forState:UIControlStateNormal];
        //        NSLog(@"liky:%@",like);
    }
    else
    {
        [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"like-red.png"] forState:UIControlStateNormal];
        //        NSLog(@"liky:%@",like);
    }
    
    searchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return searchCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}


-(void)animateButton:(UIButton *)sender
{
//    UIButton * button = (UIButton *)sender;
//    button.selected = !button.selected;
    NSMutableDictionary* likePara =[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"549",@"session_user_id",[[newArray valueForKey:@"car_id"] objectAtIndex:sender.tag],@"carid", nil];
    
    [ObjShared callWebServiceWith_DomainName:@"api_save_car" postData:likePara];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//Status bar hidden
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark -W.S Delegate Call
- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    
    NSLog(@"in success");
    
    NSLog(@"Dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        search_Dict= dict;
        newArray = [search_Dict valueForKey:@"car_listing"];
        [searchTable reloadData];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"3"])
    {
        [newArray removeObjectAtIndex:searchCell.heart.tag];
        [searchTable reloadData];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
    }
    
    else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
    {
        
    }
}
- (void) failResponseFromServer
{
    [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
}




@end
