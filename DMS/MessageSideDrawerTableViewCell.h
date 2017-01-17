//
//  MessageSideDrawerTableViewCell.h
//  DMS
//
//  Created by Kalaivanan on 11/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSideDrawerTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel * messageLabel;
@property(nonatomic,retain) IBOutlet UILabel * timeStampLabel;
@property(nonatomic,retain) IBOutlet UIImageView * imageHolder;

@end
