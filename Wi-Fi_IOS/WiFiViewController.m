//
//  ViewController.m
//  Wi-Fi_IOS
//
//  Created by Pavan Paruchuri on 5/7/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import "WiFiViewController.h"

@interface WiFiViewController ()

@end

@implementation WiFiViewController
@synthesize wifiTabBar;
@synthesize aboutWiFi;
@synthesize products;
@synthesize favorites;
@synthesize info;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [wifiTabBar setSelectedItem:aboutWiFi];
//    aboutWiFi.tag =1;
//    [self aboutWifiPressed];
    //[aboutWiFi performSelector:@selector(aboutWifiPressed)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setAboutWiFi:nil];
    [self setProducts:nil];
    [self setFavorites:nil];
    [self setInfo:nil];
    [self setWifiTabBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    if (item ==1) {
//        [self aboutWifiPressed];
//    }
//    
//}
-(void)aboutWifiPressed{
    NSLog(@"About Wifi Pressed");
}

- (void)dealloc {
    [aboutWiFi release];
    [products release];
    [favorites release];
    [info release];
    [wifiTabBar release];
    [super dealloc];
}
@end
