//
//  AppDelegate.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/7/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiAppDelegate.h"

#import "WiFiViewController.h"
#import "WiFiAboutWiFiViewController.h"
#import "WiFiProductViewController.h"
#import "WiFiUtilities.h"
#import "WiFiFavoriteViewController.h"
#import "WiFiInformationViewController.h"


@implementation WiFiAppDelegate

@synthesize window = _window;
@synthesize wiFiViewController = wiFiViewController_;
@synthesize tabBarController = tabBarController_;

- (void)dealloc
{
    [_window release];
    [wiFiViewController_ release];
    [tabBarController_ release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Establishing connection with Sqlite using Magical Record. This will setup core data stack
    
    [MagicalRecordHelpers setupCoreDataStackWithStoreNamed:@"MyDatabase.sqlite"];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    UIViewController *aboutWifiViewController= [[[WiFiAboutWiFiViewController alloc] initWithNibName:@"WiFiAboutWiFiViewController" bundle:nil] autorelease];
    UINavigationController *aboutWifiNavController=[[[UINavigationController alloc] initWithRootViewController:aboutWifiViewController] autorelease];
    aboutWifiViewController.tabBarItem.image=[UIImage imageNamed:@"wifi.png"];
   
    
    UIViewController *productsViewController= [[[WiFiProductViewController alloc] initWithNibName:@"WiFiProductViewController" bundle:nil]autorelease];
    UINavigationController *productsNavController=[[[UINavigationController alloc] initWithRootViewController:productsViewController] autorelease];
    productsViewController.tabBarItem.image=[UIImage imageNamed:@"product.png"];
    productsViewController.tabBarItem.title=@"Products";
    
    UIViewController *favoriteViewController= [[[WiFiFavoriteViewController alloc] initWithNibName:@"WiFiFavoriteViewController" bundle:nil]autorelease];
    UINavigationController *favoriteNavController=[[[UINavigationController alloc] initWithRootViewController:favoriteViewController] autorelease];
    favoriteViewController.tabBarItem.image=[UIImage imageNamed:@"favorite.png"];
    favoriteViewController.tabBarItem.title=@"Favorites";
    
    UIViewController *informationViewController= [[[WiFiInformationViewController alloc] initWithNibName:@"WiFiInformationViewController" bundle:nil]autorelease];
    UINavigationController *informationNavController=[[[UINavigationController alloc] initWithRootViewController:informationViewController] autorelease];
    informationViewController.tabBarItem.image=[UIImage imageNamed:@"info.png"];
    informationViewController.tabBarItem.title=@"Info";
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers= [NSArray arrayWithObjects:aboutWifiNavController, productsNavController,favoriteNavController,informationNavController,nil];
    
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    // Clearing all Magical record objects by releasing and nullifying data
    
    [MagicalRecordHelpers cleanUp];
    
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [[WiFiUtilities sharedInstance] handleOpenUrl:url];  
    
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [[WiFiUtilities sharedInstance] handleOpenUrl:url];  
    
}

@end
