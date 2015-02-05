//
//  SKAdsNativeAd.h
//  SKAds iOS SDK
//
//  Created by Carl Zornes on 11/20/14.
//
//

#import <Foundation/Foundation.h>

@interface SKAdsNativeAd : NSObject

/**
 An `NSString` that contains the ad title for the `SKAdsNativeAd`.
 */
- (NSString *)adTitle;

/**
 An `NSString` that contains the ad text for the `SKAdsNativeAd`.
 */
- (NSString *)adText;

/**
 An `NSString` that contains the ad HTML for the `SKAdsNativeAd`.
 */
- (NSString *)adHTML;

/**
 An `NSNumber` that contains the ad rating for the `SKAdsNativeAd`.
 */
- (NSNumber *)adRating;

/**
 An `NSString` that contains the ad icon URL for the `SKAdsNativeAd`.
 */
- (NSString *)adIconURL;

/**
 An `NSString` that contains the ad call to action for the `SKAdsNativeAd`.
 */
- (NSString *)adCTA;

/**
 An `NSString` that contains the ad click URL for the `SKAdsNativeAd`.
 */
- (NSString *)adClickURL;

/**
 An `NSString` that contains the ad impression URL for the `SKAdsNativeAd`.
 */
- (NSString *)adImpressionURL;

/**
 An `NSString` that contains the ad type for the `SKAdsNativeAd`.
 */
- (NSString *)adType;

/**
 An `NSString` that contains the ad dimension for the `SKAdsNativeAd`.
 */
- (NSString *)adDimension;

/**
 An `NSDictionary` that contains all of the native ad data for the `SKAdsNativeAd`.
 */
- (NSDictionary *)nativeAdData;

@end
