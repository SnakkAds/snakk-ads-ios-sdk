//
//  TapItMediationAdMob.h
//  NickTest
//
//  Created by Nick Penteado on 8/24/12.
//  Copyright (c) 2012 Nick Penteado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADMAdNetworkAdapterProtocol.h"
#import "GADMAdNetworkConnectorProtocol.h"
#import <SnakkAds/SKAds.h>

@interface TapItMediationAdMob : NSObject <SKAdsBannerAdViewDelegate, SKAdsInterstitialAdDelegate, GADMAdNetworkAdapter> {
    id<GADMAdNetworkConnector> connector;
    SKAdsBannerAdView *skAd;
    SKAdsInterstitialAd *skInterstitial;
    // used to suppress duplicate calls to adapterWillPresentInterstitial:, adapter:clickDidOccurInBanner, and adapterWillPresentFullScreenModal:
    // (sk sdk calls sk[Interstitial|Banner]AdActionShouldBegin:willLeaveApplication: each time a http redirect occurs...)
    int redirectCount;
}

@property (nonatomic, retain) UIView *skAd;
@property (nonatomic, retain) NSObject *skInterstitial;

@end
