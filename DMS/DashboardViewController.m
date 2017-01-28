//
//  DashboardViewController.m
//  DMS
//
//  Created by Kalaivanan on 17/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "DashboardViewController.h"
#import "MFSideMenu.h"
#import "searchViewController.h"
#import "AppDelegate.h"
#import "SelectCityViewController.h"
#import "ChangePasswordViewController.h"
#import "ApplyFundingViewController.h"
#import "bidsPostedViewController.h"
#import "MyQueriesViewController.h"
#import "SavedcarViewController.h"
#import "DashboardCollectionViewCell.h"
#import "SiteViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DashboardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CZPickerViewDataSource, CZPickerViewDelegate>
{
    NSString *budgetValue;
    AppDelegate *appDelegate;
    NSDictionary *modelDict;
    NSString *modelID, *newTrim;
    NSMutableDictionary *param;
    NSUserDefaults *searchSave;
}
@property CZPickerView *pickerWithImage;
@property CZPickerView *pickerWithValue;
@property CZPickerView *PickerWithVehicle;

@end

@implementation DashboardViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    searchSave  = [NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    ObjShared = [SharedClass sharedInstance];
    
    segValue = segment.selectedSegmentIndex;
    
    ObjShared.footerArray = [[NSArray alloc] initWithObjects:@"search-blue.png",
                             @"savecar-blue.png",
                             @"queries-blue.png",
                             @"bids-blue.png",
                             @"funding-blue.png", nil];
    
    ObjShared.footerText = [[NSArray alloc] initWithObjects:@"Search",
                            @"Saved Cars",
                            @"My Queries",
                            @"Bids Posted",
                            @"Funding",
                            nil];
    
    vehicleType =[[NSArray alloc] initWithObjects:
                  @"Sedan",
                  @"Coupe",
                  @"Hatchback",
                  @"Minivan",
                  @"SUV",
                  @"Wagon", nil];
    
//    NSLog(@"outer ---> %@",ObjShared.Cityname);
//    NSLog(@"outer ---> %@",newTrim);
//    NSLog(@"outer ---> %@",ObjShared.siteNameArray);

    
//    if ([searchSave valueForKey:@"city_name"] != 0)
//    {
//        ObjShared.Cityname=[searchSave valueForKey:@"city_name"];
//        newTrim=[searchSave valueForKey:@"site_name"];
//        ObjShared.siteName= [NSString stringWithFormat:@"%lu sites selected",(unsigned long)[[searchSave valueForKey:@"site_name_array"] count]];
//        ObjShared.siteNameArray =[searchSave valueForKey:@"site_city_array"];
//        
//        NSLog(@"main ---> %@",ObjShared.Cityname);
//        NSLog(@"main ---> %@",newTrim);
//        NSLog(@"main ---> %@",ObjShared.siteNameArray);
//        
//    }
//    else
//    {
        ObjShared.Cityname=@"Select City";
        ObjShared.siteName=@"Select sites";
        NSLog(@"search default ----> %@",[searchSave valueForKey:@"city_name"]);
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    ObjShared = [SharedClass sharedInstance];

    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    // Corner Radius for Enter button
    search.layer.cornerRadius = 10;
    search.layer.masksToBounds = NO;
    search.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    search.layer.shadowOpacity = 0.2;
    search.layer.shadowRadius = 2;
    search.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    [showWithoutFooter setTitle:ObjShared.Cityname forState:UIControlStateNormal];
    [showWithMultipleSelection setTitle:ObjShared.siteName forState:UIControlStateNormal];
    [self callMethod];
    
    NSLog(@"city--->%@",ObjShared.Cityname);
    NSLog(@"hello world");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callMakeid
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithObjectsAndKeys:modelID,@"make", nil];
    [ObjShared callWebServiceWith_DomainName:@"apibuyid" postData:para];
}

-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [ObjShared callWebServiceWith_DomainName:@"apibuy" getData:para];
}

-(IBAction)showLeftMenuPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(IBAction)showRightMenuPressed:(id)sender
{
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
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
    
    if (indexPath.row == 0)
    {
        cell.footIcon.image=[UIImage imageNamed:@"search-white.png"];
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
//    NSLog(@"selected");
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}

#pragma CZPickerView Delegates

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row
{
    if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue == 0)
        {
            return [[ObjShared.appDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"][row];

        }
        else
        {
            return [[ObjShared.appDict valueForKey:@"model_make"]valueForKey:@"makename"][row];
        }
    }
    else
    {
        if (segValue == 0)
        {
            return [[ObjShared.appDict valueForKey:@"Vehicle_type"]valueForKey:@"category_description"][row];
//            return [[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row];

        }
        else
        {
            return  [[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row];
        }
    }
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView
{
    if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue == 0)
        {
            return [[[ObjShared.appDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"]count];

        }
        else
        {
            return [[[ObjShared.appDict valueForKey:@"model_make"]valueForKey:@"makename"]count];
        }
    }
    else
    {
        if (segValue == 0)
        {
            return [[[ObjShared.appDict valueForKey:@"Vehicle_type"]valueForKey:@"category_description"]count];
        }
        else
        {
               return [[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"] count];
        }
    }
    
}
- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row
{
    
    if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue == 0)
        {
            NSString * butBud = [NSString stringWithFormat:@"%@",[[ObjShared.appDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"][row]];

            budgetValue=[NSString stringWithFormat:@"%@",[[ObjShared.appDict valueForKey:@"car_budget"]valueForKey:@"budget_value"][row]];
            
            NSLog(@"%@",budgetValue);
            
            [showBudget setTitle:butBud forState:UIControlStateNormal];
        }
        else
        {
            NSString * butBud = [NSString stringWithFormat:@"%@",[[ObjShared.appDict valueForKey:@"model_make"]valueForKey:@"makename"][row]];
            [showBudget setTitle:butBud forState:UIControlStateNormal];
            
            modelID = [NSString stringWithFormat:@"%@",[[ObjShared.appDict valueForKey:@"model_make"]valueForKey:@"make_id"][row]];
            [self callMakeid];
        }

    }
    else
    {
        if (segValue == 0)
        {
            NSString * butVeh = [NSString stringWithFormat:@"%@",[[ObjShared.appDict valueForKey:@"Vehicle_type"]valueForKey:@"category_description"][row]];
            [showVehicle setTitle:butVeh forState:UIControlStateNormal];
        }
        else
        {
            NSString * butVeh = [NSString stringWithFormat:@"%@",[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row]];
            [showVehicle setTitle:butVeh forState:UIControlStateNormal];
        }

    }
   
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows
{
     if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue  ==  0)
        {
            NSString * butBuds = [NSString stringWithFormat:@"%@",[[[ObjShared.appDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"] objectAtIndex:0]];

            
            [showBudget setTitle:butBuds forState:UIControlStateNormal];
        }
        else
        {
            NSString * butBuds = [NSString stringWithFormat:@"%@",[[[ObjShared.appDict valueForKey:@"model_make"]valueForKey:@"makename"] objectAtIndex:0]];
            [showBudget setTitle:butBuds forState:UIControlStateNormal];

        }
    }
    else
    {
        if (segValue  ==  0)
        {
            NSString * butVehOne = [NSString stringWithFormat:@"%@",[[[ObjShared.appDict valueForKey:@"Vehicle_type"]valueForKey:@"category_description"] objectAtIndex:0]];
            [showVehicle setTitle:butVehOne forState:UIControlStateNormal];
        }
        else
        {
            NSString * butVehOne = [NSString stringWithFormat:@"%@",[[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"] objectAtIndex:0]];
            [showVehicle setTitle:butVehOne forState:UIControlStateNormal];
        }
    }
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView
{
    [self.navigationController setNavigationBarHidden:YES];
//    NSLog(@"Canceled.");
}

- (void)czpickerViewWillDisplay:(CZPickerView *)pickerView
{
}

- (void)czpickerViewDidDisplay:(CZPickerView *)pickerView
{
}

- (void)czpickerViewWillDismiss:(CZPickerView *)pickerView
{
}

- (void)czpickerViewDidDismiss:(CZPickerView *)pickerView
{
}

- (IBAction)showWithMultipleSelection:(id)sender
{
    SiteViewController *cityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SiteViewController"];
    [self presentViewController:cityVC animated:YES completion: nil];

}
- (IBAction)showWithoutFooter:(id)sender
{    
    SelectCityViewController *cityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectCityViewController"];
    [self presentViewController:cityVC animated:YES completion: nil];

}
- (IBAction)showBudget:(id)sender
{
    
    if (segValue == 0)
    {
        self.pickerWithValue = [[CZPickerView alloc] initWithHeaderTitle:@"Select Budget" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    }
    else
    {
        self.pickerWithValue = [[CZPickerView alloc] initWithHeaderTitle:@"Select Brand" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    }
    
    self.pickerWithValue.delegate = self;
    self.pickerWithValue.dataSource = self;
    self.pickerWithValue.needFooterView = NO;
    [self.pickerWithValue show];
}
- (IBAction)showVehicle:(id)sender
{
    if (segValue == 0)
    {
        self.PickerWithVehicle = [[CZPickerView alloc] initWithHeaderTitle:@"Select Vehicle Type" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    }
    else
    {
        if (modelDict.count == 0)
        {
            NSLog(@"no entry");
        }
        else
        {
        self.PickerWithVehicle = [[CZPickerView alloc] initWithHeaderTitle:@"Select Model" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
        }

    }
    self.PickerWithVehicle.delegate = self;
    self.PickerWithVehicle.dataSource = self;
    self.PickerWithVehicle.needFooterView = NO;
    [self.PickerWithVehicle show];
}

-(IBAction)segment:(UISegmentedControl *)sender
{
    segValue=sender.selectedSegmentIndex ;
    
//    NSLog(@"sender tag--->%ld",(long)segValue);
    
    if (segValue  ==  0)
    {
        NSString * butNameone = [NSString stringWithFormat:@"Select the Budget"];
        [showBudget setTitle:butNameone forState:UIControlStateNormal];
        
        NSString * butNameTwo = [NSString stringWithFormat:@"Select the Vehicle Types"];
        [showVehicle setTitle:butNameTwo forState:UIControlStateNormal];
        
    }
    else if(segValue == 1)
    {
        NSString * butNameone = [NSString stringWithFormat:@"Select the Brand"];
        [showBudget setTitle:butNameone forState:UIControlStateNormal];
        
        NSString * butNameTwo = [NSString stringWithFormat:@"Select the Model"];
        [showVehicle setTitle:butNameTwo forState:UIControlStateNormal];
    }
}

//Status bar hidden
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(IBAction)search:(id)sender
{
    if ([ObjShared.Cityname isEqualToString:@"Select City" ] || [ ObjShared.siteName isEqualToString:@"Select site"])
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please select your city and sites"];
    }
    else
    {
//        if ([[searchSave valueForKey:@"site_name_array"] count] <= 0 || NULL)
//        {
            NSString * arrayString = [NSString stringWithFormat:@"%@",ObjShared.siteNameArray];
            newTrim = [[[[[arrayString
            stringByReplacingOccurrencesOfString:@"\n" withString:@""]stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""]
                stringByReplacingOccurrencesOfString:@" " withString:@""]
                       stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//            [searchSave setObject:newTrim forKey:@"site_name"];
//        }

        if (segment.selectedSegmentIndex == 0)
        {
            param=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",showWithoutFooter.titleLabel.text,@"city_name",@"searchpage",@"page_name",[NSString stringWithFormat:@"%ld",(long)segment.selectedSegmentIndex],@"radioInline",newTrim,@"car_sites",budgetValue,@"car_budget",showVehicle.titleLabel.text,@"vehicle_type",nil];
        }
        else
        {
            param=[[NSMutableDictionary alloc]initWithObjectsAndKeys:showWithoutFooter.titleLabel.text,@"city_name",[NSString stringWithFormat:@"%ld",(long)segment.selectedSegmentIndex],@"radioInline",newTrim,@"car_sites",budgetValue,@"vehicle_make",showVehicle.titleLabel.text,@"vehicle_model",@"searchpage",@"page_name",[ObjShared.LoginDict valueForKey:@"user_id"],@"session_user_id",nil];
        }
        NSLog(@"param value -----> %@",param);
//        [searchSave setObject:[param valueForKey:@"city_name"] forKey:@"city_name"];
//        [searchSave setObject:ObjShared.siteNameArray forKey:@"site_name_array"];
        [ObjShared callWebServiceWith_DomainName:@"apisearchcarlisting" postData:param];
    }
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        ObjShared.appDict = dict;
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"7"])
    {
        modelDict = dict;
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"9"])
    {
        ObjShared.searchPageDict=dict;
        searchViewController *searchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"searchViewController"];
        [[self navigationController] pushViewController:searchVC animated:NO];
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
-(IBAction)reload:(id)sender
{
    
}

@end
