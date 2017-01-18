//
//  SelectionViewController.m
//  DMS
//
//  Created by macbook on 18/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SelectionViewController.h"
#import "SiteTableViewCell.h"

@interface SelectionViewController ()
{
    SiteTableViewCell * celling;
    NSMutableArray * siteData;
    IBOutlet UITableView *siteList;

}

@end

@implementation SelectionViewController
@synthesize choose,single,selection;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    siteData=[[NSMutableArray alloc]init];
    for (int i=0; i<choose.count; i++)
    {
        [siteData addObject:@"0"];
    }
    
    ObjShared.array=[[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Shared
    
    ObjShared = nil;
    ObjShared = [SharedClass sharedInstance];
    ObjShared.sharedDelegate = nil;
    ObjShared.sharedDelegate = (id)self;
    
    ObjShared.array=[[NSMutableArray alloc]init];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return choose.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"SiteTableViewCell";
    
    celling =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
    
    
    // Configure the cell...
    celling.siteNameText.text =[choose objectAtIndex:indexPath.row];
    
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
   
    if (single == 0)
    {
        NSLog(@"butoon tag--->%ld",(long)sender.tag);
        if ([[siteData objectAtIndex:sender.tag] isEqualToString:@"0"])
        {
            [siteData replaceObjectAtIndex:sender.tag withObject:[choose objectAtIndex:sender.tag]];
            celling.checkBoxImage.image = [UIImage imageNamed:@"checkbox.png"];
            [siteList reloadData];
        }
        else
        {
            [siteData replaceObjectAtIndex:sender.tag withObject:@"0"];
            celling.checkBoxImage.image = [UIImage imageNamed:@"checkbox-empty.png"];
            [siteList reloadData];
        }

        
        [self apply];
    }
    else
    {
        
        NSLog(@"butoon tag--->%ld",(long)sender.tag);
        if ([[siteData objectAtIndex:sender.tag] isEqualToString:@"0"])
        {
            [siteData replaceObjectAtIndex:sender.tag withObject:[choose objectAtIndex:sender.tag]];
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
}

-(IBAction)back
{
    NSLog(@"back");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)apply
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
    
    
    [ObjShared.array addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:siteData,[NSString stringWithFormat:@"%@",selection], nil]];

    
//    [ObjShared.array setObject:siteData forKey:[NSString stringWithFormat:@"%@",selection]];
    
    NSLog(@"array--->%@",ObjShared.array);

    
    ObjShared.siteNameArray = siteData;
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
