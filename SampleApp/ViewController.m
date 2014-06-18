//
//  ViewController.m
//  SampleApp
//
//  Copyright (c) 2014 Appsponsor.com. All rights reserved.
//

#import "ViewController.h"
#import <AppSponsorSDK/ASPopupAd.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property(nonatomic, strong) ASPopupAd * displayController;
@property(nonatomic, strong) ASPopupAd * rewardedController;


@property (weak, nonatomic) IBOutlet UIButton *showRewardedButton;
@property (weak, nonatomic) IBOutlet UIButton *loadRewardedButton;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Once you sign up at AppSponsor.com, you can create zone and get zone id. Rewarded ad type can be set at zone configuration page.
    _displayController = [[ASPopupAd alloc] initWithZoneId:@"gnt8cORwCUCw_3cZeE12YA"];
    _rewardedController = [[ASPopupAd alloc] initRewardedAdWithZoneId:@"w7J-JKpbf5QhC3Gyu6lvNg" andUserID:[self getUID]];
    
    //link delegates
    _displayController.delegate = self;
    _rewardedController.delegate = self;
   
    // Non-essential formatting
    [self formatButton:_showRewardedButton];
    [self formatButton:_loadRewardedButton];
    [self formatButton:_loadAdButton];
    [self formatButton:_showAdButton];
}

- (void)formatButton:(UIButton *)button
{
    [[button layer] setCornerRadius:5.0f];
    [[button layer] setBorderWidth:0.5f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) getUID {
    //This user id required for rewarded ad. And it is passed to server-to-server call back url, so game back end knows who finishes a rewarded ad.
    return @"ABCD";
}

#pragma mark -- functions for ui elements

- (IBAction)onLoadClick:(id)sender {
    //load(cache) ad content
    [_displayController load];
}

- (IBAction)onClick:(id)sender {
    if ([_displayController isReady] ) {
        //display ad if the ad content is ready
        [_displayController presentAd];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Ad is not ready, Please load it first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)popoverDidFailToLoadWithError:(NSError*)error{
//something went wrong with AppSponsor ad
}


- (IBAction)onRewardedLoadClick:(id)sender {
    //load(cache) ad content
    [_rewardedController load];
}

- (IBAction)onRewardedClick:(id)sender {
    if ([_rewardedController isReady]) {
        //display ad if the ad content is ready
        [_rewardedController presentAd];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Ad is not ready, please load it first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark -- SDK delegates

-(void)popoverWillAppear{
    NSLog(@"popoverWillAppear");
    //This function calls before ad shows up, you can pause your game/app here
}

-(void)popoverWillDisappear:(NSString*) reason{
    NSLog(@"popoverWillDisappear");
    //This function calls before ad disappears, you can resume your game/app here
}


-(void)didCacheInterstitial{
    //call back function indicates ad content has been cached
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Available"
                                                    message:@"Ad Loaded"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}


-(void)onRewardedAdFinished{
    //call back function triggers by SDK once rewarded ad finishes play.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rewarded!"
                                                    message:@"Rewarded Ad Completed! Award Reward here"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (void)viewDidUnload {
    [self setShowAdButton:nil];
    [super viewDidUnload];
}
@end
