//
//  SellPostingTableViewCell.h
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellPostingTableViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UILabel * titleLabel;
@property (nonatomic,retain) IBOutlet UILabel * priceLabel;
@property (nonatomic,retain) IBOutlet UILabel * kilometerLabel;
@property (nonatomic,retain) IBOutlet UILabel * dateLabel;
@property (nonatomic,retain) IBOutlet UIImageView * postingImage;

@end
