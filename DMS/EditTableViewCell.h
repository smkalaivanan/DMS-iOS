//
//  EditTableViewCell.h
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditTableViewCell : SWTableViewCell

@property(nonatomic,retain) IBOutlet UILabel *dealerName;
@property(nonatomic,retain) IBOutlet UILabel *work;
@property(nonatomic,retain) IBOutlet UILabel *mobile;
@property(nonatomic,retain) IBOutlet UILabel *email;
@property(nonatomic,retain) IBOutlet UILabel *place;
@property(nonatomic,retain) IBOutlet UIImageView *userImg;

@end
