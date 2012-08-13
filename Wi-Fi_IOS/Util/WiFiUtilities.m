//
//  WiFiUtilities.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/16/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiUtilities.h"
#import "Facebook.h"
#import "Twitter/Twitter.h"
#import "Accounts/Accounts.h"
#import "MessageUI/MessageUI.h"

@implementation WiFiUtilities{
    NSString *shareTitle;
    NSString *shareUrl;
}

static WiFiUtilities *sharedInstance =nil;


+ (WiFiUtilities *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WiFiUtilities alloc] init];
    }
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        facebook = [[Facebook alloc] initWithAppId:@"456469124379254" andDelegate:self];
            }
    return self;
}

- (void) shareOnFacebook:(NSString *)title url:(NSString *)url {

    NSArray *permissions= [[[NSArray alloc] initWithObjects:@"publish_stream",@"read_stream", nil] autorelease];
    [facebook authorize:permissions];
    
    shareUrl = [NSString stringWithString: url];
    shareTitle=[NSString stringWithString: title];
    
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    return [facebook handleOpenURL:url];
}

#pragma mark - FBSessionDelegate Methods
- (void)fbDidLogin {
    
    [facebook requestWithGraphPath:@"me" andDelegate:self];
    
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)fbDidNotLogin:(BOOL)cancelled{
    
}

/**
 * Called after the access token was extended. If your application has any
 * references to the previous access token (for example, if your application
 * stores the previous access token in persistent storage), your application
 * should overwrite the old access token with the new one in this method.
 * See extendAccessToken for more details.
 */
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt{
    
}

/**
 * Called when the user logged out.
 */
- (void)fbDidLogout{
    
}

/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)fbSessionInvalidated{
    
}



#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    
    
    NSString *uid = [result objectForKey:@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  uid, @"to",
                                   shareTitle, @"name",
                                   @"Check This Out!", @"caption",
                                   @"Wi-Fi Alliance", @"description",
                                   shareUrl,@"link",
                                   nil];
    //[facebook requestWithGraphPath:@"me/feed" andParams:params andDelegate:self];
    [facebook dialog:@"feed" andParams:params andDelegate:self];
}
@end
