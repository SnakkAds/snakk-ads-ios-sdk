//
//  VideoInterstitialrViewController.m
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import "SnakkAdsVideoExampleViewController.h"
#import <SnakkAds/TVASTAd.h>
#import <SnakkAds/SKAdsVideoInterstitialAd.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID @"22219" // for example use only, don't use this zone in your app!

@interface SnakkAdsVideoExampleViewController ()

@end

@implementation SnakkAdsVideoExampleViewController

@synthesize videoAd = _videoAd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _videoAd = [[SKAdsVideoInterstitialAd alloc] init];
    _videoAd.delegate = self;
    
    //Optional... override the presentingViewController (defaults to the delegate)
    //_videoAd.presentingViewController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:ZONE_ID];
    [_videoAd requestAdsWithRequestObject:request];
    
    //If you want to specify the type of video ad you are requesting, use the call below.
    //[_videoAd requestAdsWithRequestObject:request andVideoType:SKAdsVideoTypeMidroll];
}

- (IBAction)onRequestAds {
    [self requestAds];
}

- (void)skVideoInterstitialAdDidFinish:(SKAdsVideoInterstitialAd *)videoAd {
    NSLog(@"Override point for resuming your app's content.");
    [_videoAd unloadAdsManager];
}

- (void)viewDidUnload {
    [_videoAd unloadAdsManager];
    [super viewDidUnload];
}

- (void)skVideoInterstitialAdDidLoad:(SKAdsVideoInterstitialAd *)videoAd {
    NSLog(@"We received an ad... now show it.");
    [videoAd playVideoFromAdsManager];
}

- (void)skVideoInterstitialAdDidFail:(SKAdsVideoInterstitialAd *)videoAd withErrorString:(NSString *)error {
    NSLog(@"%@", error);
}
@end
