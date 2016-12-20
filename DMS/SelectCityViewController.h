//
//  SelectCityViewController.h
//  DMS
//
//  Created by macbook on 08/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityViewController : UIViewController
{
    IBOutlet UITableView *cityList;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
-(IBAction)back:(id)sender;
@end
