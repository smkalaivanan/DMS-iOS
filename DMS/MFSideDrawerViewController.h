//
//  MFSideDrawerViewController.h
//  DMS
//
//  Created by Kalaivanan on 17/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFSideDrawerViewController : UIViewController<SharedDelegate>
{
    NSArray *menu;
    NSArray *menuImg;
    IBOutlet UIImageView *profileImg;
    IBOutlet UILabel *nameLab;
    IBOutlet UILabel *addressLab;
    IBOutlet UIButton *profileBut;
    IBOutlet UITableView *menuTable;
}
-(IBAction)profile:(id)sender;
@end
