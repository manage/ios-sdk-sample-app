//
//  ViewController.m
//  Demo App
//
//  Created by Van Pham on 7/8/15.
//  Copyright (c) 2015 Manage. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


#define AD_ZONE          @"LbEdhneQh20N8eb9Ld8qtA"
#define AD_ZONE_REWARDED @"8Oeos2m9Z8HNQ0pMQkCqig"

@interface ViewController () <CLLocationManagerDelegate>

@property(nonatomic, strong) MNGInterstitialAd * adController;
@property(nonatomic, strong) MNGInterstitialAd * rewaredAdController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Initialize Ad Zone
    self.adController = [[MNGInterstitialAd alloc] initWithZoneId: AD_ZONE];

    //[self.adController performSelector:@selector(setAdId:) withObject:@"zQNhb7tg9okWacptz5piaw"];
    //[self.adController performSelector:@selector(setAdId:) withObject:@"XmljQAOZzpQx8aMMJpA5Yg"];
    [self.adController performSelector:@selector(setAdId:) withObject:@"bwSZBJ2eQIFAnIC4LfjihQ "];

    // Load and Present Ad
    [self.adController loadAndPresentAd];
    
    UIButton *but= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [but setFrame:CGRectMake(0, 0, 200, 40)];
    [but setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    

    [but setTitle:@"Load Ad" forState:UIControlStateNormal];
    [but setExclusiveTouch:YES];
    
    [self.view addSubview:but];
}

-(void) buttonClicked:(UIButton*)sender
{
    [self.adController loadAndPresentAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)popoverWillAppear{
    NSLog(@"popoverWillAppear");
}

-(void)popoverWillDisappear:(NSString*) reason{
    
    NSLog(@"popoverWillDisappear");
}

-(void)didCacheInterstitial{
    NSLog(@"didCacheInterstitial");
}

-(void)popoverDidFailToLoadWithError:(NSError*)error{
    NSLog(@"popoverDidFailToLoadWithError");
}

@end
