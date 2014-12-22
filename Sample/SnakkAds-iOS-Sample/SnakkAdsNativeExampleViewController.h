//
//  SnakkAdsNativeExampleViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/22/14.
//  Copyright (c) 2014 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SnakkAds/SKAds.h>

@interface SnakkAdsNativeExampleViewController : UIViewController <SKAdsNativeAdDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    NSArray *offices;
    NSIndexPath *currentIndexPath;
    IBOutlet UITableView *customTable;
    BOOL didGetAd;
}

@property (nonatomic, retain) SKAdsNativeAdManager *skNativeManager;

@end
