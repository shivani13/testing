//
//  MMViewController.h
//  WFProductsCategories
//
//  Created by Abhyuday Reddy on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WiFiProductsHeaderView.h"
#import "WiFiFilterViewController.h"

@interface WiFiProductViewController : UIViewController <HeaderViewDelegate,FilterDelegate>{
    NSMutableArray *productCategoryArray_;
    NSMutableArray *jsonArray_;
    NSString *filterText_;
    WiFiProductsHeaderView *headerView_;
    NSMutableArray *expandedHeadersArray;
}

@property (nonatomic, retain) IBOutlet WiFiProductsHeaderView *headerView;
@property (nonatomic, retain) NSMutableArray *expandedHeadersArray;

@property (nonatomic, retain) IBOutlet UITableView *productCategoryTable;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBarField;
- (void) gotoFilter;
- (void) productCategory:(NSString *) url;
- (void) setTheUrl:(NSString *) newUrl;
@end
