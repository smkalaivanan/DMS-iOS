//
//  SellQueriesViewController.h
//  DMS
//
//  Created by Kalaivanan on 28/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellQueriesViewController : UIViewController
{
    NSDictionary * sellQueriesDict;
}
@property(nonatomic,retain)IBOutlet UITableView * sellQueriesTable;

@end
