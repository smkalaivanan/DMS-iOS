//
//  BidsDetailViewController.h
//  DMS
//
//  Created by macbook on 15/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidsDetailViewController : UIViewController
{
    IBOutlet UILabel *carName;
    IBOutlet UILabel *delarName;
    IBOutlet UILabel *delarPosition;
    IBOutlet UIImageView *carImage;
    IBOutlet UIImageView *delarImage;
    IBOutlet UITextField * bidText;
}
-(IBAction)bidButton:(id)sender;
-(IBAction)back:(id)sender;

@end
