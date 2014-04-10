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
    
    _displayController = [[ASPopupAd alloc] initWithZoneId:@"gnt8cORwCUCw_3cZeE12YA"];
    _rewardedController = [[ASPopupAd alloc] initRewardedAdWithZoneId:@"w7J-JKpbf5QhC3Gyu6lvNg" andUserID:[self getUID] andOptions:nil];
    
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
    // Get your unique player id here for the serverside rewarded callback
    return @"ABCD";
}

- (IBAction)onLoadClick:(id)sender {
    [_displayController load];
}

- (IBAction)onClick:(id)sender {
    [_displayController presentAd];
}
- (IBAction)onRewardedLoadClick:(id)sender {
    [_rewardedController load];
}

- (IBAction)onRewardedClick:(id)sender {
    [_rewardedController presentAd];
}


-(void)popoverWillAppear{
    NSLog(@"popoverWillAppear");
}

-(void)popoverWillDisappear:(NSString*) reason{
    NSLog(@"popoverWillDisappear");
}


-(void)didCacheInterstitial{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Available"
                                                    message:@"Ad Loaded"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}


-(void)onRewardedAdFinished{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rewarded!"
                                                    message:@"Rewarded Ad Completed! Award Reward here"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
