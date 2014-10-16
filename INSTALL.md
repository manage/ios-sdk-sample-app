# iOS INTEGRATION GUIDE

### Overview

This guide provides integration instructions for the Manage Publisher iOS SDK.  If you need support or have any questions, feel free to email us at [support@appponsor.com](support@appsponsor.com)

### 1. Download and install the SDK

The SDK for iOS is available once you [sign up](https://www.appsponsor.com/user/registration). The Manage Publisher SDK includes everything you need to serve full screen interstitial, video, and playable ad units.

* Requirements:

- Apps must be compiled with iOS SDK version 6.0 or higher (may still target 5.0+)
- Runs only on devices with iOS SDK version 6.0 or higher

The SDK can be downloaded here: [ManageSDK-iOS-v3.1.zip](/downloads/ManageSDK-iOS-v3.1.zip).

To see an example implementation, please see our [sample app](https://github.com/manage/ios-sdk-sample-app).

### 2. Installing the SDK

1. To get started, unzip the SDK package and drag the **AppSponsorSDK.framework** onto your project's name in Xcode's Project Navigator:

 ![](https://s3.amazonaws.com/cdn.manage.com/appsponsor/documentation/ios/step-1.png)

2. Check the `Copy items if needed` for Destination, `Create Groups` for Added folders, and be sure to `Add to targets` for your project.

 ![](https://s3.amazonaws.com/cdn.manage.com/appsponsor/documentation/ios/step-2.png)

3. Click `Finish`. 

4. Then drag the `Resources` folder into your project.

  ![](https://s3.amazonaws.com/cdn.manage.com/appsponsor/documentation/ios/step-3.png)

5. Add these iOS SDK frameworks and libs into your project:

 *  libz.dylib
 *  libstdc++.dylib
 *  AudioToolbox.framework
 *  QuartzCore.framework
 *  OpenGLES.framework
 *  Security.framework
 *  CFNetwork.framework
 *  Accelerate.framework
 *  SystemConfiguration.framework
 *  CoreMotion.framework
 *  CoreGraphics.framework
 *  UIKit.framework
 *  Foundation.framework
 *  AdSupport.framework
 *  CoreLocation.framework
 *  CoreFoundation.framework
 *  StoreKit.framework 

  ![](https://s3.amazonaws.com/cdn.manage.com/appsponsor/documentation/ios/step-4.png)

### 3. Integrating Manage SDK

1. Import the Manage SDK:

```
#import <AppSponsorSDK/ASPopupAd.h>
```

and create a property for the ad controller

```
@property(nonatomic, strong) ASPopupAd * adController;

/* Rewarded ad */
@property(nonatomic, strong) ASPopupAd * rewaredAdController;
```

You will then need to initialize the ad controller with the Zone ID created on the website and set the listener delegate

```
self.adController = [[ASPopupAd alloc] initWithZoneId:@"YOUR ZONE ID"];

/* Rewarded ad */
self.rewaredAdController = [[ASPopupAd alloc] initRewardedAdWithZoneId:@"YOUR ZONE ID" andUserID:@"PUBLISHER USER ID"];
```

You can also enable location support by adding **enableLocationSupport**

```
self.adController = [[[ASPopupAd alloc] enableLocationSupport] initWithZoneId:@"YOUR ZONE ID"];

/* Rewarded ad */
self.rewaredAdController = [[ASPopupAd alloc enableLocationSupport] initRewardedAdWithZoneId:@"YOUR ZONE ID" andUserID:@"PUBLISHER USER ID"];
```

#### 3.1. Improve Ad Targeting by setting non PII user data:

```
@property(nonatomic, assign)NSString *country;
@property(nonatomic, assign)NSString *region;
@property(nonatomic, assign)NSString *metro;
@property(nonatomic, assign)NSString *city;
@property(nonatomic, assign)NSString *zip;
@property(nonatomic, assign)Gender   *gender;
@property(nonatomic, assign)NSString *yob;
@property(nonatomic, assign)NSString *u_country;
@property(nonatomic, assign)NSString *u_city;
@property(nonatomic, assign)NSString *u_zip;
@property(nonatomic, assign)NSString *keywords;
@property(nonatomic, assign)NSString *longitude;
@property(nonatomic, assign)NSString *latitude;
@property(nonatomic, assign)NSString *pub_uid;
```

For example:

```
self.adController.gender = "M";
self.adController.country = @"USA";
self.adController.city = @"San Francisco";
self.adController.keywords = @"game,shopping";
```

#### 3.2 Pre-Cached Ads 

```
[self.adController load];

/* Rewarded ad */
[self.rewaredAdController load];
```

To show ad:

```
if ([self.adController isReady]) {
    [self.adController presentAd];
}

/* Rewarded ad */
if ([self.rewaredAdController isReady]) {
    [self.rewaredAdController presentAd];
}
```

#### 3.3 Load and Present Ad Synchronously

```
[self.adController loadAndPresentAd];

/* Rewarded ad */
[self.rewaredAdController loadAndPresentAd];

```

### 4. Optional steps

#### Delegate Methods

AppSponsor SDK has delegate methods that are useful for controlling the ad state.

Declare your controller support ASPopupAdDelegate, then implement these functions.

Before using any delegates, you should set the delegate. A good place to add this is the same place you initialize Manage SDK.

1. These following delegates may be triggered after the `load()` function:

```
-(void)didCacheInterstitial;

-(void)popoverDidFailToLoadWithError:(NSError*)error;
```

2. These following delegates will always be triggered after the `presentAd()` function:

```
-(void)popoverWillAppear;

-(void)popoverWillDisappear:(NSString*)reason;
```

3. Rewarded Ad complete delegate:

```
-(void)onRewardedAdFinished;
```

For example:

```
-(void)onRewardedAdFinished {
    if ([self.rewardedAdController rewardedAdStatus] >= 75) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
        message:@"You have earned coins!"
        delegate: nil
        cancelButtonTitle: @"OK"
        otherButtonTitles: nil];
        [alert show];
    }
}
```
