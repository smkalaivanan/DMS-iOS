//
//  SelectCityViewController.m
//  DMS
//
//  Created by macbook on 08/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SelectcityCollectionViewCell.h"

@interface SelectCityViewController ()<SharedDelegate>
{
    NSMutableArray *dummyArray,*searchArray;
    NSArray *city;
    NSString *searchTextString;
    NSArray *popular;
    NSArray *stateId;
    NSArray *state;


}
@end

@implementation SelectCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjShared = [SharedClass sharedInstance];
    
    popular=[[NSArray alloc]initWithObjects:@"Chennai",@"Mumbai",@"Pune",@"Bangalore",@"Kochi",@"Delhi",@"Jaipur",@"Hyderabad",@"Kolkata",@"Ahmedabad", nil];
    //need to change state id
    stateId=[[NSArray alloc]initWithObjects:@"31",@"21",@"21",@"18",@"18",@"10",@"29",@"2",@"35",@"12", nil];

    
    
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    city=[[ObjShared.appDict valueForKey:@"model_city"] valueForKey:@"city_name"];

    state=[[ObjShared.appDict valueForKey:@"model_city"] valueForKey:@"state_id"];

    [self searchtext];
    [self updateSearchArray];

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


-(void)searchtext
{
    dummyArray = [[NSMutableArray alloc] init];
    for (int i=0; i<city.count; i++)
    {
        [dummyArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[city objectAtIndex:i], @"city",[state objectAtIndex:i], @"state_id", nil]];
    }
    [cityList reloadData];
    [self updateSearchArray];
}


-(void)textFieldDidChange:(UITextField*)textField
{
    //    NSLog(@"Entering text field");
    searchTextString = textField.text;
    [self updateSearchArray];
}

//update seach method where the textfield acts as seach bar
-(void)updateSearchArray
{
    //    NSLog(@"Entering update array ");
    
    if (searchTextString.length != 0)
    {
        searchArray = [NSMutableArray array];
        
        for ( NSDictionary* item in dummyArray )
        {
            if ([[[item objectForKey:@"city"] lowercaseString] rangeOfString:[searchTextString lowercaseString]].location != NSNotFound)
            {
                [searchArray addObject:item];
            }
        }
    }
    else
    {
        searchArray = dummyArray;
    }
    
    [cityList reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView-Sample

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
       return searchArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"All City";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[searchArray objectAtIndex:indexPath.row]objectForKey:@"city"];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ObjShared.Cityname=[NSString stringWithFormat:@"%@",[[searchArray objectAtIndex:indexPath.row]objectForKey:@"city"]];
    ObjShared.stateId=[NSString stringWithFormat:@"%@",[[searchArray objectAtIndex:indexPath.row]objectForKey:@"state_id"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Collection View delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return popular.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SelectcityCollectionViewCell";
    
    SelectcityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.lab.text=[NSString stringWithFormat:@"%@",[popular objectAtIndex:indexPath.row]];
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[popular objectAtIndex:indexPath.row],@".png"]];
//    cell.footIcon.image = [UIImage imageNamed:[ObjShared.footerArray objectAtIndex:indexPath.row]];
//    cell.foorLabel.text = [ObjShared.footerText objectAtIndex:indexPath.row];
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ObjShared.Cityname=[NSString stringWithFormat:@"%@",[popular objectAtIndex:indexPath.row]];
    
    ObjShared.stateId=[NSString stringWithFormat:@"%@",[stateId objectAtIndex:indexPath.row]];
                                                            
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ObjShared.collectionZ;
}

-(IBAction)back:(id)sender
{
    NSLog(@"back");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
