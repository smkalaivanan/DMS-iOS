//
//  AppDelegate.h
//  DMS
//
//  Created by Kalaivanan on 14/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "NoInternetViewController.h"
#import "Hotline.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UINavigationController *rechabilityNavigationController;



- (void)saveContext;

+ (void) showAlert:(NSString *)title withMessage:(NSString *) msg;

@end

