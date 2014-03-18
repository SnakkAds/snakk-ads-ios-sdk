//
//  SnakkAdsFirstViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SnakkAds/SKAdsBannerAdView.h>

@interface SnakkAdsBannerExampleViewController : UIViewController<SKAdsBannerAdViewDelegate>

@property (retain, nonatomic) SKAdsBannerAdView *skAd;

@end
