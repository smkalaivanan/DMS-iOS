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
#import "DetailViewController.h"
#import "BidsDetailViewController.h"
#import "FiltersViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface searchViewController ()<TLTagsControlDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    SearchTableViewCell *searchCell;
    headerTableViewCell *header;
    NSMutableArray *tags;
    AppDelegate * appDelegate;
    NSDictionary *search_Dict;
    UIButton * button;
    UIView * pic;
    NSArray * sort;
    
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
    
    tags = [search_Dict valueForKey:@"top_note"];
    NSLog(@"search Dict ----> %@",search_Dict);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    [self likeArray];
    [city setTitle:ObjShared.Cityname forState:UIControlStateNormal];
}

-(void)likeArray
{
    like = [[NSMutableArray alloc]initWithCapacity:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"saved_car"] count]];
    
    for (int i = 0; i<[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"saved_car"] count]; i++)
    {
        [like addObject:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"saved_car"] objectAtIndex:i]];
    }
    
    alert = [[NSMutableArray alloc]initWithCapacity:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"notify_car"] count]];
    
    for (int i = 0; i<[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"notify_car"] count]; i++)
    {
        [alert addObject:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"notify_car"] objectAtIndex:i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [footerText count];
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
    
    searchCell.CarKm.text=[NSString stringWithFormat:@"%@ KM |%@ |%@ |%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"kilometer_run"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"fuel_type"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"registration_year"] objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"owner_type"] objectAtIndex:indexPath.row]];
    
    searchCell.carPrice.text=[NSString stringWithFormat:@"₹ %@ - %@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"price"]objectAtIndex:indexPath.row],[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_locality"]objectAtIndex:indexPath.row]];
    
    searchCell.postedDate.text=[NSString stringWithFormat:@"%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"daysstmt"]objectAtIndex:indexPath.row]];

    searchCell.PhotoNumber.text=[NSString stringWithFormat:@"%@",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"no_images"]objectAtIndex:indexPath.row]];
    
    [searchCell.carImage setImageWithURL:[NSURL URLWithString:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"imagelinks"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [searchCell.siteImage setImageWithURL:[NSURL URLWithString:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"site_image"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [searchCell.bidImage setImageWithURL:[NSURL URLWithString:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"bid_image"]objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];

//    NSLog(@"price-->%@,posted---->%@,photo--->%@",[[search_Dict valueForKey:@"car_listing"] valueForKey:@"daysstmt"],[[search_Dict valueForKey:@"car_listing"] valueForKey:@"price"],);
    
    searchCell.reminder.tag=indexPath.row;
    [searchCell.reminder addTarget:self
                            action:@selector(alertButton:) forControlEvents:UIControlEventTouchUpInside];
    
    searchCell.heart.tag = indexPath.row;
    [searchCell.heart addTarget:self
                        action:@selector(animateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    searchCell.viewBitButton.tag = indexPath.row;
    searchCell.makeOfferButtom.tag = indexPath.row;
    
    searchCell.makeOfferButtom.layer.cornerRadius = 5;
    searchCell.makeOfferButtom.layer.masksToBounds = YES;
    searchCell.viewBitButton.layer.cornerRadius = 5;
    searchCell.viewBitButton.layer.masksToBounds = YES;
    
    [searchCell.viewBitButton addTarget:self action:@selector(viewBidAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchCell.makeOfferButtom addTarget:self action:@selector(makeOfferAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"auction"]objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        searchCell.viewBitButton.hidden = YES;
        searchCell.makeOfferButtom.hidden = YES;
    }
    else if ([[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"auction"]objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        searchCell.viewBitButton.hidden = NO;
        searchCell.makeOfferButtom.hidden = NO;
    }
    else
    {
        searchCell.viewBitButton.hidden = NO;
        searchCell.makeOfferButtom.hidden = YES;
    }
        
    if ([[NSString stringWithFormat:@"%@",[like objectAtIndex:indexPath.row]] isEqualToString:@"1"])
    {
        [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"like-red.png"] forState:UIControlStateNormal];
//        NSLog(@"liky:%@",like);
    }
    else
    {
        [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"like-White.png"] forState:UIControlStateNormal];
//        NSLog(@"liky:%@",like);
    }
    
    if ([[NSString stringWithFormat:@"%@",[alert objectAtIndex:indexPath.row]] isEqualToString:@"1"])
    {
        [searchCell.reminder setBackgroundImage:[UIImage imageNamed:@"alert-red.png"] forState:UIControlStateNormal];
    }
    else
    {
        [searchCell.reminder setBackgroundImage:[UIImage imageNamed:@"alert.png"] forState:UIControlStateNormal];
    }
 
    searchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return searchCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row----> %ld",(long)indexPath.row);
    
//    DetailViewController *DetailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//    [[self navigationController] pushViewController:DetailVC animated:NO];
//
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
    header.redListingTagControl.showsHorizontalScrollIndicator = NO;
    
    return header;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(searchTable.contentOffset.y >= (searchTable.contentSize.height - searchTable.bounds.size.height))
    {
            NSLog(@"called %f",searchTable.contentOffset.y);
        
    }
}
-(void)viewBidAction:(UIButton *)sender
{
    NSLog(@"viewBidAction-----> %ld",(long)sender.tag);
    ObjShared.bidCaridDetail = [[search_Dict valueForKey:@"car_listing"]objectAtIndex:sender.tag];
    BidsDetailViewController *bidVC =[self.storyboard instantiateViewControllerWithIdentifier:@"BidsDetailViewController"];
    [[self navigationController] pushViewController:bidVC animated:YES];
    
}
-(void)makeOfferAction:(UIButton *)sender
{
    NSLog(@"makeOfferAction-----> %ld",(long)sender.tag);
    ObjShared.bidCaridDetail = [[search_Dict valueForKey:@"car_listing"]objectAtIndex:sender.tag];
    BidsDetailViewController *bidVC =[self.storyboard instantiateViewControllerWithIdentifier:@"BidsDetailViewController"];
    [[self navigationController] pushViewController:bidVC animated:YES];
}
-(void)clickAnimation
{
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
-(void)animateButton:(UIButton *)sender
{
    button = (UIButton *)sender;
//        button.selected = !button.selected;
    
    NSMutableDictionary* likePara =[[NSMutableDictionary alloc] initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_id"] objectAtIndex:sender.tag],@"carid", nil];
    
    NSLog(@"para--->%@",likePara);
    
    NSLog(@"sender--->%ld",(long)sender.tag);
    
        if ([[NSString stringWithFormat:@"%@",[like objectAtIndex:sender.tag] ]isEqualToString:@"0"])
        {
            [like replaceObjectAtIndex:sender.tag withObject:@"1"];
            [self clickAnimation];
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
-(void)alertButton:(UIButton *)sender
{
    button = (UIButton *)sender;
    
    NSMutableDictionary* alertPara =[[NSMutableDictionary alloc] initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_id"] objectAtIndex:sender.tag],@"car_id",@"alertcarpage",@"page_name", nil];
    
    NSLog(@"para--->%@",alertPara);
    
    if ([[NSString stringWithFormat:@"%@",[alert objectAtIndex:sender.tag] ]isEqualToString:@"0"])
    {
        [alert replaceObjectAtIndex:sender.tag withObject:@"1"];
        [self clickAnimation];
    }
    else
    {
        [alert replaceObjectAtIndex:sender.tag withObject:@"0"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
        NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
        [searchTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
    [ObjShared callWebServiceWith_DomainName:@"api_alert_car" postData:alertPara];
    NSLog(@"param --- >%@",alertPara);
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

   para=[[NSMutableDictionary alloc] initWithObjectsAndKeys:searchText.text,@"search_listing",city.titleLabel.text,@"city_name",@"detail_searchpage",@"page_name",[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",nil];
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
        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]]isEqualToString:@"1"])
        {
            search_Dict=[[NSDictionary alloc]init];
            search_Dict=dict;

            [searchTable reloadData];
        }
        else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"]]isEqualToString:@"0"])
        {
            [AppDelegate showAlert:@"Invalid User" withMessage:@"Invalid Username or Password"];
        }
        else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"Result"] ]isEqualToString:@"3"])
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
    FiltersViewController *FilterVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
    [[self navigationController]pushViewController :FilterVC  animated:YES];

    
}
-(IBAction)compare:(id)sender
{
    
}
-(IBAction)sort
{
    
    sort = @[@"Low price to High price",@"High price to Low price",@"Low Mileage to High Mileage",@"High Mileage to Low Mileage",@"Old cars to New  cars",@"New cars to Old cars"] ;
    
    pic = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width , 180)];
    
    pic.backgroundColor=[UIColor clearColor];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 50)];
    
    toolBar.layer.cornerRadius=5.0f;
    toolBar.layer.masksToBounds = YES;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerOk:)];
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancel:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    [toolBar setItems:[NSArray arrayWithObjects:btn1,flexibleSpace,btn,nil]];
    [pic addSubview:toolBar];
    
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width - 20, 145)];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.layer.cornerRadius=10.0f;
    self.pickerView.layer.masksToBounds = YES;

    self.pickerView.backgroundColor=[UIColor whiteColor];
    [pic addSubview:self.pickerView];
    
    [self.view addSubview:pic];
    
}

-(IBAction)pickerOk:(id)sender
{
//    if ([sort_Name isEqualToString:@"A to Z"])
//    {
//        sortId=@"1";
//    }
//    else if ([sort_Name isEqualToString:@"Z to A"])
//    {
//        sortId=@"2";
//        
//    }
//    else if ([sort_Name isEqualToString:@"Low price to High price"])
//    {
//        sortId=@"3";
//    }
//    else if ([sort_Name isEqualToString:@"High price to Low price"])
//    {
//        sortId=@"4";
//        
//    }
//    else
//    {
//        sortId=@"0";
//    }
//    [self sendHTTPPost];
    [pic removeFromSuperview];
    //    [self.pickerView removeFromSuperview];
    //    pic.hidden=YES;
}
-(IBAction)pickerCancel:(id)sender
{
    //    NSLog(@"inside picker cancel");
   
    [pic removeFromSuperview];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    sort_Name=[NSString stringWithFormat:@"%@",[picker objectAtIndex:row]];
    //    NSLog(@"%@",[picker objectAtIndex:row]);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sort count];
}

# pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sort objectAtIndex:row];
}



@end
