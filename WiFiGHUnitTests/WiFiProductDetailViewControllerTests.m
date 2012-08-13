//
//  WiFiProductDetailViewControllerTests.m
//  Wi-Fi_IOS
//
//  Created by pavan krishna on 04/07/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//
#import <GHUnitIOS/GHUnit.h>
#import "WiFiProductDetailViewController.h"
#import "WiFiCertificationDetailsViewController.h"

@interface WiFiProductDetailViewControllerTests : GHViewTestCase
{
    WiFiProductDetailViewController *productDetail;
    UINavigationController *navigationController;
}
@end

@implementation WiFiProductDetailViewControllerTests

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
    productDetail = [[WiFiProductDetailViewController alloc] initWithNibName:@"WiFiProductDetailViewController" bundle:nil];
    UIView *view = productDetail.view;
    navigationController = [[UINavigationController alloc]initWithRootViewController:productDetail];
//    [productDetail loadView];
}

-(void)tearDownClass{
    [productDetail release];
}

-(void)testClickedCertificateButtonPushesNextPageViewController {
    GHAssertTrue([navigationController isMemberOfClass:[UINavigationController class]], @"bad nav controller");
    UIButton *button = productDetail.certificateButton;
//    NSLog(@"--->%d",button.tag);
    [button sendActionsForControlEvents:UIControlEventTouchDown];
//    NSLog(@"########%@&&&&&&&&&&&&&",[navigationController.visibleViewController class]);
    GHAssertTrue([navigationController.visibleViewController isMemberOfClass:[WiFiCertificationDetailsViewController class]], @"Does not navigate to WiFiCertificationDetailsViewController");
}

//-(void)testClickedInfoButtonPushesNextPageViewController {
//    GHAssertTrue([navigationController isMemberOfClass:[UINavigationController class]], @"bad nav controller");
//    UIButton *button = productDetail.infoButton;
//    //    NSLog(@"--->%d",button.tag);
//    [button sendActionsForControlEvents:UIControlEventTouchDown];
//    //    NSLog(@"########%@&&&&&&&&&&&&&",[navigationController.visibleViewController class]);
//    GHAssertTrue([navigationController.visibleViewController isMemberOfClass:[WiFiCertificationDetailsViewController class]], @"Does not navigate to WiFiCertificationDetailsViewController");
//}

@end
