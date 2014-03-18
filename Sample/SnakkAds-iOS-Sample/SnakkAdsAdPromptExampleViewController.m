//
//  SnakkAdsAdPromptExampleViewController.m
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "SnakkAdsAppDelegate.h"
#import "SnakkAdsAdPromptExampleViewController.h"
#import <SnakkAds/SKAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID @"7980" // for example use only, don't use this zone in your app!

@interface SnakkAdsAdPromptExampleViewController ()

@end

@implementation SnakkAdsAdPromptExampleViewController
@synthesize preloadButton;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SKAdsAdPrompt Example code
- (void)simpleExample:(id)sender {
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:ZONE_ID];
    SKAdsAdPrompt *prompt = [[SKAdsAdPrompt alloc] initWithRequest:request];
    [prompt showAsAlert];
}


- (void)loadAdPrompt {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"test", @"mode", // enable test mode to test AdPrompts in your app
                            nil];
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    SnakkAdsAppDelegate *myAppDelegate = (SnakkAdsAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    skAdPrompt = [[SKAdsAdPrompt alloc] initWithRequest:request];
    skAdPrompt.delegate = self;
    skAdPrompt.showLoadingOverlay = NO;
}

- (IBAction)preLoadAdPrompt:(id)sender {
    [self loadAdPrompt];
    [skAdPrompt load];
}

- (IBAction)showAdPrompt:(id)sender {
    if (!skAdPrompt) {
        [self loadAdPrompt];
    }
    
    [skAdPrompt showAsAlert];
}

- (void)skAdPrompt:(SKAdsAdPrompt *)adPrompt didFailWithError:(NSError *)error {
    NSLog(@"Error showing AdPrompt: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error showing AdPrompt" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    [self cleanupAdPrompt];
}

- (void)skAdPromptWasDeclined:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt was DECLINED!");
    [self cleanupAdPrompt];
}

- (void)skAdPromptDidLoad:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt loaded!");
    self.preloadButton.enabled = NO;
}

- (void)skAdPromptWasDisplayed:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt displayed!");
}

- (BOOL)skAdPromptActionShouldBegin:(SKAdsAdPrompt *)adPrompt willLeaveApplication:(BOOL)willLeave {
    NSString *strWillLeave = willLeave ? @"Leaving app" : @"loading internally";
    NSLog(@"AdPrompt was accepted, loading app/advertisement... %@", strWillLeave);
    return YES;
}

- (void)skAdPromptActionDidFinish:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt Action finished!");
    [self cleanupAdPrompt];
}


- (void)cleanupAdPrompt {
    skAdPrompt = nil;
    self.preloadButton.enabled = YES;
}

@end
