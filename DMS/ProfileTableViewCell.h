//
//  ProfileTableViewCell.h
//  DMS
//
//  Created by apple on 2/2/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *profileImg;
@property(nonatomic,retain)IBOutlet UITextField *profileName;
@property(nonatomic,retain)IBOutlet UITextField *email;
@property(nonatomic,retain)IBOutlet UITextField *passoword;
@property(nonatomic,retain)IBOutlet UITextField *phone;
@property(nonatomic,retain)IBOutlet UIButton *save;
@property(nonatomic,retain)IBOutlet UIButton *imgPicker;
@property(nonatomic,retain)IBOutlet UIButton *chgPassword;
@property(nonatomic,retain)IBOutlet UIButton *edit;
@end
