//
//  ApplyLoanTableViewCell.h
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyLoanTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel * customerName;
@property(nonatomic,retain) IBOutlet UILabel * customerNumber;
@property(nonatomic,retain) IBOutlet UILabel * customerEmail;
@property(nonatomic,retain) IBOutlet UILabel * customerStatus;
@property(nonatomic,retain) IBOutlet UIImageView * customerImage;




@end
