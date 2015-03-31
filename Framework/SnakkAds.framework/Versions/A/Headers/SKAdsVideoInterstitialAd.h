//
//  SKAdsVideoInterstitialAd.h
//  SKAds iOS SDK
//
//  Copyright (c) 2015 TapIt! by Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "TVASTAdsRequest.h"
#import "TVASTVideoAdsManager.h"
#import "TVASTAdsLoader.h"
#import "TVASTClickTrackingUIView.h"
#import "TVASTClickThroughBrowser.h"
#import "SKAdsConstants.h"

@class SKAdsVideoInterstitialAd, FullScreenVC;

/**
 A `SKAdsVideoInterstitialAdDelegate` is needed to receive notifications about video ad status.
 */
@protocol SKAdsVideoInterstitialAdDelegate <NSObject>

@required

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Called when the adsLoader receives a video and is ready to play (required).
 @param videoAd The video ad that was loaded.
 */
- (void)skVideoInterstitialAdDidLoad:(SKAdsVideoInterstitialAd *)videoAd;

/**
 Gets called when the video ad has finished playing and the screen returns to your app.
 @param videoAd The video ad that finished playing.
 */
- (void)skVideoInterstitialAdDidFinish:(SKAdsVideoInterstitialAd *)videoAd;

/**
 Gets called if there are no ads to display.
 @param videoAd The video ad that failed to load.
 @param error The error string detailing why the video ad failed to play.
 */
- (void)skVideoInterstitialAdDidFail:(SKAdsVideoInterstitialAd *)videoAd withErrorString:(NSString *)error;
@end

/**
 `SKAdsVideoInterstitialAd` implements a standard `SKAdsVideoInterstitialAd` into your app.
 */
@interface SKAdsVideoInterstitialAd : NSObject <TVASTAdsLoaderDelegate,
TVASTClickTrackingUIViewDelegate, TVASTVideoAdsManagerDelegate,
TVASTClickThroughBrowserDelegate>

/**
 `SKAdsVideoInterstitialAd` implements a standard `SKAdsVideoInterstitialAd` into your app.
 */

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Once an ad has successfully been returned from the server, the `TVASTVideoAdsManager` is created. You need to stop observing and unload the `TVASTVideoAdsManager` upon deallocating this object.
 */
- (void)unloadAdsManager;

/**
 Once `TVASTVideoAdsManager` has an ad ready to play, this is the function you need to call when you are ready to play the ad.
 */
- (void)playVideoFromAdsManager;

/**
 Instantiantes the `TVASTAdsRequest`.
 @param request The ad request with zone information and any custom parameters.
 */
-(void)requestAdsWithRequestObject:(TVASTAdsRequest *)request;

///-----------------------
/// @name Optional
///-----------------------

/**
 Instantiantes the `TVASTAdsRequest` with a specified `SKAdsVideoType`.
 @param request The ad request with zone information and any custom parameters.
 @param videoType The type of video being requested (all, pre-roll, mid-roll, post-roll).
 */
-(void)requestAdsWithRequestObject:(TVASTAdsRequest *)request andVideoType:(SKAdsVideoType)videoType;

/**
 An `id` used to identify the 'SKAdsVideoInterstitialAdDelegate' delegate.
 */
@property (assign, nonatomic) id<SKAdsVideoInterstitialAdDelegate> delegate;

/**
 A `TVASTVideoAdsManager` is the manager of video ads.
 */
@property(nonatomic, retain) TVASTVideoAdsManager *videoAdsManager;

/**
 A `TVASTClickTrackingUIView` handles touch events on the video ad.
 */
@property(nonatomic, retain) TVASTClickTrackingUIView *clickTrackingView;

/**
 The `AVPlayer` will display the video ad.
 */
@property (nonatomic, retain) AVPlayer *adPlayer;

/**
 The `FullScreenVC` will contain the `AVPlayer`.
 */
@property (nonatomic, retain) FullScreenVC *landscapeVC;

/**
 A `UIViewController` is responsible for presenting the video ad (optional).
 */
@property (nonatomic, retain) UIViewController *presentingViewController;

@end
