//
//  SnakkAdsFirstViewController.m
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "SnakkAdsAppDelegate.h"
#import "SnakkAdsBannerExampleViewController.h"
#import <SnakkAds/SKAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID @"7268" // for example use only, don't use this zone in your app!

@interface SnakkAdsBannerExampleViewController ()

@end

@implementation SnakkAdsBannerExampleViewController
@synthesize skAd;

- (void)initBannerAdvanced {
    // init banner and add to your view
    if (!skAd) {
        // don't re-define if we used IB to init the banner...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            skAd = [[SKAdsBannerAdView alloc] initWithFrame:CGRectMake(20, 89, 728, 90)];
        } else {
            skAd = [[SKAdsBannerAdView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        }
        
        [self.view addSubview:self.skAd];
    }

    self.skAd.delegate = self;
    self.skAd.showLoadingOverlay = YES;
    
    // set the parent controller for modal browser that loads when user taps ad
    //self.skAd.presentingController = self; // only needed if tapping banner doesn't load modal browser properly
    
    // customize the request...
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"test", @"mode", // enable test mode to test banner ads in your app
                            nil];
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    
    // this is how you enable location updates... NOTE: only enable if your app has a good reason to know the users location (Apple will reject your app if not)
    SnakkAdsAppDelegate *myAppDelegate = (SnakkAdsAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    
    // kick off banner rotation!
    [self.skAd startServingAdsForRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initBannerAdvanced];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.skAd resume];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.skAd pause];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // notify banner of orientation changes
    [self.skAd repositionToInterfaceOrientation:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SKAdsBannerAdViewDelegate methods

- (void)skBannerAdViewWillLoadAd:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner is about to check server for ad...");
}

- (void)skBannerAdViewDidLoadAd:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner has been loaded...");
    // Banner view will display automatically if docking is enabled
    // if disabled, you'll want to show bannerView
}

- (void)skBannerAdView:(SKAdsBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Banner failed to load with the following error: %@", error);
    // Banner view will hide automatically if docking is enabled
    // if disabled, you'll want to hide bannerView
}

- (BOOL)skBannerAdViewActionShouldBegin:(SKAdsBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Banner was tapped, your UI will be covered up. %@", (willLeave ? @" !!LEAVING APP!!" : @""));
    // minimise app footprint for a better ad experience.
    // e.g. pause game, duck music, pause network access, reduce memory footprint, etc...
    return YES;
}

- (void)skBannerAdViewActionWillFinish:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner is about to be dismissed, get ready!");
    
}

- (void)skBannerAdViewActionDidFinish:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner is done covering your app, back to normal!");
    // resume normal app functions
}
@end