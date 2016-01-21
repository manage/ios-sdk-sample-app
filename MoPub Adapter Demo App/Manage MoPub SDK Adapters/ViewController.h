//
//  ViewController.h
//  Manage MoPub SDK Adapters
//
//  Created by Van Pham on 1/19/16.
//  Copyright © 2016 Manage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MPInterstitialAdController.h"

@interface ViewController : UIViewController <MPInterstitialAdControllerDelegate>

@property (nonatomic, retain) MPInterstitialAdController *mopubInterstitial;

@end

