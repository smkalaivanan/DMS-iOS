//
//  searchViewController.m
//  DMS
//
//  Created by macbook on 22/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "searchViewController.h"
#import "TLTagsControl.h"
#import "SavedcarViewController.h"
#import "AppDelegate.h"
#import "ChangePasswordViewController.h"
#import "SelectCityViewController.h"
#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "MyQueriesViewController.h"
#import "DashboardViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface searchViewController ()<TLTagsControlDelegate,CZPickerViewDataSource, CZPickerViewDelegate>
{
    SearchTableViewCell *searchCell;
    headerTableViewCell *header;
    NSMutableArray *tags;
    AppDelegate * appDelegate;
    NSDictionary *search_Dict;
}
@property CZPickerView *pickerForCity;
@end

@implementation searchViewController
@synthesize para;

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    ObjShared = [SharedClass sharedInstance];
    
    search_Dict=ObjShared.searchPageDict;
    
    footerArray = [[NSArray alloc] initWithObjects:@"search-white.png",
                   @"savecar-blue.png",
                   @"queries-blue.png",
                   @"bids-blue.png",
                   @"funding-blue.png", nil];
    footerText = [[NSArray alloc] initWithObjects:@"Search",
                  @"Saved Cars",
                  @"My Queries",
                  @"Bids Posted",
                  @"Funding",nil];
    
    tags = [NSMutableArray arrayWithArray:@[@"Budget: 4L - 5L",
                                            @"Model: SUV",
                                            @"City: Chennai",
                                            @"Site: Quickr"]];
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
    
    [city setTitle:ObjShared.Cityname forState:UIControlStateNormal];

}

-(void)likeArray
{
    like = [[NSMutableArray alloc]initWithCapacity:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"saved_car"] count]];
    
    for (int i = 0; i<[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"saved_car"] count]; i++)
    {
        [like addObject:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"saved_car"] objectAtIndex:i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return footerText.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.footIcon.image = [UIImage imageNamed:[footerArray objectAtIndex:indexPath.row]];
    cell.foorLabel.text = [footerText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0)
    {
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
    return [[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_id"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"SearchTableViewCell";
    
    searchCell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    searchCell.carName.text=[NSString stringWithFormat:@"%@-%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"make"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"model"] objectAtIndex:indexPath.row]];
    
    searchCell.CarKm.text=[NSString stringWithFormat:@"%@ |%@ |%@ |%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"kilometer_run"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"fuel_type"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"registration_year"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"owner_type"] objectAtIndex:indexPath.row]];
    
    searchCell.carPrice.text=[NSString stringWithFormat:@"₹ %@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"price"]objectAtIndex:indexPath.row]];
    
    searchCell.address.text=[NSString stringWithFormat:@"%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_address_1"]objectAtIndex:indexPath.row]];
    
    searchCell.postedDate.text=[NSString stringWithFormat:@"%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"daysstmt"]objectAtIndex:indexPath.row]];

    searchCell.PhotoNumber.text=[NSString stringWithFormat:@"%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"noimages"]objectAtIndex:indexPath.row]];
    

    [searchCell.carImage setImageWithURL:[NSURL URLWithString:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"imagelinks"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [searchCell.siteImage setImageWithURL:[NSURL URLWithString:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"site_image"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    [searchCell.bidImage setImageWithURL:[NSURL URLWithString:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"bid_image"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];

//    NSLog(@"price-->%@,posted---->%@,photo--->%@",[[search_Dict valueForKey:@"car_listing"] valueForKey:@"daysstmt"],[[search_Dict valueForKey:@"car_listing"] valueForKey:@"price"],);
    
    searchCell.reminder.tag=indexPath.row;
    searchCell.heart.tag = indexPath.row;
    [searchCell.heart addTarget:self
                        action:@selector(animateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[like objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"like-red.png"] forState:UIControlStateNormal];
//        NSLog(@"liky:%@",like);
    }
    else
    {
        [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"like-White.png"] forState:UIControlStateNormal];
//        NSLog(@"liky:%@",like);
    }
 
    searchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return searchCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    header = [tableView dequeueReusableCellWithIdentifier:@"headerTableViewCell"];
    header.redListingTagControl.tags = [tags mutableCopy];
    header.redListingTagControl.mode = TLTagsControlModeList;
    header.redListingTagControl.tagsBackgroundColor = UIColorFromRGB(0XCCCCCC);
    header.redListingTagControl.tagsTextColor = [UIColor blackColor];
    [header.redListingTagControl reloadTagSubviews];
    [header.redListingTagControl setTapDelegate:self];
    return header;
}

-(void)animateButton:(UIButton *)sender
{
    UIButton * button = (UIButton *)sender;
//        button.selected = !button.selected;
    
    NSMutableDictionary* likePara =[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"549",@"session_user_id",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_id"] objectAtIndex:sender.tag],@"carid", nil];
    
    NSLog(@"sender--->%ld",(long)sender.tag);
    
        if ([[like objectAtIndex:sender.tag] isEqualToString:@"0"])
        {
            [like replaceObjectAtIndex:sender.tag withObject:@"1"];
            
            SystemSoundID soundID;
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
            NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
            AudioServicesCreateSystemSoundID ((CFURLRef) CFBridgingRetain(soundUrl) , &soundID);
            AudioServicesPlaySystemSound(soundID);
            
            [UIView animateWithDuration:0.3/1.5 animations:^{
                
                button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.4, 1.4);
                
            } completion:^(BOOL finished)
            {
                [UIView animateWithDuration:0.3/2 animations:^{
                    
                    button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                    
                } completion:^(BOOL finished){
                    
                    [UIView animateWithDuration:0.3/2 animations:^{
                        button.transform = CGAffineTransformIdentity;
                        
                    }];
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
                    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                    [searchTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                }];
            }];
        }
        else
        {
            [like replaceObjectAtIndex:sender.tag withObject:@"0"];
           
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
            NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
            [searchTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        }
    [ObjShared callWebServiceWith_DomainName:@"api_save_car" postData:likePara];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TLTagsControlDelegate

- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index
{
    NSLog(@"Tag \"%@\" was tapped", tagsControl.tags[index]);
    
    if (tags.count > 1)
    {
        
    }
    else
    {
        searchTable.contentInset = UIEdgeInsetsMake(-(header.frame.size.height), 0, 0, 0);
    }
    [tags removeObject:tagsControl.tags[index]];
    [searchTable reloadData];
}

-(IBAction)search:(id)sender
{
    [self.view endEditing:YES];

   para=[[NSMutableDictionary alloc] initWithObjectsAndKeys:searchText.text,@"search_listing",city.titleLabel.text,@"city_name",@"detail_searchpage",@"page_name", nil];
    NSLog(@"params--->%@",para);
    [ObjShared callWebServiceWith_DomainName:@"apisearchcarlisting" postData:para];
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
            search_Dict=[[NSDictionary alloc]init];
            search_Dict=dict;

            [searchTable reloadData];
        }
        else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
        {
            [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
        }
        else if ([[dict objectForKey:@"Result"]isEqualToString:@"3"])
        {
            NSDictionary * likeDict = [[NSDictionary alloc]init];
            likeDict = dict;
        }
        else if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]] isEqualToString:@"(null)"]  || dict != nil)
        {
        
        }
    

    
}
- (void) failResponseFromServer
{
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}

- (IBAction)showWithCity:(id)sender
{
    SelectCityViewController *cityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];
    [self presentViewController:cityVC animated:YES completion: nil];
}



-(IBAction)city:(id)sender
{
    SelectCityViewController *cityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];
    [self presentViewController:cityVC animated:YES completion: nil];
}

-(IBAction)filter:(id)sender
{
    
}
-(IBAction)compare:(id)sender
{
    
}
-(IBAction)sort:(id)sender
{
    
}



@end
