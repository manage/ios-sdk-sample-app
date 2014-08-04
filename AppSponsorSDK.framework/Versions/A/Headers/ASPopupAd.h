//
//  ASPopupAd.h
//  AppSponsorSDKFramework
//
//  Created by frank wang on 3/31/14.
//  Copyright (c) 2014 manage. All rights reserved.
//
#define AS_SDK_VERSION                 @"3.0.3"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Ad disappear because user has clicked on it
 */
static NSString * const kASReasonUserClicked = @"clicked";
/**
 * Ad disappear because user has closed ad playing activity
 */
static NSString * const kASReasonUserClosed = @"close";
/**
 * Ad disappear because of some error
 */
static NSString * const kASError = @"error";
	
static NSString * const kASEnableLocationSupportKey = @"enableLocationSupport";

static NSString * const kASCountryKey = @"country";
static NSString * const kASCityKey = @"city";
static NSString * const kASRegionKey = @"region";
static NSString * const kASMetroKey = @"metro";
static NSString * const kASZipKey = @"zip";

static NSString * const kASUCountryKey = @"u_country";
static NSString * const kASUCityKey = @"u_city";
static NSString * const kASUZipKey = @"u_zip";
static NSString * const kASLatitudeKey = @"latitude";
static NSString * const kASLongitudeKey = @"longitude";

static NSString * const kASGenderKey = @"gender";
static NSString * const kASYearOfBirthKey = @"yob";
static NSString * const kASKeywordsKey = @"keywords";
static NSString * const kASPublicUidKey = @"pub_uid";
static NSString * const kASPlatformKey = @"pf";


static NSString * const kASErrorDomain = @"com.AppSponsor.SDK";

typedef enum { AS_MALE = 1, AS_FEMALE = 2, AS_OTHER = 3 } Gender;

@protocol ASPopupAdDelegate <NSObject>
/**
 * Called when ad is loaded and going to be presented to user.
 */
- (void)popoverWillAppear;
/**
 * Called when ad is going to be dismissed by some reason.
 * @param reason - Ad dismiss reason.
 */
- (void)popoverWillDisappear:(NSString*)reason;
@optional
/**
 * Called once ad is loaded
 */
- (void)didCacheInterstitial;
/**
 * Called if some error has happened during the ad playing cycle
 * @param exception - Error occurred
 */
- (void)popoverDidFailToLoadWithError:(NSError*)error;
/**
 * Called once rewarded ad was completely played
 */
- (void)onRewardedAdFinished;
@end

@class ASAdContext;
@interface ASPopupAd : NSObject

@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, weak) id<ASPopupAdDelegate> delegate;

@property (nonatomic, strong) NSString *zoneId;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *metro;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, assign) Gender* gender;
@property (nonatomic, strong) NSString *yob;
@property (nonatomic, strong) NSString *u_country;
@property (nonatomic, strong) NSString *u_city;
@property (nonatomic, strong) NSString *u_zip;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *pub_uid; //user id within publisher app
@property (nonatomic, strong) NSString* pf;
@property (nonatomic, strong) ASAdContext *adContext;

- (ASPopupAd*)enableLocationSupport;
- (ASPopupAd*)initWithZoneId:(NSString*)adId;
- (ASPopupAd*)initRewardedAdWithZoneId:(NSString*)adId andUserID:(NSString*)uid;

/**
 * Asynchronously loads ad. Use {@link #isReady() isReady} method to check whether ad is loaded or not.
 */
- (void)load;

/**
 * Shows ad in separate activity. Call is ignored if ad is not yet loaded.
 */
- (void)presentAd;

/**
 * @return boolean Return true if ad load is finished.
 */
- (BOOL)isReady;

/**
 * @return int percentage (0 - 100) of video ad being played
 */
- (NSInteger)rewardedAdStatus;

@end
