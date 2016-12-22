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
    AppDelegate * appDelegate;
    NSDictionary * dashDict;
    NSDictionary * modelDict;
    NSString * modelID;
    NSMutableArray *array1;
    NSMutableDictionary *param;
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
        
    sites = @[@"Quickr",
              @"Carwale",
              @"Cardekho",
              @"OLX"];
    
    budget=[[NSArray alloc]initWithObjects:
            @"Below 1 Lakh",
            @"1 Lakh - 2 Lakh",
            @"2 Lakh - 3 Lakh",
            @"3 Lakh - 4 Lakh",
            @"5 Lakh - Above",nil];
    
    vehicleType =[[NSArray alloc] initWithObjects:
                  @"Sedan",
                  @"Coupe",
                  @"Hatchback",
                  @"Minivan",
                  @"SUV",
                  @"Wagon", nil];
    
    ObjShared.Cityname=@"Select City";
    
    
    // Corner Radius for Enter button
    search.layer.cornerRadius = 10;
    search.layer.masksToBounds = NO;
    search.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Shadow Effect for Enter button
    search.layer.shadowOpacity = 0.2;
    search.layer.shadowRadius = 2;
    search.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    
    [self callMethod];

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
    
    [showWithoutFooter setTitle:ObjShared.Cityname forState:UIControlStateNormal];
    [showWithMultipleSelection setTitle:ObjShared.sityName forState:UIControlStateNormal];


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
    if([pickerView isEqual:self.pickerWithImage])
    {
        return [[dashDict valueForKey:@"model_city"]valueForKey:@"city_name"][row];
    }
    else if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue == 0)
        {
            return [[dashDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"][row];

        }
        else
        {
            return [[dashDict valueForKey:@"model_make"]valueForKey:@"makename"][row];
        }
    }
    else if ([pickerView isEqual:self.PickerWithVehicle])
    {
        if (segValue == 0)
        {
            return vehicleType[row];
//            return [[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row];

        }
        else
        {
            return  [[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row];
        }
    }
    else
    {
        return  [[dashDict valueForKey:@"site_names"]valueForKey:@"sitename"][row];
    }
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView
{
    if([pickerView isEqual:self.pickerWithImage])
    {
        return [[[dashDict valueForKey:@"model_city"]valueForKey:@"city_name"] count];
    }
    else if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue == 0)
        {
            return [[[dashDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"]count];

        }
        else
        {
            return [[[dashDict valueForKey:@"model_make"]valueForKey:@"makename"]count];
        }
    }
    else if ([pickerView isEqual:self.PickerWithVehicle])
    {
        if (segValue == 0)
        {
            return vehicleType.count;
//            return [[[dashDict valueForKey:@"model_make"]valueForKey:@"makename"]count];

        }
        else
        {
               return [[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"] count];
        }
    }
    else
    {
        return [[[dashDict valueForKey:@"site_names"]valueForKey:@"sitename"]count];

    }
}
- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row
{
    if([pickerView isEqual:self.pickerWithImage])
    {
        NSString * butName = [NSString stringWithFormat:@"%@",[[dashDict valueForKey:@"model_city"]valueForKey:@"city_name"][row]];
        [showWithoutFooter setTitle:butName forState:UIControlStateNormal];
    }
    else if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue == 0)
        {
            NSString * butBud = [NSString stringWithFormat:@"%@",[[dashDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"][row]];

            [showBudget setTitle:butBud forState:UIControlStateNormal];
        }
        else
        {
            NSString * butBud = [NSString stringWithFormat:@"%@",[[dashDict valueForKey:@"model_make"]valueForKey:@"makename"][row]];
            [showBudget setTitle:butBud forState:UIControlStateNormal];
            
            modelID = [NSString stringWithFormat:@"%@",[[dashDict valueForKey:@"model_make"]valueForKey:@"make_id"][row]];
            [self callMakeid];
        }

    }
    else if ([pickerView isEqual:self.PickerWithVehicle])
    {
        if (segValue == 0)
        {
            NSString * butVeh = [NSString stringWithFormat:@"%@",vehicleType[row]];
//            NSString * butVeh = [NSString stringWithFormat:@"%@",[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row]];

            [showVehicle setTitle:butVeh forState:UIControlStateNormal];
        }
        else
        {
            NSString * butVeh = [NSString stringWithFormat:@"%@",[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"][row]];
            [showVehicle setTitle:butVeh forState:UIControlStateNormal];
        }

    }
    else
    {
//        NSString * butVeh = [NSString stringWithFormat:@"%@",[[modelDict valueForKey:@"site_names"]valueForKey:@"sitename"][row]];

        NSLog(@"%@ is chosen!", [[dashDict valueForKey:@"site_names"]valueForKey:@"sitename"][row]);
    }
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows
{
    if([pickerView isEqual:self.pickerWithImage])
    {
        NSString * butName = [NSString stringWithFormat:@"%@",[[[dashDict valueForKey:@"model_city"]valueForKey:@"city_name"] objectAtIndex:0]];

        [showWithoutFooter setTitle:butName forState:UIControlStateNormal];
    }
    else if ([pickerView isEqual:self.pickerWithValue])
    {
        if (segValue  ==  0)
        {
            NSString * butBuds = [NSString stringWithFormat:@"%@",[[[dashDict valueForKey:@"car_budget"]valueForKey:@"budget_varient_name"] objectAtIndex:0]];

            [showBudget setTitle:butBuds forState:UIControlStateNormal];
        }
        else
        {
            NSString * butBuds = [NSString stringWithFormat:@"%@",[[[dashDict valueForKey:@"model_make"]valueForKey:@"makename"] objectAtIndex:0]];
            [showBudget setTitle:butBuds forState:UIControlStateNormal];

        }
    }
    else if ([pickerView isEqual:self.PickerWithVehicle])
    {
        if (segValue  ==  0)
        {
        NSString * butVehOne = [NSString stringWithFormat:@"%@",[vehicleType objectAtIndex:0]];
        [showVehicle setTitle:butVehOne forState:UIControlStateNormal];
        }
        else
        {
            NSString * butVehOne = [NSString stringWithFormat:@"%@",[[[modelDict valueForKey:@"model_makeid"]valueForKey:@"model_name"] objectAtIndex:0]];
            [showVehicle setTitle:butVehOne forState:UIControlStateNormal];
        }
    }
    else
    {
        array1 = [[NSMutableArray alloc] init];
        
        for (NSNumber *ns in rows)
        {
            NSInteger row = [ns integerValue];
            [array1 addObject:[[dashDict valueForKey:@"site_names"]valueForKey:@"sitename"][row]];
        }
        if (array1.count == 1)
        {
            NSString * butNameTwo = [NSString stringWithFormat:@"%@ Selected",[array1 objectAtIndex:0]];
            [showWithMultipleSelection setTitle:butNameTwo forState:UIControlStateNormal];
        }
        else
        {
            NSString * butName1 = [NSString stringWithFormat:@"%lu sites selected",(unsigned long)array1.count];
            [showWithMultipleSelection setTitle:butName1 forState:UIControlStateNormal];
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
//    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Car Sites" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
//    picker.delegate = self;
//    picker.dataSource = self;
//    picker.allowMultipleSelection = YES;
//    [picker show];
    
    
    SiteViewController *cityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SiteViewController"];
    [self presentViewController:cityVC animated:YES completion: nil];

}
- (IBAction)showWithoutFooter:(id)sender
{
//    self.pickerWithImage = [[CZPickerView alloc] initWithHeaderTitle:@"City" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
////    pickerWithoutFooter.headerTitleFont = [UIFont systemFontOfSize: 40];
//    self.pickerWithImage.delegate = self;
//    self.pickerWithImage.dataSource = self;
//    self.pickerWithImage.needFooterView = NO;
//    [self.pickerWithImage show];
    
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
    if ([showWithoutFooter.titleLabel.text isEqualToString:@"Select City"])
    {
        [AppDelegate showAlert:@"Error" withMessage:@"Please select the city"];
    }
    else
    {
//
    if (segment.selectedSegmentIndex == 0)
    {
        param=[[NSMutableDictionary alloc]initWithObjectsAndKeys:showWithoutFooter.titleLabel.text,@"city_name",@"searchpage",@"page_name",[NSString stringWithFormat:@"%ld",(long)segment.selectedSegmentIndex],@"radioInline",array1,@"car_sites",showBudget.titleLabel.text,@"car_budget",showVehicle.titleLabel.text,@"vehicle_type",nil];

    }
    else
    {
        param=[[NSMutableDictionary alloc]initWithObjectsAndKeys:showWithoutFooter.titleLabel.text,@"city_name",[NSString stringWithFormat:@"%ld",(long)segment.selectedSegmentIndex],@"radioInline",array1,@"car_sites",showBudget.titleLabel.text,@"vehicle_make",showVehicle.titleLabel.text,@"vehicle_model",@"searchpage",@"page_name",nil];
        
    }
    NSLog(@"searchVC---->%@",param);

        [self searchcarlisting];

    }
    
}

-(void)searchcarlisting
{
    NSLog(@"para--->%@",param);
    [ObjShared callWebServiceWith_DomainName:@"apisearchcarlisting" postData:param];
}



#pragma mark -W.S Delegate Call
- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        dashDict = dict;
        ObjShared.appDict = dashDict;
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"7"])
    {
        modelDict = dict;
    }
    else if ([[dict objectForKey:@"Result"]isEqualToString:@"9"])
    {
        ObjShared.searchPageDict=dict;
        searchViewController *searchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"searchViewController"];
        [[self navigationController] pushViewController:searchVC animated:YES];

 
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
    [AppDelegate showAlert:@"Error" withMessage:@"Check Your Internet Connection"];
}



@end
