//
//  ApplicationTests.m
//  ApplicationTests
//
//  Created by Ron Lisle on 2/28/12.
//  Copyright (c) 2012 lynda.com. All rights reserved.
//

#import "ApplicationTests.h"

@implementation ApplicationTests

@synthesize vc=vc_;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate = [application delegate];
    UIWindow *window = [appDelegate window];
    self.vc = (ViewController *)[window rootViewController];
}

- (void)tearDown
{
    // Tear-down code here.
    self.vc = nil;
    
    [super tearDown];
}

- (void)testThatViewControllerIsntNil
{
    STAssertNotNil(self.vc, @"ViewController wasn't set");
}

- (void)testThatMapViewIsntNil
{
    STAssertNotNil([self.vc mapView], @"MapView wasn't set");
}

- (void)testThatShowsUserLocation
{
    STAssertTrue([[self.vc mapView]showsUserLocation]==YES, @"ShowsUserLocation not set");
    
}

- (void)testThatUserTrackingFollow
{
    STAssertTrue([[self.vc mapView]userTrackingMode]==MKUserTrackingModeFollow, @"UserTrackingMode is not follow");
    
}

@end
