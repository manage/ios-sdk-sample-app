//
//  ASTViewController.m
//  AppSponserTest
//
//  Created by Mike Sergio on 5/31/13.
//  Copyright (c) 2013 AST. All rights reserved.
//

#import "ASTViewController.h"
#import <AppSponserSDK/ASPopupAdController.h>

#define AD_ZONE @"6hPl8LCmW-da3YlWY7uSEQ"


@interface ASTViewController ()
@property(nonatomic, strong) ASPopupAdController * controller;
@end

@implementation ASTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAd:(id)sender {
    _controller = [[ASPopupAdController alloc] initWithZoneId:AD_ZONE];
    [_controller presentAd];
}

- (IBAction)precacheAd:(id)sender {
    _controller = [[ASPopupAdController alloc] initWithZoneId:AD_ZONE];
    _controller.testMode = YES;
    [_controller load];
}

- (IBAction)showPrecachedAd:(id)sender {
    [_controller presentAd];
}
@end
