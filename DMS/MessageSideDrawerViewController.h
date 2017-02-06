//
//  MessageSideDrawerViewController.h
//  DMS
//
//  Created by Kalaivanan on 11/01/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSideDrawerViewController : UIViewController<SharedDelegate>
@property(nonatomic,retain)IBOutlet UITableView * messageTable;
@end
