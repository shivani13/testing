//
//  Location.m
//  WhatsMySpeed
//
//  This model essentially wraps the CLLocationManager class
//  in order to simplify testing, and enhance separation of
//  concerns. During testing this object can be mocked if needed.
//
//  Created by Ron Lisle on 10/30/11.
//  Copyright (c) 2011 lynda.com, Inc. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize locationManager=locationManager_;
@synthesize speed=speed_;
@synthesize postalCode=postalCode_;
@synthesize geocoder=geocoder_;

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    postalCode_ = @"Unknown";
    geocodePending_ = NO;
    geocoder_ = [[CLGeocoder alloc]init];
    
    locationManager_ = [[CLLocationManager alloc]init];
    [locationManager_ setDelegate:self];
    [locationManager_ setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [locationManager_ setDistanceFilter:kCLDistanceFilterNone];
    
    return self;
    
}

- (void)startLocationUpdates {
    [[self locationManager] startUpdatingLocation];
}

#pragma mark - Helper methods

- (void)updatePostalCode:(CLLocation *)newLocation withHandler:(CLGeocodeCompletionHandler)completionHandler {
    
    if (geocodePending_ == YES) {
        return;
    }
    geocodePending_ = YES;
    
    [[self geocoder]reverseGeocodeLocation:newLocation 
                         completionHandler:completionHandler];
    
}

- (float)calculateSpeedInMPH:(float)speedInMetersPerSecond {
    
    float speedInMetersPerHour = speedInMetersPerSecond * 60 * 60;
    return speedInMetersPerHour / 1609.344;
    
}

#pragma mark - LocationManager Delegate methods

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    [self updatePostalCode:newLocation
               withHandler:^(NSArray *placemarks, NSError *error){
                   CLPlacemark *placemark = [placemarks objectAtIndex:0];
                   [self setPostalCode:[placemark postalCode]];
                   geocodePending_ = NO;
               }];
    
    float speed = [self calculateSpeedInMPH:[newLocation speed]];
    speed_ = speed;

}

@end
