//
//  BidDetailTableViewCell.h
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidDetailTableViewCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UILabel *name;
@property (nonatomic,retain) IBOutlet UILabel *price;
@property (nonatomic,retain) IBOutlet UILabel *time;

@end
