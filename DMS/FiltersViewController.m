//
//  FiltersViewController.m
//  DMS
//
//  Created by macbook on 18/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "FiltersViewController.h"
#import "FiltersTableViewCell.h"
#import "SelectionViewController.h"

@interface FiltersViewController ()
{
    NSArray *valueArray;
}
@end

@implementation FiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    keyArray = [[NSArray alloc] initWithObjects:
                @"Budget",
                @"Sites",
                @"City",
                @"Car Make",
                @"Car Model",
                @"Body Type",
                @"Car Year",
                @"Transmission",
                @"Fuel Type",
                @"Listing Type",
                nil];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return keyArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"FiltersTableViewCell";
    
    FiltersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    // Configure the cell...
   
    cell.keys.text=[NSString stringWithFormat:@"%@",[keyArray objectAtIndex:indexPath.row]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionViewController *selectionVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectionViewController"];
    
    if (indexPath.row == 0)
    {
        selectionVC.single=1;

        valueArray=[[ObjShared.appDict valueForKey:@"car_budget"] valueForKey:@"budget_varient_name"];
    }
    else if (indexPath.row == 1)
    {
        selectionVC.single=1;

        valueArray=[[ObjShared.appDict valueForKey:@"site_names"] valueForKey:@"sitename"];
        
    }
    else if (indexPath.row == 2)
    {
        selectionVC.single=1;

        
        valueArray=[[ObjShared.appDict valueForKey:@"model_city"] valueForKey:@"city_name"];
        
    }
    else if (indexPath.row == 3)
    {
        selectionVC.single=1;

        valueArray=[[ObjShared.appDict valueForKey:@"model_make"] valueForKey:@"makename"];
        
    }
    else if (indexPath.row == 4)
    {
        selectionVC.single=1;

        valueArray = [[NSArray alloc] initWithObjects:
                      @"Sedan",
                      @"Coupe",
                      @"Hatchback",
                      @"Minivan",
                      @"SUV",
                      @"Wagon", nil];
    }
    else if (indexPath.row == 5)
    {
        selectionVC.single=0;
        valueArray = [[NSArray alloc] initWithObjects:
                      @"2010",
                      @"2011",
                      @"2012",
                      @"2013",
                      @"2014",
                      @"2015",
                      @"2016",
                      @"2017",
                      @"2018",
                      @"2019",nil];
        
    }
    else if (indexPath.row == 5)
    {
        selectionVC.single=0;
        valueArray = [[NSArray alloc] initWithObjects:
                      @"Manual",
                      @"Automatic",nil];
        
    }
    else if (indexPath.row == 6)
    {
        selectionVC.single=0;
        valueArray = [[NSArray alloc] initWithObjects:
                      @"LPG",
                      @"Petrol",
                      @"Disel",nil];
        
    }
    else if (indexPath.row == 7)
    {
        selectionVC.single=0;
        valueArray = [[NSArray alloc] initWithObjects:
                      @"Auction",
                      @"Listing",nil];
        
    }
    
    selectionVC.selection=[keyArray objectAtIndex:indexPath.row];

    
    selectionVC.choose=[[NSMutableArray alloc]initWithArray:valueArray];
    
    [self presentViewController:selectionVC animated:YES completion: nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
