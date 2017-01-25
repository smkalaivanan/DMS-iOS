//
//  NoInternetViewController.m
//  DMS
//
//  Created by apple on 1/25/17.
//  Copyright © 2017 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "NoInternetViewController.h"

@interface NoInternetViewController ()

@end

@implementation NoInternetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tryagain.layer.cornerRadius = 10;
    tryagain.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)internet:(id)sender
{
    if (ObjShared.InternetAvailable == YES)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertNetNotFound = [[UIAlertView alloc]initWithTitle:@"No Internet" message:@"Please Check Your Internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertNetNotFound show];
    }
}

@end
