//
//  ViewController.h
//  SampleApp
//
//  Copyright (c) 2014 Appsponsor.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppSponsorSDK/ASPopupAd.h>

@interface ViewController : UIViewController<ASPopupAdDelegate>

@property (weak, nonatomic) IBOutlet UITextView *callbackLogs;

@end
