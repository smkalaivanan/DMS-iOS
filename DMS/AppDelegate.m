//
//  AppDelegate.m
//  DMS
//
//  Created by Kalaivanan on 14/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navigationController,rechabilityNavigationController;
+ (void) showAlert:(NSString *)title withMessage:(NSString *) msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title message: msg  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [application setStatusBarHidden:YES];

    
    ObjShared = [SharedClass sharedInstance];
    
    //AFNetworking Reachablity
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            ObjShared.InternetAvailable = YES;
        }
        else
        {
            UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            rechabilityNavigationController = [storyboard1 instantiateViewControllerWithIdentifier:@"navigationController"];
            NoInternetViewController * rechabilityVC =[storyboard1 instantiateViewControllerWithIdentifier:@"NoInternetViewController"];
            [[self navigationController] presentViewController:rechabilityVC animated:YES completion:nil];
            
            ObjShared.InternetAvailable = NO;
        }
    }];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)self.window.rootViewController;
    
    navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
        [container setRightMenuViewController:rightSideMenuViewController];
    [container setCenterViewController:navigationController];
    
    /* Initialize Hotline*/
    
    HotlineConfig *config = [[HotlineConfig alloc]initWithAppID:@"76d60240-e80b-40ec-8f59-e27c29a2c9e8"  andAppKey:@"d5fe0c9e-13d9-472c-87eb-2ea909047520"];
    
    [[Hotline sharedInstance] initWithConfig:config];
    
    // Setup user info
    HotlineUser *user = [HotlineUser sharedInstance];
    user.name = @"John Doe";
    user.email = @"john@example.com";
    user.phoneCountryCode = @"+91";
    user.phoneNumber = @"1232343231";
    
    [[Hotline sharedInstance] updateUser:user];
    
    //Update user properties with custom key
    [[Hotline sharedInstance] updateUserProperties:@{
                                                     @"paid_user" : @"yes",
                                                     @"plan" : @"blossom" }];
    
    NSLog(@"Unread messages count :%d", (int)[[Hotline sharedInstance]unreadCount]);
    
    //Check unread messages for the user
    [[Hotline sharedInstance]unreadCountWithCompletion:^(NSInteger count) {
        NSLog(@"Unread count (Async) : %d", (int)count);
    }];

    
    /* Enable remote notifications */
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else{
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        
    }
    
    [self.window makeKeyAndVisible]; // or similar code to set a visible view
    
    /*  Set your view before the following snippet executes */
    
    /* Handle remote notifications */
    if ([[Hotline sharedInstance]isHotlineNotification:launchOptions]) {
        [[Hotline sharedInstance]handleRemoteNotification:launchOptions
                                              andAppstate:application.applicationState];
    }
    
    /* Any other code to be executed on app launch */
    
    /* Reset badge app count if so desired */
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:(int)[[Hotline sharedInstance]unreadCount]];
    
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application{
    /* Reset badge app count if so desired */
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"token --- %@",deviceToken);
    [[Hotline sharedInstance] updateDeviceToken:deviceToken];
}

- (void) application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)info{
    if ([[Hotline sharedInstance]isHotlineNotification:info])
    {
        [[Hotline sharedInstance]handleRemoteNotification:info andAppstate:app.applicationState];
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:(int)[[Hotline sharedInstance]unreadCount]];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:(int)[[Hotline sharedInstance]unreadCount]];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DMS"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil)
                {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}


#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
