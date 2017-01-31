//
//  bidsPostedViewController.h
//  DMS
//
//  Created by macbook on 10/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface bidsPostedViewController : UIViewController
{
    IBOutlet UITableView *bidTable;
}
-(IBAction)side:(id)sender;
@property(nonatomic,retain) IBOutlet UITableView *bidTable;

@end
