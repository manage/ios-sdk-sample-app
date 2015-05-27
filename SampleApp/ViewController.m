//
//  ViewController.m
//  SampleApp
//
//  Copyright (c) 2014 Appsponsor.com. All rights reserved.
//
//
//  ViewController.m
//  SDKBasicTest
//
//  Created by Frank Wang on 10/11/13.
//  Copyright (c) 2013 manage. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

/*
 614 gnt8cORwCUCw_3cZeE12YA  | 1 | display + vast + voxel
 615 8Oeos2m9Z8HNQ0pMQkCqig  | 2 | display only
 616 oNAnx6m1fGcQHZ6aLw4_9w  | 3 | performance video
 617 DNROlQlIcD4T8VR_lrNzKg  | 4 | experience
 618 w7J-JKpbf5QhC3Gyu6lvNg  | 5 | rewarded ad combined
 */

#define AD_ZONE_1 @"gnt8cORwCUCw_3cZeE12YA" //
#define AD_ZONE_2 @"8Oeos2m9Z8HNQ0pMQkCqig" //
#define AD_ZONE_3 @"oNAnx6m1fGcQHZ6aLw4_9w" //
#define AD_ZONE_4 @"DNROlQlIcD4T8VR_lrNzKg" //
#define AD_ZONE_5 @"w7J-JKpbf5QhC3Gyu6lvNg" //


@interface ViewController () <CLLocationManagerDelegate>
@property(nonatomic, strong) MNGInterstitialAd * controller_1;
@property(nonatomic, strong) MNGInterstitialAd * controller_2;
@property(nonatomic, strong) MNGInterstitialAd * controller_3;
@property(nonatomic, strong) MNGInterstitialAd * controller_4;
@property(nonatomic, strong) MNGInterstitialAd * controller_5;
@property(nonatomic) int adCount;

@property(nonatomic) int adType;
@property (weak, nonatomic) IBOutlet UILabel *labSDKVersion;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationManager* locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
   // NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    //    [options setObject:@"NO" forKey:@"precache_at_init"];
    //[options setObject:@"USA" forKey:@"country"];
    
    self.controller_1 = [[[MNGInterstitialAd alloc] enableLocationSupport] initWithZoneId:AD_ZONE_1];
    self.controller_1.parentController = self;
    
    
    NSMutableDictionary *options2 = [NSMutableDictionary dictionary];
    
    [options2 setObject:@"NO" forKey:@"precache_at_init"];
    [options2 setObject:@"USA" forKey:@"country"];
    
    self.controller_2 = [[MNGInterstitialAd alloc] initWithZoneId:AD_ZONE_2];
    
    self.controller_3 = [[MNGInterstitialAd alloc] initRewardedAdWithZoneId:AD_ZONE_3 andUserID:@"PUBLISHER_ID_123"];
    self.controller_4 = [[MNGInterstitialAd alloc] initRewardedAdWithZoneId:AD_ZONE_4 andUserID:@"PUBLISHER_ID_123"];
    self.controller_5 = [[MNGInterstitialAd alloc] initRewardedAdWithZoneId:AD_ZONE_5 andUserID:@"PUBLISHER_ID_123"];
    
    self.controller_1.delegate = self; //important
    self.controller_2.delegate = self; //important
    
    self.controller_3.delegate = self; //important
    self.controller_4.delegate = self; //important
    self.controller_5.delegate = self; //important
    
    self.adCount = 0;
    
    self.labSDKVersion.text = MNG_SDK_VERSION;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAd:(id)sender {
    self.adType = 1;
    [self.controller_1 load];
}

- (IBAction)presentAd:(id)sender {
    if ([self.controller_1 isReady]) {
        self.adType = 1;
        [self.controller_1 presentAd];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"ad 1 is not ready yet, please try load it again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)loadAndPresentAd:(id)sender {
    self.adType = 1;
    [self.controller_1 loadAndPresentAdWithTimeout:1.1f];
}

- (IBAction)loadAd2:(id)sender {
    self.adType = 2;
    [self.controller_2 load];
}

- (IBAction)presentAd2:(id)sender {
    if ([self.controller_2 isReady]) {
        self.adType = 2;
        [self.controller_2 presentAd];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"ad 2 is not ready yet, please try load it again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)loadAndPresentAd2:(id)sender {
    self.adType = 2;
    [self.controller_2 loadAndPresentAd];
}

- (IBAction)loadAd3:(id)sender {
    self.adType = 3;
    [self.controller_3 load];
}

- (IBAction)presentAd3:(id)sender {
    if ([self.controller_3 isReady]) {
        self.adType = 3;
        [self.controller_3 presentAd];
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [self loadAd3:nil];
        });
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"ad 3 is not ready yet, please try load it again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)loadAndPresentAd3:(id)sender {
    self.adType = 3;
    [self.controller_3 loadAndPresentAd];
}

- (IBAction)loadAd4:(id)sender {
    self.adType = 4;
    [self.controller_4 load];
    
}

- (IBAction)presentAd4:(id)sender {
    
    if ([self.controller_4 isReady]) {
        self.adType = 4;
        [self.controller_4 presentAd];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"ad 4 is not ready yet, please try load it again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)loadAndPresentAd4:(id)sender {
    self.adType = 4;
    [self.controller_4 loadAndPresentAd];
}

- (IBAction)loadAd5:(id)sender {
    self.adType = 5;
    [self.controller_5 load];
}

- (IBAction)presentAd5:(id)sender {
    if ([self.controller_5 isReady]) {
        self.adType = 5;
        [self.controller_5 presentAd];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"ad 5 is not ready yet, please try load it again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)loadAndPresentAd5:(id)sender {
    self.adType = 5;
    [self.controller_5 loadAndPresentAd];
}

-(void)popoverWillAppear{
    NSLog(@"popoverWillAppear");
    self.adCount = self.adCount + 1;
    [self appendTologWithMessage:[NSString stringWithFormat:@"\n--------- ad %d ------------", self.adCount]];
    [self appendTologWithMessage:@"popoverWillAppear"];
}

-(void)popoverWillDisappear:(NSString*) reason{
    
    NSLog(@"popoverWillDisappear");
    [self appendTologWithMessage:[NSString stringWithFormat:@"popoverWillDisappear with reason: %@", reason]];
}

-(void)didCacheInterstitial{
    NSLog(@"didCacheInterstitial is triggered?");
    [self appendTologWithMessage:@"\ndidCacheInterstitial"];
    
    //    switch (self.adType) {
    //        case 1:
    //            [self.controller_1 presentAd];
    //            break;
    //        case 2:
    //            [self.controller_2 presentAd];
    //            break;
    //        case 3:
    //            [self.controller_3 presentAd];
    //            break;
    //        case 4:
    //            [self.controller_4 presentAd];
    //            break;
    //        case 5:
    //            [self.controller_5 presentAd];
    //            break;
    //        default:
    //            break;
    //    }
}

-(void)popoverDidFailToLoadWithError:(NSError*)error{
    NSLog(@"popoverDidFailToLoadWithError");
    [self appendTologWithMessage:[NSString stringWithFormat:@"popoverDidFailToLoadWithError %@", error]];
}

-(void)onRewardedAdFinished{
    [self appendTologWithMessage:@"onRewardedAdFinished"];
    
    int finished = 0;
    switch (self.adType) {
        case 1:
            finished = self.controller_1.rewardedAdStatus;
            break;
        case 2:
            finished = self.controller_2.rewardedAdStatus;
            break;
        case 3:
            finished = self.controller_3.rewardedAdStatus;
            break;
        case 4:
            finished = self.controller_4.rewardedAdStatus;
            break;
        case 5:
            finished = self.controller_5.rewardedAdStatus;
            break;
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulation"
                                                    message:[NSString stringWithFormat:@"You have earned 10 coins finished %d!", finished]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void) appendTologWithMessage:(NSString*) msg{
    self.callbackLogs.text = [NSString stringWithFormat:@"%@\n%@", self.callbackLogs.text, msg];
    NSRange bottom = NSMakeRange(self.callbackLogs.text.length -1, 1);
    [self.callbackLogs scrollRangeToVisible:bottom];
    
}

@end
