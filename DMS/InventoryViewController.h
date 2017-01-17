//
//  InventoryViewController.h
//  DMS
//
//  Created by Kalaivanan on 27/12/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface InventoryViewController : UIViewController<UIScrollViewDelegate,SharedDelegate>
{
    IBOutlet UIView * segmentViewButton;
    IBOutlet UIView * headerView;
}
@end
