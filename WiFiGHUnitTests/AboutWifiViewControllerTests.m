//
//  AboutWiFiViewControllerTests.m
//  Wi-Fi_IOS
//
//  Created by pavan krishna on 04/07/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "WiFiAboutWiFiViewController.h"

@interface AboutWifiViewControllerTests : GHViewTestCase
{
    WiFiAboutWiFiViewController *wiFi;
    UINavigationController *navigationController;
}
@end

@implementation AboutWifiViewControllerTests

-(void)setUp{
    
    [super setUp];
    
}

-(void)tearDown
{
    [super tearDown];
}

- (BOOL)shouldRunOnMainThread {
    return YES;
}

-(void)setUpClass{
    wiFi = [[WiFiAboutWiFiViewController alloc] initWithNibName:@"WiFiAboutWiFiViewController" bundle:nil];
    UIView *view = wiFi.view;
    navigationController = [[UINavigationController alloc]initWithRootViewController:wiFi];
    [wiFi loadView];
}

-(void)tearDownClass{
        [wiFi release];
}

-(void) testAboutWiFiViewControllerTableViewNotNil {
    GHAssertNotNil([wiFi aboutWiFiTableView],@"aboutWiFi Tableview is NIL");
}

- (void)testAboutWiFiViewControllerTableViewNoOfSections {
    NSLog(@"Num of sections:%d",[wiFi.aboutWiFiTableView numberOfSections]);
    GHAssertTrue([wiFi.aboutWiFiTableView numberOfSections] == 1, @"Invalid number of sections");
}

- (void) testAboutWiFiViewControllerTableViewNoOfRowsinsection {
    GHAssertTrue([wiFi.aboutWiFiTableView numberOfRowsInSection:0] >= 0, @"Number of rows in a section for a tableview cannot be negative.");
}

//-(void)testClickedCellPushesNextPageViewController {
//    GHAssertTrue([navigationController isMemberOfClass:[UINavigationController class]], @"bad nav controller");
//    NSIndexPath *indexpath = [[NSIndexPath alloc] init];
//    UITableViewCell *tableCell = wiFi.    
////    
////    UIButton *button = viewController.click;
////    [button sendActionsForControlEvents:UIControlEventTouchDown];
////    GHAssertTrue([navigationController.visibleViewController isMemberOfClass:[NextPageViewController class]], @"Does not navigate to NextPageViewController");
//}

//- (void)testAboutWiFiViewControllerTableViewCellForRowAtIndexPath {
//    
//    NSIndexPath *indexpath = [[NSIndexPath alloc] init];
//    
//    NSLog(@"Class is : %@",[[wiFi.aboutWiFiTableView cellForRowAtIndexPath:indexpath] class]);
//    
//    GHAssertTrue([[wiFi.aboutWiFiTableView cellForRowAtIndexPath:indexpath] isMemberOfClass:[UITableViewCell class]], @"Returned cell is Invalid");
//}

-(void) testAboutWiFiViewControllerSearchBarNotNil {
    GHAssertNotNil([wiFi aboutWifiSearchBar],@"aboutWiFi SearchBar is NIL");
}




@end
