//
//  SavedcarViewController.h
//  DMS
//
//  Created by macbook on 08/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewCell.h"
#import "headerTableViewCell.h"
#import "DashboardCollectionViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SavedcarViewController : UIViewController
{
   
    NSMutableArray *like;
    IBOutlet UIButton *city;
    IBOutlet UITextField *searchText;
    int apiCall;
    IBOutlet UITableView *searchTable;
}


@end
