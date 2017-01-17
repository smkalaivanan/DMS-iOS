//
//  SiteTableViewCell.h
//  DMS
//
//  Created by Kalaivanan on 22/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel * siteNameText;
@property(nonatomic,retain) IBOutlet UIButton * siteButtonView;
@property(nonatomic,retain) IBOutlet UIImageView * checkBoxImage;

@end
