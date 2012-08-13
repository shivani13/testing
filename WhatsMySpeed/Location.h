//
//  Location.h
//  WhatsMySpeed
//
//  Created by Ron Lisle on 10/30/11.
//  Copyright (c) 2011 lynda.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject <CLLocationManagerDelegate>
{
    BOOL geocodePending_;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property float speed;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) CLGeocoder *geocoder;

- (void)startLocationUpdates;
- (float)calculateSpeedInMPH:(float)speedInMetersPerSecond;
- (void)updatePostalCode:(CLLocation *)newLocation withHandler:(CLGeocodeCompletionHandler)completionHandler;

@end
