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
    
    NSDictionary *filterDict;
}
@end

@implementation FiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ObjShared = [SharedClass sharedInstance];
    keyArray = [[NSArray alloc] initWithObjects:
                @"Car Sites",
                @"Listing Type",
                @"Car Make",
                @"Car Model",
                @"Car Year",
                @"Transmission",
                @"Fuel Type",
                @"Budget",
                @"Body Type",
                nil];
    [self callMethod];
    
    // Do any additional setup after loading the view.
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
}

-(void)callMethod
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [ObjShared callWebServiceWith_DomainName:@"api_buy_filter" getData:para];
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
        valueArray=[filterDict valueForKey:@"Car_site"];
    }
    else if (indexPath.row == 1)
    {

        valueArray=[filterDict valueForKey:@"Listing_type"];
        
    }
    else if (indexPath.row == 2)
    {
        valueArray=[filterDict valueForKey:@"Make"];
    }
    else if (indexPath.row == 3)
    {
        valueArray=[filterDict valueForKey:@"Listing_type"];
    }
    else if (indexPath.row == 4)
    {
        valueArray=[filterDict valueForKey:@"year"];

    }
    else if (indexPath.row == 5)
    {

        valueArray=[filterDict valueForKey:@"Transmission_type"];

    }
    else if (indexPath.row == 6)
    {
        valueArray=[filterDict valueForKey:@"Fuel_type"];
        
    }
    else if (indexPath.row == 7)
    {
        valueArray=[filterDict valueForKey:@"Car_budget"];

        
    }
    else if (indexPath.row == 8)
    {
        valueArray=[filterDict valueForKey:@"Body_type"];
        
    }
    else
    {
        valueArray = @[@""];
        
    }
    
    selectionVC.selection=[keyArray objectAtIndex:indexPath.row];

    
    selectionVC.choose=[[NSMutableArray alloc]initWithArray:valueArray];
    
    [self presentViewController:selectionVC animated:YES completion: nil];
}

-(IBAction)back
{
    NSLog(@"back");
    [[self navigationController]popViewControllerAnimated:YES];
}

#pragma mark -W.S Delegate Call

- (void) successfulResponseFromServer:(NSDictionary *)dict
{
    NSLog(@"dict--->%@",dict);
    if ([[dict objectForKey:@"Result"]isEqualToString:@"1"])
    {
        filterDict = dict;
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
