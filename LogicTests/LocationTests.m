//
//  LocationTests.m
//  LocationTests
//
//  Created by Ron Lisle on 2/28/12.
//  Copyright (c) 2012 lynda.com. All rights reserved.
//

#import "LocationTests.h"

@implementation LocationTests

@synthesize location=location_;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.location = [[Location alloc]init];
}

- (void)tearDown
{
    // Tear-down code here.
    self.location = nil;
    
    [super tearDown];
}

- (void)testInit
{
    STAssertNotNil(self.location, @"Test object not created");
}

- (void)testThatInitSetsLocationManager
{

    STAssertNotNil([self.location locationManager], @"Location manager property is nil");
    STAssertTrue([[self.location locationManager] isKindOfClass:[CLLocationManager class]], @"locationManager class should be CLLocationManager");
    
}

- (void)testCalculateSpeedInMPH
{
    float metersPerMile = 1609.344;
    float secondsPerHour = 60 * 60;
    float mph = [self.location calculateSpeedInMPH:55.0 * metersPerMile / secondsPerHour];
    STAssertTrue(mph == 55.0, @"Calculated speed should be 55 mph but was reported as %f", mph);
}

@end
