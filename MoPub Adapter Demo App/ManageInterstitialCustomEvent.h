//
//  ManageInterstitialCustomEvent.h
//  ManageSDK
//
//  Created by Manage on 1/14/16.
//  Copyright (c) 2016 Manage. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#else
    #import "MPInterstitialCustomEvent.h"
#endif

#import <ManageSDK/ManageSDK.h>

static NSString * const kMNGZoneID = @"H0GhN97QZPWsMpZn_bC6WQ";

@class MNGInterstitialAd;
@protocol MNGInterstitialAdDelegate;

@interface ManageInterstitialCustomEvent : MPInterstitialCustomEvent<MNGInterstitialAdDelegate>

@property (nonatomic, strong) MNGInterstitialAd * adUnit;

@end
