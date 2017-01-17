//
//  myUserTableViewCell.h
//  DMS
//
//  Created by macbook on 05/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface myUserTableViewCell :SWTableViewCell

@property(nonatomic,retain) IBOutlet UILabel *userId;
@property(nonatomic,retain) IBOutlet UILabel *role;
@property(nonatomic,retain) IBOutlet UILabel *branch;

@end
