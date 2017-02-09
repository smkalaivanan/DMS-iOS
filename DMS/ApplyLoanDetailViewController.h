//
//  ApplyLoanDetailViewController.h
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyLoanDetailViewController : UIViewController
{
    IBOutlet UIImageView * customerImage;
    IBOutlet UILabel * statusLabel;
    IBOutlet UITableView * detailFundingTable;
    IBOutlet UIButton * revokeButton;
}
@end
