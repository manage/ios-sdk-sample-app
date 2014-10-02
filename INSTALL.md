i#iOS INTEGRATION GUIDE


###Overview
This guide provides integration instructions for the Manage Publisher iOS SDK.  If you need support or have any questions, feel free to email us at [support@appponsor.com](support@appsponsor.com)

If you are using the **OLDER SDK Version 2.x.x**, please refer to [this guide](https://appsponsor.com/site/page/?view=install_iOS_old).

###1. Download and install the SDK
The SDK for iOS is available once you [sign up](https://www.appsponsor.com/user/registration).  The Manage Publisher SDK includes everything you need to serve full screen interstitial, video, and playable ad units.


**Requirements**:

- Apps must be compiled with iOS base SDK v6.0 or higher (may still target 5.0+)
- Runs only on devices with iOS version 6.0 or higher

A Sample Xcode App is available at https://github.com/manage/ios-sdk-sample-app

###2. Installing the SDK
To get started, `unzip the SDK package` and drag the **AppSponsorSDK.framework** onto your project's name in Xcode's Project Navigator:

```Insert Drag n’ Drop Screen Shot```

`Check the box next to Copy items into destination group's folder`, and be sure the radio button next to Create groups for any added folders is selected. Then, `click Finish`. Also, `drag the Resources folder next to AppSponsorSDK.framework into your project`, so the close button for ad content can be displayed properly.

```Insert Copy Items Screen Shot```


Next, add/set these frameworks as **Optional**:
1.	AdSupport
2.	CoreLocation.framework
3.	StoreKit.framework 
	
Add these frameworks and libs as **Required**:

1.	libz.dylib
2.	libstdc++.dylib
3.	AudioToolbox.framework
4.	QuartzCore.framework
5.	OpenGLES.framework
6.	Security.framework
7.	CFNetwork.framework
8.	Accelerate.framework
9.	SystemConfiguration.framework
10.	CoreMotion.framework
11.	CoreGraphics.framework
12.	UIKit.framework
13.	Foundation.framework

```Insert Frameworks Screen Shot```

###3. Adding the Controller
Next `Copy` the following code to the top of the controller that you plan to show the Manage ad

```#import <AppSponsorSDK/ASPopupAd.h>```

and create a property for the ad controller

```@property(nonatomic, strong) ASPopupAd * displayController;```


```Insert Import Screen Shot```


You will then need to `initialize the ad controller` with the Zone ID created on the website and set the listener delegate

```_controller = [[ASPopupAd alloc] initWithZoneId:AD_ZONE];```

You can enable location support by adding **enableLocationSupport**

```_controller = [[[ASPopupAd alloc] enableLocationSupport] initWithZoneId:AD_ZONE];```


```Insert implementation Screen Shot```


In order to show an ad, you'll need to first call a load for an ad. This is an **ASYNCRONOUS** process so you cannot immediately present the ad.

```[_controller load];```

And then later on in your code you can check if the ad is ready and then present the ad.

```if ([_controller isReady]) [_controller presentAd];```

For advanced callback delegates, which are useful for controlling ad state, please see the ‘Optional Steps’ section

###4. Rewarded Ads
Please follow [Install Guide - Server to Server](https://appsponsor.com/site/page/?view=install_server2server) to set up your zone to support Rewarded Ads First. In order to use Rewarded Ads, you must use the new constructor for this type of ad. There are additional delegates to help you use the rewarded functionality.

```//Rewarded ad should use this constructor to init ad _controller = [[ASPopupAd alloc] initRewardedAdWithZoneId:REWARDED_AD_ZONE_ID andUserID:App_UID];```

There are also new optional delegate function triggers when a Rewarded Ad finishes playing.

`-(void)onRewardedAdFinished;`

Function **isReady** returns true if the rewarded ad is ready to play. 
And function **rewardedAdStatus** tells you what percentage of the ad has finished playing.

```
//Sample code on checking rewarded available and play 
if (![self.rewardedAdController isReady]) {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
  message:@"Rewarded ad is not ready yet."
  delegate:nil
  cancelButtonTitle:@"OK"
  otherButtonTitles:nil];
  [alert show];
}

//sample code to reward user after viewing it
-(void)onRewardedAdFinished{
 if ([self.rewardedAdController rewardedAdStatus] >= 75) {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulation"
  message:@"You have earned 10 coins!"
  delegate:nil
  cancelButtonTitle:@"OK"
  otherButtonTitles:nil];
  [alert show];
  //to improve user experience, you can do precache
  [self.rewardedAdController load];  }
} 
```


###5. Best practices/Caching
You can pre-cache Ad content by calling function load, and implement **didCacheInterstitial** delegate method to get notified. This will allow you to present the ad as soon as it's ready.

```
[_controller load];

_controller.delegate = self;
-(void)didCacheInterstitial{
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Available"
  message:@"Ad Loaded"
  delegate:nil
  cancelButtonTitle:@"OK"
  otherButtonTitles:nil];
[alert show];
}
```


###6. Optional steps: Delegate Methods
The Manage SDK has delegate methods that are useful for controlling the ad state.
Declare your controller support **ASPopupAdDelegate**, then implement these functions.
Before using any delegates, you should set the delegate. A good place to add this is the same place you initialize the Manage SDK.

```_controller.delegate = self;```


The following delegates may be triggered after the **load** function.

```
//called when the ad content finishes loading. Use this to know when you can show your ad

-(void)didCacheInterstitial;

//called when the ad content fails to return.

-(void)popoverDidFailToLoadWithError:(NSError*)error;
```
These following delegates will always be triggered after the **presentAd** function.
```
//called before the ad content shows up. For example, you can pause app game play
-(void)popoverWillAppear;

//called before the ad content disappear. For example, you can resume app game play
-(void)popoverWillDisappear:(NSString*)reason;
```

Additional data can be sent to the Manage server to improve targeting:

```
@property(nonatomic, assign)NSString *country;
@property(nonatomic, assign)NSString *region;
@property(nonatomic, assign)NSString *metro;
@property(nonatomic, assign)NSString *city;
@property(nonatomic, assign)NSString *zip;
@property(nonatomic, assign)Gender *gender;
@property(nonatomic, assign)NSString *yob;
@property(nonatomic, assign)NSString *u_country;
@property(nonatomic, assign)NSString *u_city;
@property(nonatomic, assign)NSString *u_zip;
@property(nonatomic, assign)NSString *keywords;
@property(nonatomic, assign)NSString *longitude;
@property(nonatomic, assign)NSString *latitude;
@property(nonatomic, assign)NSString *pub_uid;
```

Example:

```
_controller.gender = AS_MALE;
_controller.country = @"US";
_controller.city = @"San jose";
_controller.keywords = @"game,shopping";```
```

###7. Your Stats Dashboard
Now that you are up and running, serving ads in your app and making money you will want to familiarize yourself with your Manage dashboard.
You can quickly view the performance of your apps, and break the performance down to see the performance of individual Zones.
The Manage Ops team will be happy to work with you for best practices and optimization. Feel free to email us at [support@appponsor.com](support@appsponsor.com)


