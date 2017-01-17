//
//  branchTableViewCell.h
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface branchTableViewCell : SWTableViewCell

@property(nonatomic,retain) IBOutlet UILabel *dealerName;
@property(nonatomic,retain) IBOutlet UILabel *dealerShipName;
@property(nonatomic,retain) IBOutlet UILabel *address;
@property(nonatomic,retain) IBOutlet UILabel *mobile;
@property(nonatomic,retain) IBOutlet UILabel *email;
@property(nonatomic,retain) IBOutlet UILabel *status;


@end
