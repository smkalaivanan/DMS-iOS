//
//  SiteViewController.m
//  DMS
//
//  Created by macbook on 22/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SiteViewController.h"
#import "SiteTableViewCell.h"

@interface SiteViewController ()
{
    NSMutableArray * dummyArray,* searchArray,* siteData;
    NSArray *sites;
    NSString *searchTextString;
    SiteTableViewCell * celling;
}
@end

@implementation SiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ObjShared = [SharedClass sharedInstance];

    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
//    NSLog(@"site--->%@",ObjShared.appDict);
    
    sites = [[ObjShared.appDict valueForKey:@"site_names"] valueForKey:@"sitename"];
    
    
    siteData = [[NSMutableArray alloc] init];
    for (int i=0; i<sites.count; i++)
    {
        [siteData addObject:@"0"];
    }
    [self searchtext];
    [self updateSearchArray];
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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
    static NSString * cellIdentifier = @"SiteTableViewCell";
    
    celling =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];

    
    // Configure the cell...
    celling.siteNameText.text = [[searchArray objectAtIndex:indexPath.row]objectForKey:@"site"];
    
    celling.siteButtonView.tag = indexPath.row;
    [celling.siteButtonView addTarget:self
                   action:@selector(animateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    celling.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([[siteData objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        celling.checkBoxImage.image = [UIImage imageNamed:@"checkbox-empty.png"];
    }
    else
    {
        celling.checkBoxImage.image = [UIImage imageNamed:@"checkbox.png"];
    }

    return celling;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)animateButton:(UIButton *)sender
{
//    UIButton * button = (UIButton *)sender;
//    button.selected = !button.selected;
    
    if ([[siteData objectAtIndex:sender.tag] isEqualToString:@"0"])
    {
        [siteData replaceObjectAtIndex:sender.tag withObject:[[searchArray objectAtIndex:sender.tag]objectForKey:@"site"]];
        celling.checkBoxImage.image = [UIImage imageNamed:@"checkbox.png"];
        [siteList reloadData];
    }
    else
    {
        [siteData replaceObjectAtIndex:sender.tag withObject:@"0"];
        celling.checkBoxImage.image = [UIImage imageNamed:@"checkbox-empty.png"];
        [siteList reloadData];
    }
}

-(IBAction)back:(id)sender
{
    NSLog(@"back");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)apply:(id)sender
{
    [siteData removeObject:@"0"];
    NSLog(@"site data -----> %@",siteData);

    if (siteData.count > 1)
    {
        ObjShared.siteName = [NSString stringWithFormat:@"%lu sites selected",(unsigned long)siteData.count];
    }
    else if (siteData.count == 0)
    {
        ObjShared.siteName =@"Select site";
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        ObjShared.siteName = [NSString stringWithFormat:@"%@",[siteData objectAtIndex:0]];
    }
    ObjShared.siteNameArray = siteData;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
