//
//  SharedClass.m
//  DMS
//
//  Created by macbook on 23/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass
@synthesize sharedDelegate,footerText,footerArray,inventoryFooterText;

#pragma mark - Init Method

+ (id)sharedInstance
{
    
    //Below Static variable will hold the instance of this Class(i.e Shared Class)
    static SharedClass *sharedC = nil;
    
    // Below static variable will ensure that initalization code executes only once
    static dispatch_once_t onetoken;
    
    /* Below block will initalize instance of Login Class. And this will be executed only once.
     * Next time coming back to this class won't execute the block
     */
    dispatch_once(&onetoken,^{
        sharedC = [[SharedClass alloc] init];
        
    });
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return sharedC;
}


#pragma mark - Navigation


+ (void)NavigateTo:(UIViewController*)destinationVC inNavigationViewController:(UINavigationController*)navigationController animated:(BOOL)animated
{
    
    //Update slider
    //  [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateProfile" object: nil];
    
    
    BOOL VCfound = NO;
    NSArray *viewControllers = navigationController.viewControllers;
    NSInteger indexofVC = 0;
    
    for (UIViewController *vc in viewControllers)
    {
        if ([vc isKindOfClass:[destinationVC class]])
        {
            //It exists
            indexofVC = [viewControllers indexOfObject:vc];
            VCfound = YES;
            break;
        }
        
    }
    
    if (VCfound == YES)
    {
        destinationVC = nil;
        [navigationController popToViewController:[viewControllers objectAtIndex:indexofVC] animated:animated];
    }
    else
    {
        
        [navigationController pushViewController:destinationVC animated:animated];
        
    }
    
}



#pragma mark -Check Internet

//Check Internet
- (BOOL)connected
{
//    [CommonMethods ShowAlert:@"Internet" andDescription:@"Make Sure your internet connection is working"];
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


- (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block
{
}

#pragma mark - W.S call

- (void) callWebServiceWith_DomainName:(NSString *)domainStr postData:(NSMutableDictionary *)parameters
{
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager setSecurityPolicy:policy];
    NSString *Path = [NSString stringWithFormat:@"%@%@", SERVERPATH, domainStr];
    
    [manager POST:Path
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              
              if ([sharedDelegate respondsToSelector:@selector(successfulResponseFromServer:)]){
                  [sharedDelegate successfulResponseFromServer:json];
              }
              
//              NSLog(@"%@",json);
              json = nil;
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@" Error: %@",  error);
              //    [CommonMethods ShowAlert:@"FAILED" andDescription:@"Failed to connect to server .Please restart your app"];
//              [[VSRActivityController makeText:@""] hide];
              
          }];
    domainStr = nil;
    parameters = nil;
}


- (void) callWebServiceWith_DomainName:(NSString *)domainStr getData:(NSMutableDictionary*)parameters
{
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    
    manager = [AFHTTPRequestOperationManager manager];
    [manager setSecurityPolicy:policy];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // [manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    NSString *Path = [NSString stringWithFormat:@"%@%@",SERVERPATH,domainStr];
    
    
    [manager GET:Path parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             
             //NSString *statusStr = [NSString stringWithFormat:@"%@",[[json objectForKey:@"response"] objectForKey:@"status"]];
             
             if ([sharedDelegate respondsToSelector:@selector(successfulResponseFromServer:)])
             {
                 [sharedDelegate successfulResponseFromServer:json];
                 
             }
             //NSLog(@"%@",json);
             json = nil;
             
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             [[VSRActivityController makeText:@""] hide];
             
             if ([sharedDelegate respondsToSelector:@selector(failResponseFromServer)])
             {
                 [sharedDelegate failResponseFromServer];
             }
             
             NSLog(@"error %@", error);
         }];
    
    domainStr = nil;
    parameters = nil;
}

- (void)CancelAllWS
{
    //manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
}


@end
