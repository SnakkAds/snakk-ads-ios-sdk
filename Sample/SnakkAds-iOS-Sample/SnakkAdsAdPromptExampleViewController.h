//
//  SnakkAdsAdPromptExampleViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SnakkAds/SKAdsAdPrompt.h>

@interface SnakkAdsAdPromptExampleViewController : UIViewController<SKAdsAdPromptDelegate> {
    SKAdsAdPrompt *skAdPrompt;
}

@property (retain, nonatomic) IBOutlet UIButton *preloadButton;

-(IBAction)preLoadAdPrompt:(id)sender;
-(IBAction)showAdPrompt:(id)sender;
-(IBAction)simpleExample:(id)sender;

@end
