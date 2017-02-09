//
//  FundingDetailViewController.h
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundingDetailViewController : UIViewController
{
    IBOutlet UIButton * revokeButton;
    IBOutlet UITableView * detailFundingTable;
    IBOutlet UILabel * statusLabel;

}
-(IBAction)back:(id)sender;

@end
