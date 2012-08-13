//
//  main.m
//  WiFiGHUnitTests
//
//  Created by pavan krishna on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GHUnitIOS/GHUnit.h>

//#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    const char *prefix = "GCOV_PREFIX";
    const char *prefixValue = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] cStringUsingEncoding:NSASCIIStringEncoding]; // This gets the filepath to the app's Documents directory
    const char *prefixStrip = "GCOV_PREFIX_STRIP";
    const char *prefixStripValue = "1";
    setenv(prefix, prefixValue, 1); // This sets an environment variable which tells gcov where to put the .gcda files.
    setenv(prefixStrip, prefixStripValue, 1); 
   
    
    @autoreleasepool {
        
        return UIApplicationMain(argc, argv, nil, @"GHUnitIPhoneAppDelegate");
    }
}
