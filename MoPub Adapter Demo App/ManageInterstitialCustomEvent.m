//
//  ManageInterstitialCustomEvent.m
//  ManageSDK
//
//  Created by Manage on 1/14/16.
//  Copyright (c) 2016 Manage. All rights reserved.
//

#import "ManageInterstitialCustomEvent.h"
#import "MPInstanceProvider.h"
#import "MPLogging.h"

@interface MPInstanceProvider (ManageInterstitials)

- (MNGInterstitialAd *)buildMNGInterstitialAdWithDelegate:(id<MNGInterstitialAdDelegate>) delegate zoneId:(NSString*)zid;
- (MNGInterstitialAd *)buildRewardedMNGInterstitialAdWithDelegate:(id<MNGInterstitialAdDelegate>) delegate zoneId:(NSString*)zid userId:(NSString*)userId;

@end

@implementation MPInstanceProvider (ManageInterstitials)

- (MNGInterstitialAd *)buildMNGInterstitialAdWithDelegate:(id<MNGInterstitialAdDelegate>) delegate zoneId:(NSString*)zid
{
    MNGInterstitialAd * ad = [[MNGInterstitialAd alloc] initWithZoneId:zid];
    ad.delegate = delegate;
    
    return ad;
}

- (MNGInterstitialAd *)buildRewardedMNGInterstitialAdWithDelegate:(id<MNGInterstitialAdDelegate>) delegate zoneId:(NSString*)zid userId:(NSString*)userId
{
    MNGInterstitialAd * ad = [[MNGInterstitialAd alloc] initRewardedAdWithZoneId:zid andUserID:userId];
    ad.delegate = delegate;
    
    return ad;
}

@end

@implementation ManageInterstitialCustomEvent


#pragma mark CustomEvent Overrides

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    NSString *zid = info[zid] ? info[zid] : kMNGZoneID;
    if (zid.length == 0)
    {
         MPLogError(@"Zone ID not set. Please set constant in ManageInterstitialCustomEvent.h or thru MoPub Custom Network Data.");
    }
    
    /*  
        If rewardable zone, please set your publisher user ID here.
        You may need to call your app delegate if the publisher user ID is set there.
        For more information on rewarded ads, please see: https://my.manage.com/publisher/guides/rewarded_ad_callback/
    */

     NSString *publisherUserId = @"";
    
    if (publisherUserId.length == 0)
    {
        self.adUnit = [[MPInstanceProvider sharedProvider] buildMNGInterstitialAdWithDelegate:self zoneId:zid];
    }
    else
    {
        self.adUnit = [[MPInstanceProvider sharedProvider] buildRewardedMNGInterstitialAdWithDelegate:self zoneId:zid userId:publisherUserId];
    }

    [self.adUnit load];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    self.adUnit.parentController = rootViewController;
    [self.adUnit presentAd];
}

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    return YES;
}

#pragma mark MNGInterstitialAdDelegate

- (void)popoverWillAppear
{
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)popoverWillDisappear:(NSString*) reason
{
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)didCacheInterstitial
{
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}

- (void)popoverDidFailToLoadWithError:(NSError*) error
{
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)onRewardedAdFinished
{
    // include custom callback here
}

#pragma mark additional delegate methods

- (void)popoverDidAppear
{
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)popoverDidDisappear
{
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)popoverWasTapped
{
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void)willLeaveApplication
{
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)dealloc
{
    self.adUnit.delegate = nil;
}

@end
