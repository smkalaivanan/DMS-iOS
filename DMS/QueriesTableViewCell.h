//
//  QueriesTableViewCell.h
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueriesTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel * customerName;
@property(nonatomic,retain) IBOutlet UILabel * carModel;
@property(nonatomic,retain) IBOutlet UILabel * customerMessage;
@property(nonatomic,retain) IBOutlet UILabel * timeAgo;
@property(nonatomic,retain) IBOutlet UIImageView * customerImage;



@end
