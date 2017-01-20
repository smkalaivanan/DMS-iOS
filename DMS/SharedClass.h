//
//  SharedClass.h
//  DMS
//
//  Created by macbook on 23/11/16.
//  Copyright © 2016 Falconnect Technologies Pvt Ltd. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "SWTableViewCell.h"

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
@property (nonatomic, retain) NSDictionary * searchPageDict;
@property (nonatomic, retain) NSDictionary * applyFundingPageDict,*sellApplyFundingDict;
@property (nonatomic, retain) NSDictionary * bidCaridDetail;

@property (nonatomic, retain) NSString * Cityname;
@property (nonatomic, retain) NSString * siteName;

@property (nonatomic,retain) NSArray *footerArray;
@property (nonatomic,retain) NSArray *footerText, *inventoryFooterText,*manageFooterText;
@property (nonatomic,retain) NSArray *siteNameArray;

@property (nonatomic,retain) NSMutableArray *array;



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
