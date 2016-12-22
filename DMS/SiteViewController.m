//
//  SiteViewController.m
//  DMS
//
//  Created by macbook on 22/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SiteViewController.h"

@interface SiteViewController ()
{
    NSMutableArray *dummyArray,*searchArray;
    NSArray *sites;
    NSString *searchTextString;
    UITableViewCell *cell;
}
@end

@implementation SiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjShared = [SharedClass sharedInstance];

    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    NSLog(@"site--->%@",ObjShared.appDict);
    
    sites=[[ObjShared.appDict valueForKey:@"site_names"] valueForKey:@"sitename"];
    NSLog(@"site--->%@",sites);

    [self searchtext];
    [self updateSearchArray];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    for (int i=0; i<sites.count; i++)
    {
        [dummyArray addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[sites objectAtIndex:i], @"site", nil]];
    }
    
    NSLog(@"dummy--->%@",dummyArray);
    
    [siteList reloadData];
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
            if ([[[item objectForKey:@"site"] lowercaseString] rangeOfString:[searchTextString lowercaseString]].location != NSNotFound)
            {
                [searchArray addObject:item];
            }
        }
    }
    else
    {
        searchArray = dummyArray;
    }
    
    [siteList reloadData];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[searchArray objectAtIndex:indexPath.row]objectForKey:@"site"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    NSString *str;
//    
//    if ([str isEqualToString:@"0"])
//    {
//        //            UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"untick.png"]];
//        UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//        cell.accessoryView = checkmark;
//    }
//    else
//    {
//        //        UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick.png"]];
//        UIImageView *checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//        checkmark.image=[UIImage imageNamed:@"13.png"];
//        
//        cell.accessoryView = checkmark;
//    }

//            if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
//            {
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            }
//            else
//            {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            }
//
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ObjShared.sityName=[NSString stringWithFormat:@"%@",[[searchArray objectAtIndex:indexPath.row]objectForKey:@"site"]];
//    [self dismissViewControllerAnimated:YES completion:nil];
//
    
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }

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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
