//
//  ViewController.h
//  SampleApp
//
//  Copyright (c) 2014 Appsponsor.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ManageSDK/MNGInterstitialAd.h>

@interface ViewController : UIViewController<MNGInterstitialAdDelegate>

@property (weak, nonatomic) IBOutlet UITextView *callbackLogs;

@end
