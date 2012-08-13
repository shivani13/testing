//
//  LocationGHTests.m
//  WhatsMySpeed
//
//  Created by Ron Lisle on 2/29/12.
//  Copyright (c) 2012 lynda.com. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h> 
#import "Location.h"

@interface LocationGHTests : GHTestCase { }
@end

@implementation LocationGHTests

- (void)testStrings {       
    NSString *string1 = @"a string";
    GHTestLog(@"I can log to the GHUnit test console: %@", string1);
    
    // Assert string1 is not NULL, with no custom error description
    GHAssertNotNil(string1, nil);
    
    // Assert equal objects, add custom error description
    NSString *string2 = @"a string";
    GHAssertEqualObjects(string1, string2, @"A custom error message. string1 should be equal to: %@.", string2);
}

- (void)testEqualStrings {
    GHAssertEqualStrings(@"ABC", @"ABC", nil);
}
@end
