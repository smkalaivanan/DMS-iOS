//
//  searchViewController.h
//  DMS
//
//  Created by macbook on 22/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewCell.h"
#import "headerTableViewCell.h"
#import "DashboardCollectionViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface searchViewController : UIViewController<SharedDelegate>
{
    NSArray * footerArray;
    NSArray * footerText;
    NSMutableArray *like;
    IBOutlet UIButton *city;
    IBOutlet UITextField *searchText;
    int apiCall;
    IBOutlet UITableView *searchTable;
}
@property(nonatomic,retain)NSMutableDictionary *para;
-(IBAction)search:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)city:(id)sender;
-(IBAction)filter:(id)sender;
-(IBAction)compare:(id)sender;
-(IBAction)sort:(id)sender;



@end
