//
//  WiFiArticleDetailViewControllerTests.m
//  Wi-Fi_IOS
//
//  Created by pavan krishna on 04/07/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "WiFiArticleDetailViewController.h"

@interface WiFiArticleDetailViewControllerTests : GHViewTestCase
{
    WiFiArticleDetailViewController *detailArticle;
//    UIView *testView;
    
}
@end

@implementation WiFiArticleDetailViewControllerTests

-(void)setUp{
    [super setUp]; 
    
}

- (BOOL)shouldRunOnMainThread {
    return YES;
}

-(void)tearDown{
    [super tearDown];
}

-(void)setUpClass{
    detailArticle = [[WiFiArticleDetailViewController alloc] initWithNibName:@"WiFiArticleDetailViewController" bundle:nil];
    [detailArticle view];
//    testView = detailArticle.view;
}

-(void)tearDownClass{
    [detailArticle release];
//    [testView release];
}

//- (void)testWiFiArticleDetailViewController{
//    GHVerifyView(testView);
//}

//-(void) testWiFiArticleDetailViewControllerWebViewNotNil {
//    GHAssertNotNil([detailArticle articleDetailsWebView],@"articleDetailsWebView is NIL");
//}
//
//
//   

-(void) testShareButtonAction {
    UIBarButtonItem *shareButton = [[detailArticle navigationItem] rightBarButtonItem];
    NSLog(@"*******Select for share Button %@",NSStringFromSelector([shareButton action]));
    GHAssertTrue([NSStringFromSelector([shareButton action]) isEqualToString:@"showActionSheet:"],@"share Button actions doesn't contain showActionSheet");
}

- (void)testfavoriteArticleButton{
    UIButton *favButton = detailArticle.favoriteArticleButton;
    GHAssertNotNil(detailArticle.favoriteArticleButton,@"favoriteArticleButton is nil");
    NSArray *actions = [favButton actionsForTarget:detailArticle forControlEvent:UIControlEventTouchDown];
    GHAssertTrue([actions containsObject:@"favoriteButtonClicked:"],@"Action method Not Exists");
    actions = nil;
}


@end
