//
//  MyQueriesTableViewCell.h
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQueriesTableViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UIImageView *carImg;
@property (nonatomic,retain) IBOutlet UIImageView *dealerImg;

@property (nonatomic,retain) IBOutlet UILabel *dealerName;
@property (nonatomic,retain) IBOutlet UILabel *carName;
@property (nonatomic,retain) IBOutlet UILabel *msg;
@property (nonatomic,retain) IBOutlet UILabel *time;

@end
