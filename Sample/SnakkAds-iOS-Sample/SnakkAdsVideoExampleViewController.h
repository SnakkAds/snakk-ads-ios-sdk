//
//  VideoInterstitialrViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <SnakkAds/SKAdsVideoInterstitialAd.h>

@interface SnakkAdsVideoExampleViewController : UIViewController<SKAdsVideoInterstitialAdDelegate>

@property (nonatomic, retain) IBOutlet UIButton     *adRequestButton;
@property (nonatomic, retain) SKAdsVideoInterstitialAd *videoAd;

- (IBAction)onRequestAds;
@end
