//
//  TapItMediationAdMob.m
//
//  Created by Nick Penteado on 8/24/12.
//  Copyright (c) 2012 Nick Penteado. All rights reserved.
//

#import "TapItMediationAdMob.h"
#import "GADAdSize.h"
#import <SnakkAds/SKAds.h>

#define MEDIATION_STRING @"admob-1.0.1"

@implementation TapItMediationAdMob

@synthesize skAd, skInterstitial;

+ (NSString *)adapterVersion {
    return SKADS_VERSION;
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

- (id)initWithGADMAdNetworkConnector:(id<GADMAdNetworkConnector>)c {
    self = [super init];
    if (self != nil) {
        connector = c;
        redirectCount = 0;
    }
    return self;
}

- (void)getInterstitial {
    skInterstitial = [[SKAdsInterstitialAd alloc] init];
    skInterstitial.delegate = self;
    skInterstitial.showLoadingOverlay = NO;
    NSString *zoneId = [connector publisherId];
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:zoneId];
    [request setCustomParameter:MEDIATION_STRING forKey:@"mediation"];
    [skInterstitial loadInterstitialForRequest:request];
}

- (void)getBannerWithSize:(GADAdSize)adSize {
    if (!GADAdSizeEqualToSize(adSize, kGADAdSizeBanner) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeFullBanner) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeMediumRectangle)) {
        NSString *errorDesc = [NSString stringWithFormat:
                               @"Invalid ad type %@, not going to get ad.",
                               NSStringFromGADAdSize(adSize)];
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   errorDesc, NSLocalizedDescriptionKey, nil];
        NSError *error = [NSError errorWithDomain:@"ad_mediation"
                                             code:1
                                         userInfo:errorInfo];
        [self skBannerAdView:nil didFailToReceiveAdWithError:error];
        return;
    }
    
    CGSize cgAdSize = CGSizeFromGADAdSize(adSize);
    CGRect adFrame = CGRectMake(0, 0, cgAdSize.width, cgAdSize.height);
    skAd = [[SKAdsBannerAdView alloc] initWithFrame:adFrame];
    NSString *zoneId = [connector publisherId];
    skAd.presentingController = [connector viewControllerForPresentingModalView];
//    skAd.shouldReloadAfterTap = NO;
    skAd.showLoadingOverlay = NO;
    SKAdsRequest *adRequest = [SKAdsRequest requestWithAdZone:zoneId];
    [adRequest setCustomParameter:@"999999" forKey:SKADS_PARAM_KEY_BANNER_ROTATE_INTERVAL]; // don't rotate banner
    [adRequest setCustomParameter:MEDIATION_STRING forKey:@"mediation"];
    skAd.delegate = self;
    [skAd startServingAdsForRequest:adRequest];
}

- (void)stopBeingDelegate {
    if(skInterstitial) {
        skInterstitial.delegate = nil;
    }
    
    if(skAd) {
        skAd.delegate = nil;
    }
}

- (BOOL)isBannerAnimationOK:(GADMBannerAnimationType)animType {
    return YES;
}

- (void)presentInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [skInterstitial presentFromViewController:rootViewController];
}

- (void)dealloc {
    [self stopBeingDelegate];
    [skAd release], skAd = nil;
    [skInterstitial release], skInterstitial = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark SKAdsBannerAdViewDelegate methods

- (void)skBannerAdViewWillLoadAd:(SKAdsBannerAdView *)bannerView {
//    TILog(@"skBannerAdViewWillLoadAd:");
    // no google equivilent... NOOP
}

- (void)skBannerAdViewDidLoadAd:(SKAdsBannerAdView *)bannerView {
//    TILog(@"skBannerAdViewDidLoadAd:");
    [connector adapter:self didReceiveAdView:bannerView];
}

- (void)skBannerAdView:(SKAdsBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
//    TILog(@"skBannerAdView:didFailToReceiveAdWithError:");
    [connector adapter:self didFailAd:error];
}

- (BOOL)skBannerAdViewActionShouldBegin:(SKAdsBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave {
//    TILog(@"skBannerAdViewActionShouldBegin:willLeaveApplication:");
    if (redirectCount++ == 0) {
        // skBannerAdViewActionShouldBegin:willLeaveApplication: may be called multiple times... only report one click/load...
        [connector adapter:self clickDidOccurInBanner:bannerView];
        [connector adapterWillPresentFullScreenModal:self];
    }
    if (willLeave) {
        [connector adapterWillLeaveApplication:self];
    }
    return YES;
}

- (void)skBannerAdViewActionWillFinish:(SKAdsBannerAdView *)bannerView {
//    TILog(@"skBannerAdViewActionWillFinish:");
    [connector adapterWillDismissFullScreenModal:self];
}

- (void)skBannerAdViewActionDidFinish:(SKAdsBannerAdView *)bannerView {
//    TILog(@"skBannerAdViewActionDidFinish:");
    [connector adapterDidDismissFullScreenModal:self];
}


#pragma mark -
#pragma mark SKAdsInterstitialAdDelegate methods

- (void)skInterstitialAd:(SKAdsInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    TILog(@"skInterstitialAd:didFailWithError:");
    [connector adapter:self didFailInterstitial:error];
}

- (void)skInterstitialAdDidUnload:(SKAdsInterstitialAd *)interstitialAd {
    // no google equivilent... NOOP
    // see skInterstitialAdActionWillFinish: and skInterstitialAdActionDidFinish:
//    TILog(@"skInterstitialAdDidUnload:");
}

- (void)skInterstitialAdWillLoad:(SKAdsInterstitialAd *)interstitialAd {
    // no google equivilent... NOOP
    // see skInterstitialAdDidLoad
//    TILog(@"skInterstitialAdWillLoad:");
}

- (void)skInterstitialAdDidLoad:(SKAdsInterstitialAd *)interstitialAd {
//    TILog(@"skInterstitialAdDidLoad:");
    [connector adapter:self didReceiveInterstitial:interstitialAd];
}

- (BOOL)skInterstitialAdActionShouldBegin:(SKAdsInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave {
//    TILog(@"skInterstitialAdActionShouldBegin:willLeaveApplication:");
    if (redirectCount++ == 0) {
        [connector adapterWillPresentInterstitial:self];
    }
    if (willLeave) {
        [connector adapterWillLeaveApplication:self];
    }
    return YES;
}

- (void)skInterstitialAdActionWillFinish:(SKAdsInterstitialAd *)interstitialAd {
//    TILog(@"skInterstitialAdActionWillFinish:");
    [connector adapterWillDismissInterstitial:self];
}

- (void)skInterstitialAdActionDidFinish:(SKAdsInterstitialAd *)interstitialAd {
//    TILog(@"skInterstitialAdActionDidFinish:");
    [connector adapterDidDismissInterstitial:self];
}

@end
