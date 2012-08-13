//
//  WiFiUtilities.h
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/16/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "MessageUI/MFMailComposeViewController.h"

@interface WiFiUtilities : NSObject<FBSessionDelegate,FBDialogDelegate,FBRequestDelegate,MFMailComposeViewControllerDelegate>{
    Facebook *facebook;
}

+ (WiFiUtilities *)sharedInstance;
- (void) shareOnFacebook:(NSString *)title url:(NSString *)url;
- (BOOL)handleOpenUrl:(NSURL *)url;
@end
