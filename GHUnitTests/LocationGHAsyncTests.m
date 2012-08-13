//
//  LocationGHAsyncTests.m
//  WhatsMySpeed
//
//  Created by Ron Lisle on 2/29/12.
//  Copyright (c) 2012 lynda.com. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "Location.h"
#import "LocationForTesting.h"

@interface LocationGHAsyncTests : GHAsyncTestCase { }
@end

@implementation LocationGHAsyncTests

- (void)testUpdatePostalCode {
    [self prepare];
    
    // Do asynchronous task here
    Location *location = [[Location alloc]init];
    [location updatePostalCode:nil 
                   withHandler:^(NSArray *placemarks, NSError *error){
                       [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testUpdatePostalCode)];
                   }];
    
    GHAssertTrue([location geocodePending]==YES, @"geocodePending should be true");
    
    // Wait for notify
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0];
    
}
@end