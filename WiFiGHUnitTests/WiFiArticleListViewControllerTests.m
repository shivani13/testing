//
//  WiFiArticleListViewControllerTests.m
//  Wi-Fi_IOS
//
//  Created by pavan krishna on 04/07/12.
//  Copyright (c) 2012 Mutual Mobile. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "WiFiArticleListViewController.h"

@interface WiFiArticleListViewControllerTests : GHViewTestCase
{
    WiFiArticleListViewController *article;
}
@end

@implementation WiFiArticleListViewControllerTests

-(void)setUp{
    
   [super setUp]; 
    
}

-(void)tearDown{
    [super tearDown];
}

-(void)setUpClass{
    
    article = [[WiFiArticleListViewController alloc] initWithNibName:@"WiFiArticleListViewController" bundle:nil];
    [article loadView];
}

-(void)tearDownClass{
    [article release];
}

- (BOOL)shouldRunOnMainThread {
    return YES;
}

-(void) testArticleListViewControllerTableViewNotNil {
    GHAssertNotNil([article articleListTableView],@"articleListTableView is NIL");
}

- (void)testArticleListViewControllerTableViewNoOfSections {
    NSLog(@"***** Number of sections:%d",[article.articleListTableView numberOfSections]);
    GHAssertTrue([article.articleListTableView numberOfSections] == 1, @"Invalid number of sections");
}

- (void) testArticleListViewControllerTableViewNoOfRowsinsection {
    GHAssertTrue([article.articleListTableView numberOfRowsInSection:0] >= 0, @"Number of rows in a section for a tableview cannot be negative.");
}

-(void) testArticleListViewControllerSearchBarNotNil {
    GHAssertNotNil([article articleListSearchBar],@"articleList SearchBar is NIL");
}

@end
