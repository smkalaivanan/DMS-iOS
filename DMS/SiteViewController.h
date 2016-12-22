//
//  SiteViewController.h
//  DMS
//
//  Created by macbook on 22/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteViewController : UIViewController<SharedDelegate>
{
    IBOutlet UITableView *siteList;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
-(IBAction)back:(id)sender;
@end
