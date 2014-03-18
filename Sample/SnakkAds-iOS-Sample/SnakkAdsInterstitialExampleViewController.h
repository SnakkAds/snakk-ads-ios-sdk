//
//  SnakkAdsSecondViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SnakkAds/SKAdsInterstitialAd.h>

enum {
    StateNone       = 0,
    StateLoading    = 1,
    StateError      = 2,
    StateReady      = 3,
};
typedef NSUInteger ButtonState;

@interface SnakkAdsInterstitialExampleViewController : UIViewController<SKAdsInterstitialAdDelegate>
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UIButton *loadButton;
@property (retain, nonatomic) IBOutlet UIButton *showButton;
@property (retain, nonatomic) SKAdsInterstitialAd *interstitialAd;

- (void)updateUIWithState:(ButtonState)state;
- (IBAction)loadInterstitial:(id)sender;
- (IBAction)showInterstitial:(id)sender;

@end
