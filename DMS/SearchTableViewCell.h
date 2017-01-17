//
//  SearchTableViewCell.h
//  DMS
//
//  Created by macbook on 22/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UIImageView *carImage;
@property(nonatomic,retain) IBOutlet UIImageView *siteImage;
@property(nonatomic,retain) IBOutlet UIImageView *bidImage;

@property(nonatomic,retain) IBOutlet UILabel *carName;
@property(nonatomic,retain) IBOutlet UILabel *carPrice;
@property(nonatomic,retain) IBOutlet UILabel *CarKm;
@property(nonatomic,retain) IBOutlet UILabel *PhotoNumber;
@property(nonatomic,retain) IBOutlet UILabel *postedDate;

@property(nonatomic,retain) IBOutlet UIButton *heart;
@property(nonatomic,retain) IBOutlet UIButton *reminder;
@property(nonatomic,retain) IBOutlet UIButton *compare;
@property(nonatomic,retain) IBOutlet UIButton *viewBitButton;
@property(nonatomic,retain) IBOutlet UIButton *makeOfferButtom;



@end
