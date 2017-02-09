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
#import "BidsDetailViewController.h"

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
    NSString * senderNumber;
}

@end

@implementation SavedcarViewController
@synthesize searchTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    search_Dict=[[NSDictionary alloc]init];
    newArray = [[NSMutableArray alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
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
    [self callMethod];
    
    DGElasticPullToRefreshLoadingViewCircle* loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    [searchTable dg_addPullToRefreshWithWaveMaxHeight:70 minOffsetToPull:80 loadingContentInset:50 loadingViewSize:30 actionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self callMethod];
            [weakSelf.searchTable dg_stopLoading];
        });
    }
                                         loadingView:loadingView];
    
    [searchTable dg_setPullToRefreshFillColor:UIColorFromRGB(0X173E84)];
    
    [searchTable dg_setPullToRefreshBackgroundColor:searchTable.backgroundColor];

}

-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id", nil];
    [ObjShared callWebServiceWith_DomainName:@"apiview_savedcars" postData:para];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [self.searchTable dg_removePullToRefresh];
}

-(IBAction)showLeftMenuPressed:(id)sender
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
    [searchCell.heart setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];

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
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}
-(void)alertButton:(UIButton *)sender
{
    UIButton * button = (UIButton *)sender;

    NSMutableDictionary* alertPara =[[NSMutableDictionary alloc] initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"car_id"] objectAtIndex:sender.tag],@"car_id",@"alertcarpage",@"page_name", nil];
    
    NSLog(@"para--->%@",alertPara);
    
    if ([[NSString stringWithFormat:@"%@",[alert objectAtIndex:sender.tag] ]isEqualToString:@"0"])
    {
        [alert replaceObjectAtIndex:sender.tag withObject:@"1"];
        
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
        [alert replaceObjectAtIndex:sender.tag withObject:@"0"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
        NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
        [searchTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }

    
    [ObjShared callWebServiceWith_DomainName:@"api_alert_car" postData:alertPara];
    NSLog(@"param --- >%@",alertPara);
    senderNumber= [NSString stringWithFormat:@"%ld",(long)sender.tag];
}

-(void)animateButton:(UIButton *)sender
{
//    UIButton * button = (UIButton *)sender;
//    button.selected = !button.selected;
    NSMutableDictionary* likePara =[[NSMutableDictionary alloc] initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",[[newArray valueForKey:@"car_id"] objectAtIndex:sender.tag],@"carid", nil];
    
    [ObjShared callWebServiceWith_DomainName:@"api_save_car" postData:likePara];
    senderNumber= [NSString stringWithFormat:@"%ld",(long)sender.tag];
}
-(void)viewBidAction:(UIButton *)sender
{
    NSLog(@"viewBidAction-----> %ld",(long)sender.tag);
    ObjShared.bidCaridDetail = [[search_Dict valueForKey:@"car_listing"]objectAtIndex:sender.tag];
    BidsDetailViewController *bidVC =[self.storyboard instantiateViewControllerWithIdentifier:@"BidsDetailViewController"];
    [[self navigationController] pushViewController:bidVC animated:NO];
}
-(void)makeOfferAction:(UIButton *)sender
{
    NSLog(@"makeOfferAction-----> %ld",(long)sender.tag);
    ObjShared.bidCaridDetail = [[search_Dict valueForKey:@"car_listing"]objectAtIndex:sender.tag];
    BidsDetailViewController *bidVC =[self.storyboard instantiateViewControllerWithIdentifier:@"BidsDetailViewController"];
    [[self navigationController] pushViewController:bidVC animated:NO];
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
        
        alert = [[NSMutableArray alloc]initWithCapacity:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"notify_car"] count]];
        
        for (int i = 0; i<[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"notify_car"] count]; i++)
        {
            [alert addObject:[[[search_Dict valueForKey:@"car_listing"] valueForKey:@"notify_car"] objectAtIndex:i]];
        }
        
        NSLog(@"alert array -- >%@",alert);

        [searchTable reloadData];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"3"])
    {
        [newArray removeObjectAtIndex:[senderNumber integerValue]];
        [searchTable reloadData];
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"4"])
    {
        [searchTable reloadData];
    }

    else if ([[dict objectForKey:@"Result"]isEqualToString:@"0"])
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
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
