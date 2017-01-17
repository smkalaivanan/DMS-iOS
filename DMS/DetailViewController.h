//
//  DetailViewController.h
//  DMS
//
//  Created by macbook on 23/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    IBOutlet UIButton *heart;
    IBOutlet UIScrollView *imageScroll;
    IBOutlet UICollectionView *collection;
    IBOutlet UIWebView *webView;
}
-(IBAction)back:(id)sender;

@end
