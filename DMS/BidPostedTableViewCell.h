//
//  BidPostedTableViewCell.h
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidPostedTableViewCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UIImageView *carImg;
@property (nonatomic,retain) IBOutlet UIImageView *stausImg;
@property (nonatomic,retain) IBOutlet UIImageView *dealerImg;
@property (nonatomic,retain) IBOutlet UILabel *name;
@property (nonatomic,retain) IBOutlet UILabel *price;
@property (nonatomic,retain) IBOutlet UILabel *time;
@property (nonatomic,retain) IBOutlet UILabel *posted;


@end
