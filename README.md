Snakk Ads iOS SDK
================

Version 3.1.4

This is Snakk's iOS SDK for Advertising. Visit http://www.snakkads.com/ for more details and to sign up.



Getting Started
---------------

- [Download Snakk Ads](https://github.com/SnakkAds/snakk-ads-ios-sdk/archive/master.zip) and run the included sample app.
- Continue reading below for installation and integration instructions.


Installation
------------

The following frameworks are required:

```objective-c
SystemConfiguration.framework
QuartsCore.framework
CoreTelephony.framework
MessageUI.framework
EventKit.framework
EventKitUI.framework
CoreMedia.framework
AVFoundation.framework
MediaPlayer.framework
AudioToolbox.framework
AdSupport.framework - enable support for IDFA
StoreKit.framework - enable use of SKStoreProductViewController, displays app store ads without leaving your app
```

**In the Build Settings for your target, you must include the following "Other Linker Flags:" -ObjC**

The following frameworks are optional:

```objective-c
CoreLocation.framework
```
CoreLocation is optional and is used for geo-targeting ads.  Apple mandates that your app have a good reason for enabling Location services and will deny your app if location is not a core feature for your app.

The following bundles are required:

```objective-c
SKAds.bundle
```

SKAds.bundle includes files needed for media-rich advertisements that make use of device specific features. It is included with this sample app.



Integration
----------

The Snakk Ads SDK allows developers to serve many types of ads, including banner, interstitial and video ads.


### Banner Usage

```objective-c
// In your .h file:
#import <SnakkAds/SKAdsBannerAdView.h>
@property (retain, nonatomic) SKAdsBannerAdView *skAd;

...

// In your .m file:
#import <SnakkAds/SKAds.h>
...
// Init banner and add to your view:
skAd = [[SKAdsBannerAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
[self.view addSubview:self.skAd];

// To kick off banner rotation:
[self.skAd startServingAdsForRequest:[SKAdsRequest requestWithAdZone:@"**YOUR ZONE ID**"]];

...

// To hide and cancel ads: 
[self.skAd hide];
[self.skAd cancelAds];
```



### Interstitial Usage

#### Show Modally

```objective-c
// In your .h file:
#import <SnakkAds/SKAdsInterstitialAd.h>
...
@property (retain, nonatomic) SKAdsInterstitialAd *interstitialAd;

...

// In your .m file: 
#import <SnakkAds/SKAds.h>
...
// Init and load interstitial:
self.interstitialAd = [[SKAdsInterstitialAd alloc] init];
self.interstitialAd.delegate = self; // notify me of the interstitial's state changes
SKAdsRequest *request = [SKAdsRequest requestWithAdZone:@"**YOUR ZONE ID**"];
[self.interstitialAd loadInterstitialForRequest:request];

...

- (void)skInterstitialAdDidLoad:(SKAdsInterstitialAd *)interstitialAd {
    // Ad is ready for display... show it!
    [self.interstitialAd presentFromViewController:self];
}
```


#### Include in Paged Navigation
    
```objective-c
@property (retain, nonatomic) SKInterstitialAd *interstitialAd;

...

// Init and load interstitial:
self.interstitialAd = [[SKAdsInterstitialAd alloc] init];
SKAdsRequest *request = [SKAdsRequest requestWithAdZone:@"**YOUR ZONE ID**"];
[self.interstitialAd loadInterstitialForRequest:request];

...

// If interstitial is ready, show:
if( self.interstitialAd.isLoaded ) {
    [self.interstitialAd presentInView:self.view];
}
```

### Video Ads Usage

When requesting a video ad from the server, a TVASTAdsRequest object must be instantiated and its zoneId parameter specified. This parameter is required for a successful retrieval of the ad.

```objective-c
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:**YOUR ZONE ID**;
    [_videoAd requestAdsWithRequestObject:request];
```

If you want to specify the type of video ad you are requesting, use the call below.

```objective-c 
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:**YOUR ZONE ID**];
    [_videoAd requestAdsWithRequestObject:request andVideoType:SKAdsVideoTypeMidroll];
```

(Essentially, what needs to be included in the code is as follows:)

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _videoAd = [[SKAdsVideoInterstitialAd alloc] init];
    _videoAd.delegate = self;
    
    //Optional: Override the presentingViewController (defaults to the delegate)
    //_videoAd.presentingViewController = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:**YOUR ZONE ID**];
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
```
### Native Ad Usage

~~~~
// in your .h file
#import <SnakkAds/SKAdsNativeAdManager.h>

@interface MyViewController : UIViewController <SKAdsNativeAdDelegate>

@property (nonatomic, retain) SKAdsNativeAdManager *skNativeManager;
...

// in your .m file
#import <SnakkAds/SKAds.h>
...
skNativeManager = [[SKAdsNativeAdManager alloc] init];
skNativeManager.delegate = self;
SKAdsRequest *request = [SKAdsRequest requestWithAdZone:*YOUR ZONE ID* andCustomParameters:params];
[skNativeManager getAdsForRequest:request withRequestedNumberOfAds:10];
...

- (void)skNativeAdManagerDidLoad:(SKAdsNativeAdManager *)nativeAdManager {
SKAdsNativeAd *newAd = [nativeAdManager.allNativeAds objectAtIndex:0];

// Get data from `newAd` and add fields to your view
...
UILabel *titleLabel = [[UILabel alloc] init];
[titleLabel setFrame:CGRectMake(10,50,300,20)];
titleLabel.backgroundColor=[UIColor clearColor];
titleLabel.textColor=[UIColor blackColor];
titleLabel.userInteractionEnabled=YES;
titleLabel.text = newAd.adTitle;
[self.view addSubview:titleLabel];
[titleLabel release];
...

// Add a touch recognizer to native element(s) to enable landing page access
UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped)];
tapGestureRecognizer.numberOfTapsRequired = 1;
[titleLabel addGestureRecognizer:tapGestureRecognizer];
// Log the native ad impression

[nativeAdManager logNativeAdImpression:newAd];
}

- (void)labelTapped {
SKAdsNativeAd *newAd = [skNativeManager.allNativeAds objectAtIndex:0];
[skNativeManager nativeAdWasTouched:newAd];
}

- (void)skNativeAdManager:(SKAdsNativeAdManager *)nativeAdManager didFailToReceiveAdWithError:(NSError *)error {
NSLog(@"Native Ad Manager failed to load with the following error: %@", error.localizedDescription);
}
...

~~~~

### Listen for Location Updates

If you want to allow for geo-targeting, listen for location updates:

```objective-c
@property (retain, nonatomic) CLLocationManager *locationManager;

...

// start listening for location updates
self.locationManager = [[CLLocationManager alloc] init];
self.locationManager.delegate = self;

// iOS 8 check
if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
}
[self.locationManager startUpdatingLocation];

...

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // Notify the Snakk banner when the location changes.  New location will be used the next time an ad is requested.
    [self.skAd updateLocation:newLocation];
}

...

// To stop monitoring location when complete to conserve battery life:
[self.locationManager stopMonitoringSignificantLocationChanges];
```

Customization Options
---------------------

If you want to customize the appearance of the in-app browser controller that appears when a user taps on an ad, follow the below instructions:

1. To customize the background color of the browser controller toolbar, in your app's Info.plist file add the key **pwAdsToolbarBgColor** with the value being the color represented in RGBA format (ex. orange = **255 149 0 1**).
2. To customize the tint color of the browser controller toolbar items, in your app's Info.plist file add the key **pwAdsToolbarTintColor** with the value being the color represented in RGBA format (ex. blue = **0 0 255 1**).

If you want to customize the appearance of the close button for Interstitial ads, follow the below instructions:

1. Create close button images at 32x32 @1x and 64x64 @2x.
2. Name the newly created images **pwCustomClose.png** and **pwCustomClose@2x.png**.
3. Add the pwCustomClose.png and pwCustomClose@2x.png images to your Xcode project.