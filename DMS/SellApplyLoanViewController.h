//
//  SellApplyLoanViewController.h
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellApplyLoanViewController : UIViewController
{
    IBOutlet UITableView * sellApplyTabel;
}
-(IBAction)AddButton:(id)sender;
-(IBAction)revokeAddFundings:(id)sender;

@end
