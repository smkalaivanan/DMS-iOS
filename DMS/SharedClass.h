//
//  SharedClass.h
//  DMS
//
//  Created by macbook on 23/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@protocol  SharedDelegate <NSObject>

@optional
- (void) successfulResponseFromServer:(NSDictionary *)dict;
- (void) failResponseFromServer;
- (void) downloadComplete:(NSString *)mediaType;


@end


@interface SharedClass : NSObject
{
    AFHTTPRequestOperationManager *manager;
}

//Self delegate
@property (strong, nonatomic) id <SharedDelegate> sharedDelegate;

//Internet availability
//@property(nonatomic ,strong) Reachability *internetReachable;
@property (nonatomic) BOOL InternetAvailable;
@property (nonatomic, retain) NSDictionary * appDict;
@property (nonatomic, retain) NSDictionary * LoginDict;
@property (nonatomic, retain) NSString * Cityname;
@property (nonatomic, retain) NSDictionary * searchPageDict;
@property (nonatomic,retain) NSArray *footerArray;
@property (nonatomic,retain) NSArray *footerText;

@property (nonatomic)int collectionZ;


+ (id) sharedInstance;

//Navigation
+ (void)NavigateTo:(UIViewController*)destinationVC inNavigationViewController:(UINavigationController*)navigationController animated:(BOOL)animated;



//AFNetworking Web service call
//Post
- (void) callWebServiceWith_DomainName:(NSString *)domainStr postData:(NSMutableDictionary *)parameters;
//Get
- (void) callWebServiceWith_DomainName:(NSString *)domainStr getData:(NSMutableDictionary *)parameters;
- (void)CancelAllWS;
@end
