//
//  DashboardViewController.h
//  DMS
//
//  Created by Kalaivanan on 17/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZPicker.h"

@interface DashboardViewController : UIViewController<SharedDelegate>
{
    NSArray * budget;
    NSArray * type;
    NSArray * sites;
    NSArray * vehicleType;
    IBOutlet UIButton * showWithMultipleSelection;
    IBOutlet UIButton * showWithoutFooter;
    IBOutlet UIButton * showBudget;
    IBOutlet UIButton * showVehicle;
    NSInteger segValue;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIButton *search;
}
-(IBAction)segment:(UISegmentedControl *)sender;
-(IBAction)search:(id)sender;

//@property CZPickerView *showWithoutFooter;

@end
