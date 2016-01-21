//
//  ViewController.m
//  Manage MoPub SDK Adapters
//
//  Created by Van Pham on 1/19/16.
//  Copyright © 2016 Manage. All rights reserved.
//


// MoPub: 8636b024c62b475ebad604d0ca0ef802

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor darkGrayColor];
    self.mopubInterstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"8636b024c62b475ebad604d0ca0ef802"];
    self.mopubInterstitial.delegate = self;
    
    // Pre-fetch the ad up front
    [self.mopubInterstitial loadAd];
}

#pragma mark - <MPInterstitialAdControllerDelegate>
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    if (self.mopubInterstitial.ready) {
        [self.mopubInterstitial showFromViewController:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
